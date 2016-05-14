<%--诗词推荐--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />

<div class="row">
    <form action="${pageContext.request.contextPath}/recommend/add.action">
        <div class="col-xs-10 col-xs-offset-1">
            <div class="input-group">
                <span class="input-group-addon">题目:</span>
                <input type="text" class="form-control" name="srec_title">
            </div>
            <br>
            <div class="input-group">
                <span class="input-group-addon">作者:</span>
                <input type="text" class="form-control" name="srec_auth">
            </div>
            <br>
            <textarea name="srec_content" placeholder="诗词正文" class="weui_textarea" rows="4"></textarea>
            <br>
            <textarea name="srec_reson" placeholder="赏析" class="weui_textarea"></textarea>
            <br>
            <input type="submit" class="btn btn-primary btn-block" value="提交推荐">
        </div>
    </form>
</div>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>
