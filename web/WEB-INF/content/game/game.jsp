<%--游戏首页--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/content/shared/layoutHead.jsp" />

<div class="row">
    <div class="col-xs-8 col-xs-offset-2">
        <a href="${pageContext.request.contextPath}/game/answer/index.action"><button class="btn btn-success btn-block">诗词问答</button></a><br>
        <a href="${pageContext.request.contextPath}/game/wrong/index.action"><button class="btn btn-success btn-block">诗词找错</button></a><br>
        <a href="${pageContext.request.contextPath}/game/round/index.action"><button id="round" class="btn btn-success btn-block">诗词接龙</button></a><br>
        <div class="sc-tran-panel" id="userNumber">当前用户数量: </div>
    </div>
</div>

<jsp:include page="/WEB-INF/content/shared/layoutFoot.jsp"/>
<script src="${pageContext.request.contextPath}/support/js/js-onepoetry-people-numbers.js"></script>

<script>
    $("#round").click(function(){
        startGame();
    });
</script>