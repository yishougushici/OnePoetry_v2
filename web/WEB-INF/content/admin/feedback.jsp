<%--查看用户反馈--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminHead.jsp" />

    <div id="page">
        反馈内容
    </div>

<script src="${pageContext.request.contextPath}/support/js/jqPaginator.min.js"></script>
<script>
    $(document).ready(function () {
        $("#page").jqPaginator('option', {
            currentPage: 1
        });
    })
</script>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminFoot.jsp"/>
