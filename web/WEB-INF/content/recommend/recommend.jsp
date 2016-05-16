<%--诗词推荐--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />

<div class="row">
    <form action="javascript:sendRecomend();">
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
<div class="suggess-bg" hidden="hidden">
    <div class="suggess">
        <div class="suggess-header"><span class="glyphicon glyphicon-info-sign">提示</span><hr></div>
        <div class="suggess-body">    $(".suggess-body").text("诗词推荐成功, 小编将选择合适的诗词推送!");</div>
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
                    $(".suggess-body").text("诗词推荐成功, 小编将选择合适的诗词推送!");
                    $(".suggess-bg").show();
                    setTimeout(function () {
                        $(".suggess-bg").hide();
                    },3000);
                }
                else{
                    $(".suggess-header").text("失败!")
                    $(".suggess-body").text(data);
                    $(".suggess-bg").show();
                    setTimeout(function () {
                        $(".suggess-bg").hide();
                    },3000);
                }
            },
            error:function(msg){
                $(".suggess-header").text("服务器错误!")
                $(".suggess-body").text(msg);
                $(".suggess-bg").show();
                setTimeout(function () {
                    $(".suggess-bg").hide();
                },5000);
            },
        });
    }
    $("form").validate({
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