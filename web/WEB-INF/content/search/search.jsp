<%--诗词查询--%>
<%
    response.setHeader("Access-Control-Allow-Origin", "*");
%>
<link rel="stylesheet" href="/support/css/search.css">
<link rel="stylesheet" href="/support/select/demo.css">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />

<div class="row">
    <div class="col-xs-10 col-xs-offset-1">
        <div class="input-group">
            <input type="text" class="form-control" name="shici">
            <div class="input-group-addon" id="sc-search-bar">
                <span class="glyphicon glyphicon-search btn-user"></span>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div id="sc-styles">
        <fieldset class="radios">
            <label for="sc_num" class="label_radio">
                <input id="sc_num" type="radio" name="sctype" value="期号">期号
            </label>
            <label for="sc_title" class="label_radio">
                <input id="sc_title"  type="radio" name="sctype" value="诗词">题目
            </label>
            <label for="sc_auth" class="label_radio">
                <input id="sc_auth" type="radio" name="sctype" value="作者">作者
            </label>
            <label for="sc_content" class="label_radio">
                <input id="sc_content" type="radio" name="sctype" value="内容">内容
            </label>
            <label for="sc_all" class="label_radio">
                <input id="sc_all" type="radio" name="sctype" value="all" checked="checked">模糊查询
            </label>
        </fieldset>
        </div><br><br>
        <div id="loadingToast" class="weui_loading_toast" style="display:none;">
            <div class="weui_mask_transparent"></div>
            <div class="weui_toast">
                <div class="weui_loading">
                    <div class="weui_loading_leaf weui_loading_leaf_0"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_1"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_2"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_3"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_4"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_5"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_6"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_7"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_8"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_9"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_10"></div>
                    <div class="weui_loading_leaf weui_loading_leaf_11"></div>
                </div>
                <p class="weui_toast_content">数据加载中</p>
            </div>
        </div>
        <div class="showShici"></div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>
<script src="/support/select/select.js"></script>
<script>
    $("#sc-search-bar").click(function(){
        $(".showShici").children().remove();
        var s_data = $("input[name='shici']").val();
        var s_type = $("input[name='sctype']:radio:checked").val();
        $.ajax({
            type: "post",
            url: "result.action",
            data: {"s_data":s_data, "s_type":s_type},
            beforeSend: function(){
                $("#loadingToast").show();
            },
            complete: function(){
                $("#loadingToast").hide();
            },
            success: function(data){
                var div = $("<div></div>");
                div.append(data);
                $(".showShici").append(div);
                $("#toast").show();
                setTimeout(function(){
                    $("#toast").hide();
                },600);
            },
        });
    });
</script>