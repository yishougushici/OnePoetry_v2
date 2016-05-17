<%--诗词推荐--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />

<div class="row">
    <form action="javascript:sendRecomend();">
        <div class="col-xs-10 col-xs-offset-1">
            <div class="input-group">
                <span class="input-group-addon">题目:</span>
                <input type="text" class="form-control" name="srec_title" id="srec_title">
            </div>
            <span class="errinfo" for="srec_title"></span>
            <br>
            <div class="input-group">
                <span class="input-group-addon">作者:</span>
                <input type="text" class="form-control" name="srec_auth" id="srec_auth">
            </div>
            <span class="errinfo" for="srec_auth"></span>
            <br>
            <textarea name="srec_content" id="srec_content" placeholder="诗词正文" class="weui_textarea" rows="4"></textarea>
            <span class="errinfo" for="srec_content"></span>
            <br>
            <textarea name="srec_reson" placeholder="赏析" class="weui_textarea"></textarea>
            <br>
            <input type="submit" class="btn btn-primary btn-block" value="提交推荐">
        </div>
    </form>
</div>

<div class="weui_dialog_alert" hidden="hidden" id="suggest-bg">
    <div class="weui_mask"></div>
    <div class="weui_dialog">
        <div class="weui_dialog_hd"><strong class="weui_dialog_title" id="suggest-header">提示</strong></div>
        <div class="weui_dialog_bd" id="suggest-body">弹窗内容，告知当前页面信息等</div>
    </div>
</div>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>
<script>
    function sendRecomend(){
//        console.log("srec_title"+$("input[name=srec_title]").val());
//        console.log("srec_auth"+$("input[name=srec_auth]").val());
//        console.log("srec_content"+$("input[name=srec_content]").val());
//        console.log("srec_reson"+$("input[name=srec_reson]").val());
        $.ajax({
            url:"add.action",
            type:"post",
            data:{
                "srec_title":$("input[name=srec_title]").val(),
                "srec_auth":$("input[name=srec_auth]").val(),
                "srec_content":$("textarea[name=srec_content]").val(),
                "srec_reson":$("textarea[name=srec_reson]").val()
            },
            success:function(data){
                if(data == "成功"){
                    $("#suggest-body").text("诗词推荐成功, 小编将选择合适的诗词推送!");
                    $("#suggest-bg").show();
                    setTimeout(function () {
                        $("#suggest-bg").hide();
                    },3000);
                }
                else{
                    $("#suggest-header").text("失败!")
                    $("#suggest-body").text(data);
                    $("#suggest-bg").show();
                    setTimeout(function () {
                        $("#suggest-bg").hide();
                    },3000);
                }
            },
            error:function(msg){
                $("#suggest-header").text("服务器错误!")
                $("#suggest-body").text(msg);
                $("#suggest-bg").show();
                setTimeout(function () {
                    $("#suggest-bg").hide();
                },5000);
            },
        });
    }
    $("form").validate({
        errorElement: "span",
        errorPlacement:function(error,element){
            $( element )
                    .closest( "form" )
                    .find( "span[for='" + element.attr( "id" ) + "']")
                    .append( error );
        },
       rules:{
           srec_title: {required: true},
           srec_auth: {required: true},
           srec_content:{required:true},
           srec_reson:{required:true}
       },
        messages:{
            srec_title: {required: "请输入诗词题目"},
            srec_auth: {required: "请输入诗词作者"},
            srec_content:{required:"请输入诗词正文"},
            srec_reson:{required:"请输入诗词点评"}
        }
    });
</script>