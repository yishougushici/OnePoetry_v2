<%--诗词问答--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/game.css">
<div class="row">
    <div class="col-xs-10 col-xs-offset-1">
        <div class="ans-num" style="display: none">0</div>连击&emsp;最大连击:<div class="maxcombo"></div>
        <div class="jumbotron">
            <div class="ans-title">
                <div class="game-start"><img src="${pageContext.request.contextPath}/support/image/game-start.png" alt=""></div>
            </div>
            <div class="ans-info"></div>
        </div>
        剩余答题时间: <div id="timer" style="display:inline;"></div>
    </div>
</div>
<div class="row" id="ans-submit" style="display: none">
    <div class="col-xs-10 col-xs-offset-1">
        <div class="input-group">
            <input type="text" name="sa_tail" class="form-control" aria-describedby="ans_send">
            <span class="input-group-btn" id="ans_send"><button class="btn btn-success"><span class="glyphicon glyphicon-send"></span></button></span>
        </div>
    </div>
    <div id="ans-next" class="ans-next">
        <img class="game-img-btn" src="${pageContext.request.contextPath}/support/image/next.png" alt="跳过">
        下一题
    </div>
</div>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/dialogPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadingPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>
<script src="${pageContext.request.contextPath}/support/js/timeCount.js"></script>
<script>
    var score = 0;
    var maxscore=0;
    //开始游戏
    $(".game-start").click(function(){
        $(this).hide();
        $("#ans-submit").show();
        $(".ans-num").show();
        renderQuestion();
    });
    $("#ans-next").click(function(){renderQuestion()});
    $("#ans_send").click(function(){sendAnswer();});
    $("#ans_send").keypress(function(){sendAnswer();});

    //发送答案
    function sendAnswer(){
        var scAnswer = $("input[name=sa_tail]").val();
        clearTimer();
        $.ajax({
            url:"answer/submitAnswer",
            type:"post",
            data:{"sa_tail":scAnswer},
            beforeSend:function(){
                $("#loading-content").text("正在提交")
                $("#loadingToast").show()
            },
            complete:function(){
                $("#loadingToast").hide()
            },
            success:function(data){
                if(data.result==true){
                    $("input[name=sa_tail]").val("");
                    $(".ans-num").text(++score);
                    maxscore = (maxscore>score) ? maxscore : score;
                    $(".maxcombo").text(maxscore);
                    renderQuestion();
                    $(".sc-score").text(data.score);
                }else{
                    $("#suggest-body").text("回答错误, 您可以继续答题");
                    $("#suggest-bg").show();
                    setTimeout(function(){
                        $("#suggest-bg").hide();
                        score=0;
                        $(".ans-num").text(score);
                        setTimer($("#timer").text(),"timer",function(){
                            $("#suggest-body").text("回答超时");
                            $("#suggest-bg").show();
                            setTimeout(function(){
                                $("#suggest-bg").hide();
                                return;
                            },1000);
                        });
                    },2500);
                }
            }
        });
    }


    //请求问题, 无参, 返回一句诗词(上半句)
    function renderQuestion(){
        $.ajax({
            url:"answer/getQuestion",
            type:"post",
            beforeSend:function(){
                $("#loading-content").text("请求中")
                $("#loadingToast").show()
            },
            complete:function(){
                $("#loadingToast").hide();
                $("#timer").text("");
            },
            success:function(data){
                console
                if(data.error!=undefined){
                    $("#suggest-body").text(data.error);
                    $("#suggest-bg").show();
                    setTimeout(function(){
                        $("#suggest-bg").hide();
                        return;
                    },3000);
                }
                $(".ans-title").text(data.sa_head);
                $(".ans-info").text(data.sa_author+"  "+data.sa_title)
                setTimer(50,"timer",function(){
                    $("#suggest-body").text("回答超时");
                    $("#suggest-bg").show();
                    setTimeout(function(){
                        $("#suggest-bg").hide();
                        return;
                    },1000);
                });
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