<%--诗词问答--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/game.css">
<div class="row">
    <div class="col-xs-10 col-xs-offset-1">
        <div class="jumbotron">
            <div class="ans-num">
                10
            </div>
            <div class="ans-title">
                欲穷千里目
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-xs-10 col-xs-offset-1">
        <div class="input-group">
            <input type="text" name="sa_tail" class="form-control" aria-describedby="ans_send">
            <span class="input-group-btn" id="ans_send"><button class="btn btn-success"><span class="glyphicon glyphicon-send"></span></button></span>
        </div>
    </div>
</div>


<script>
    $("#ans_send").click(function(){
        alert("点击发送");
    });
</script>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>