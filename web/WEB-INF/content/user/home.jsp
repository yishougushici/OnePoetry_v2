<%--首页--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/content/shared/layoutHead.jsp" />
<script>
    $(".sc-title").remove();
</script>
<p>&nbsp;</p>
<div class="row">
    <div class="col-xs-8 col-xs-offset-2">
        <a href="${pageContext.request.contextPath}/search/index.action">
            <button class="btn btn-success btn-block">
                <span class="glyphicon glyphicon-search"></span>&emsp;诗词查询
            </button>
        </a>
        <br>
        <a href="${pageContext.request.contextPath}/game/index.action">
            <button class="btn btn-info btn-block">
                <span class="glyphicon glyphicon-fire"></span>&emsp;诗词游戏
            </button>
        </a>
        <br>
        <a href="${pageContext.request.contextPath}/recommend/index.action">
            <button class="btn btn-success btn-block">
                <span class="glyphicon glyphicon-comment"></span>&emsp;诗词推荐
            </button>
        </a>
        <br>
        <a href="${pageContext.request.contextPath}/original/index.action">
            <button class="btn btn-success btn-block">
                <span class="glyphicon glyphicon-comment"></span>&emsp;原创投稿
            </button>
        </a>
        <br>
    </div>
</div>
<div class="sc-logo">
    <img src="${pageContext.request.contextPath}/support/image/qrCode.png" alt="二维码">
</div>
<div class="row" style="text-align: center">公众号二维码</div>

<jsp:include page="/WEB-INF/content/shared/layoutFoot.jsp"/>