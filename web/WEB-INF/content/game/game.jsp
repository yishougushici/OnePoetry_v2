<%--游戏首页--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />

<div class="row">
    <div class="col-xs-8 col-xs-offset-2">
        <a href="${pageContext.request.contextPath}/game/answer.action"><button class="btn btn-success btn-block">诗词问答</button></a><br>
        <a href="${pageContext.request.contextPath}/game/wrong.action"><button class="btn btn-success btn-block">诗词找错</button></a><br>
        <a href="${pageContext.request.contextPath}/game/round.action"><button class="btn btn-success btn-block">诗词接龙</button></a><br>
    </div>
</div>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>