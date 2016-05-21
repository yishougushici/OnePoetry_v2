<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />
 <link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/game.css">
 <div class="row">
     <div class="col-xs-10 col-xs-offset-1">
         <div class="jumbotron">
             <div class="err-elem-container">
                 <div class="game-start"><img src="${pageContext.request.contextPath}/support/image/game-start.png" alt=""></div>
             </div>
         </div>
         <div class="option" hidden="hidden">
             <button class="btn btn-block btn-success" id="submit">确定</button>
         </div>
     </div>
 </div>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>

<script>
    console.log("game start");
    function renderElement(elem){
        for(var i=0; i<elem.length; i++){
            var elembg = $('<div class="err-elem-bg"></div>');
            var div = $("<div></div>");
            elembg.append(div);
            div.addClass("err-elem");
            div.append(elem[i])
            $(".err-elem-container").append(elembg);
        }
    }

    $(".game-start").click(function(){
        $(this).hide();
//添加游戏数据加载事件
        var elem = ["西","风","扬","子","江","边","柳"];
        renderElement(elem);
        $(".option").show();
        $(".err-elem").on("click",function(){
            $("#err-elem-seleted").removeAttr("id");
            var keyword = $(this).text();
            $(this).attr("id","err-elem-seleted");
        });
    });

    $("#submit").click(function(){
        var keyword = $("#err-elem-seleted").text();
//添加游戏事件
    });
</script>