<%--诗词推荐--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />

<div class="row">
    <form action="add">
        <div class="col-xs-10 col-xs-offset-1">
            <div class="input-group">
                <span class="input-group-addon">题目:</span>
                <input type="text" class="form-control" id="sorin_title" name="sorin_title">
            </div>
            <span for="sorin_title"></span>
            <br>
            <div class="input-group">
                <span class="input-group-addon">昵称:</span>
                <input type="text" class="form-control" id="sorin_auth" name="sorin_auth">
            </div>
            <span for="sorin_auth"></span>
            <br>
            <textarea name="sorin_content" id="sorin_content" placeholder="诗词正文" class="weui_textarea" rows="4"></textarea>
            <span for="sorin_content"></span>
            <br>
            <input type="submit" class="btn btn-primary btn-block" value="提交推荐">
        </div>
    </form>
</div>
<div class="weui_dialog_alert" id="suggest-bg">
    <div class="weui_mask"></div>
    <div class="weui_dialog">
        <div class="weui_dialog_hd"><strong class="weui_dialog_title" id="suggest-header">提示</strong></div>
        <div class="weui_dialog_bd" id="suggest-body">弹窗内容，告知当前页面信息等</div>
        <div class="weui_dialog_ft">
            3秒后弹窗消息
        </div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>
<script>


    $("form").validate({
        errorElement: "span",
        errorPlacement: function (error, element) {
            $(element)
                    .closest("form")
                    .find("span[for='" + element.attr("id") + "']")
                    .append(error);
        },
        rules: {
            sorin_title: {required: true},
            sorin_auth: {required: true},
            sorin_content: {required: true},
        },
        messages: {
            sorin_title: {required: "请输入诗词题目"},
            sorin_auth: {required: "请输入您的昵称/笔名"},
            sorin_content: {required: "请输入诗词正文"},
        }
    });
</script>
