<%--首页--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />

<div class="row">
    <div class="col-xs-8 col-xs-offset-2">
        <a href="/search/index.action"><button class="btn btn-success btn-block">诗词查询</button></a><br><!--TODO:这里被我改了-->
        <a href="/scgame.jsp"><button class="btn btn-success btn-block">诗词游戏</button></a><br>
        <a href="/recomend.jsp"><button class="btn btn-success btn-block">诗词推荐</button></a><br>
        <a href="/original.jsp"><button class="btn btn-success btn-block">原创投稿</button></a><br>
    </div>
</div>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>