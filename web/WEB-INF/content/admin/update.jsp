<%--录入诗词:更新数据--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminHead.jsp" />

<form action="UpdateHis">
    <div class="row">
        <div class="col-xs-10 col-xs-offset-1">
            <div class="input-group">
                <span class="input-group-addon">期号:</span>
                <input type="text" class="form-control" name="期号">
            </div>
            <div class="input-group">
                <span class="input-group-addon">题目:</span>
                <input type="text" class="form-control" name="诗词">
            </div>
            <div class="input-group">
                <span class="input-group-addon">作者:</span>
                <input type="text" class="form-control" name="作者">
            </div>
            <div class="input-group">
                <span class="input-group-addon">日期:</span>
                <input type="date" class="form-control" name="日期">
            </div>
            正文: <textarea name="内容" class="weui_textarea" rows="4"></textarea>

            <br>
            <input type="submit" value="提交" class="btn btn-primary">
            &emsp;
            <input type="reset" value="清空" class="btn btn-warning">
        </div>
    </div>
</form>



<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminFoot.jsp"/>