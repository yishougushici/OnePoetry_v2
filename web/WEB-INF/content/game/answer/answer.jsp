<%--诗词问答--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/game.css">
<div class="row">
    <div class="col-xs-10 col-xs-offset-1">
        <div class="jumbotron">
            <div class="ans-num" style="display: none">0</div>
            <div class="ans-title">
                <div class="game-start"><img src="${pageContext.request.contextPath}/support/image/game-start.png" alt=""></div>
            </div>
        </div>
    </div>
</div>
<div class="row" id="ans-submit" style="display: none">
    <div class="col-xs-10 col-xs-offset-1">
        <div class="input-group">
            <input type="text" name="sa_tail" class="form-control" aria-describedby="ans_send">
            <span class="input-group-btn" id="ans_send"><button class="btn btn-success"><span class="glyphicon glyphicon-send"></span></button></span>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/dialogPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadingPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>

<script>
    var score = 0;
    function renderQuestion(){
        $.ajax({
            url:"answer/start",
            type:"post",
            beforeSend:function(){$("#loadingToast").show()},
            complete:function(){$("#loadingToast").hide()},
            success:function(data){
                $(".ans-title").text(data);
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
    $(".game-start").click(function(){
        $(this).hide();
        $("#ans-submit").show();
        $(".ans-num").show();
        renderQuestion();
    });


    $("#ans_send").click(function(){
        $.ajax({
            url:"answer",
            type:"post",
            data:{"sa_tail":$("input[name=sa_tail]").val()},
            beforeSend:function(){$("#loadingToast").show()},
            complete:function(){$("#loadingToast").hide()},
            success:function(data){
                if(data=="成功"){
                    $(".ans-num").val(++score);
                    renderQuestion();
                }else{
                    $("#suggest-body").text(msg);
                    $("#suggest-bg").show();
                    setTimeout(function(){
                        $("#suggest-bg").hide();
                    },3000);
                }
            }
        });
    });
</script>