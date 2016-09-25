<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/content/shared/layoutHead.jsp" />
 <link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/game.css">

 <div class="row">
     <div class="col-xs-10 col-xs-offset-1">
         连击:<div class="err-num">0</div>&emsp;最大连击:<div class="maxcombo">0</div>
         <div class="row">
             <div class="col-xs-6">
                 <hr></div>
         </div>

         <div class="alert alert-dismissible">
             <div class="err-elem-container">
                 <div class="game-start"><img src="${pageContext.request.contextPath}/support/image/game-start.png" alt=""></div>
             </div>
             <div class="ans-info"></div>
         </div>

         <div class="option" hidden="hidden">
             <button class="btn btn-block btn-success" id="submit">确定</button>
         </div>
     </div>
 </div>

<jsp:include page="/WEB-INF/content/shared/layoutFoot.jsp"/>
<jsp:include page="/WEB-INF/content/shared/loadingPage.jsp"/>
<jsp:include page="/WEB-INF/content/shared/dialogPage.jsp"/>

<script>
    var score = 0;
    var maxscore = 0;
    $(".game-start").click(function(){
        $(this).hide();
        renderQuestion();
        //  $(".option").show();
        $(".err-num").show();
        $(".err-elem").on("click",function(){
            $("#err-elem-seleted").removeAttr("id");
            var keyword = $(this).text();
            $(this).attr("id","err-elem-seleted");
        });
    });

    $(".err-elem-container").on("click",".err-elem-bg .err-elem",function(){
        $("#err-elem-seleted").removeAttr("id");
        var keyword = $(this).text();
        $(this).attr("id","err-elem-seleted");
        $("#submit").click();
    });

    $("#submit").click(function(){
//        var keyword = $("#err-elem-seleted").text();
//        var dataIndex = $("#err-elem-seleted").attr("data-index");
//        console.log(keyword+"---"+dataIndex);
        submitAnswer();
//添加游戏事件
    });

    function submitAnswer(){
        var dataIndex = $("#err-elem-seleted").attr("data-index");
        $.ajax({
            url:"wrong/submitAnswer",
            type:"post",
            data:{"serr_err_location":dataIndex},
            beforeSend:function(){$("#loadingToast").show()},
            success:function(data){
                $("#loadingToast").hide();
                if(data.result==true){
                    $(".err-num").text(++score);
                    maxscore = Math.max(score,maxscore);
                    $(".maxcombo").text(maxscore);
                    renderQuestion();
                    $(".err-elem-container").children().remove(".err-elem-bg");
                    $(".sc-score").text(data.score);
                }else{
                    $("#suggest-body").text("回答错误");
                    $(".sc-score").text(data.score);
                    score = 0;
                    $(".err-num").text(score);
                    $("#suggest-bg").show();
                    setTimeout(function(){
                        $("#suggest-bg").hide();
                    },1000);
                }
            }
        });
    }

    //渲染题目, elem是一个数组
    function renderElement(elem){
        for(var i=0; i<elem.length; i++){
            var elembg = $('<div class="err-elem-bg"></div>');
            var div = $("<div></div>");
            elembg.append(div);
            div.addClass("err-elem");
            div.attr("data-index",i);
            div.append(elem[i]);
            $(".err-elem-container").append(elembg);
        }
    }

    //请求问题, 无参, 返回一句诗词(上半句)
    function renderQuestion(){
        $.ajax({
            url:"wrong/getQuestion",
            type:"post",
            beforeSend:function(){$("#loadingToast").show()},
            complete:function(){$("#loadingToast").hide()},
            success:function(data){
                if(data.error!=undefined){
                    $("#suggest-body").text(data.error);
                    $("#suggest-bg").show();
                    setTimeout(function(){
                        $("#suggest-bg").hide();
                        return;
                    },3000);
                }
                //数据没有错
                renderElement(data.serr_content);
                $(".and-info").text(data.serr_author+"  "+data.serr_title)
            },
            error: function (msg) {
                $("#suggest-body").text(msg);
                $("#suggest-bg").show();
                setTimeout(function(){
                    $("#suggest-bg").hide();
                },3000);
            }
        });
    }
</script>