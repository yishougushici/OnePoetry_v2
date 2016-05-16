<%--处理诗词推荐--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminHead.jsp" />
<div class="row">
    <div class="col-xs-10 col-xs-offset-1">
        <div class="panel panel-success">
            <div class="panel-heading">
                <div class = "sc-heading">
                    <div class="sc-title">
                        题目
                    </div>
                    <div class="sc-author">
                        作者
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="sc-body">
                    正文
                </div>
                <div class="panelfooter">
                    日期
                </div>
            </div>
            <div class="panel-footer">
                赏析
            </div>
        </div>
        <div class="btn-group btn-group-justified" role="group" aria-label="...">
            <div class="btn-group" role="group">
                <a href="#"><button type="button" class="btn btn-default">上一条</button></a>
            </div>
            <div class="btn-group" role="group">
                <a href="#"><button type="button" class="btn btn-default">通过</button></a>
            </div>
            <div class="btn-group" role="group">
                <a href="#"><button type="button" class="btn btn-default">下一条</button></a>
            </div>
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminFoot.jsp"/>


