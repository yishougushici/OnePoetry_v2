<%--管理员首页首页--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/content/shared/layoutAdminHead.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/admin.css">
<div class="row">
    <div class="col-xs-8 col-xs-offset-2 admin-btn">
        <a href="${pageContext.request.contextPath}/admin/feedback.action"><button class="btn btn-success btn-block">查看反馈</button></a><br>
        <a href="${pageContext.request.contextPath}/admin/recommend.action"><button class="btn btn-success btn-block">查看推荐</button></a><br>
        <a href="${pageContext.request.contextPath}/admin/original.action"><button class="btn btn-success btn-block">查看原创</button></a><br>
        <a href="${pageContext.request.contextPath}/admin/update.action"><button class="btn btn-success btn-block">录入诗词</button></a><br>
    </div>
</div>

<jsp:include page="/WEB-INF/content/shared/layoutAdminFoot.jsp"/>