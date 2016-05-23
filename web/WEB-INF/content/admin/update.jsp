<%--录入诗词:更新数据--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminHead.jsp" />
<form action="javascript:submitHis();" method="post">
    <div class="row">
        <div class="row">
                <div class="col-xs-12">
                <div class="col-xs-3 admin-listlab">期号:</div>
                <div class="col-xs-9"><input type="number" class="form-control" name="期号"></div>
                <div class="col-xs-3 admin-listlab">题目:</div>
                <div class="col-xs-9"><input type="text" class="form-control" name="诗词"></div>
                <div class="col-xs-3 admin-listlab">作者:</div>
                <div class="col-xs-9"><input type="text" class="form-control" name="作者"></div>
                <div class="col-xs-3 admin-listlab">日期:</div>
                <div class="col-xs-9"><input type="date" class="form-control" name="日期"></div>
                <div class="col-xs-3 admin-listlab">正文:</div>
                <div class="col-xs-9"><textarea name="内容" class="weui_textarea" rows="4"></textarea></div>
            </div>
        </div>
        <br>
        <div style="text-align: center;">
            <div class="col-xs-6">
                <input type="submit" id="submit" value="提交" class="btn btn-primary btn-block">
            </div>
            <div class="col-xs-6">
                <input type="reset" value="清空" class="btn btn-warning btn-block">
            </div>
        </div>
    </div>
</form>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminFoot.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadingPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadedPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/dialogPage.jsp"/>
<script>

    //$("#submit").click(submitHis());

    function submitHis(){
        var scnum = $("input[name=期号]").val();
        var sctitle = $("input[name=诗词]").val();
        var scauto = $("input[name=作者]").val();
        var scdate = $("input[name=日期]").val();
        var sccontent = $("textarea[name=内容]").val();
        $("input[type=reset]").click();
        //console.log(scauto+"--"+sccontent+"--"+scdate+"--"+scnum+"--"+sctitle);
        if($.trim(scnum)==""||$.trim(sctitle)==""||$.trim(scauto)==""||$.trim(scdate)==""||$.trim(sccontent)=="")
            return;
        $.ajax({
            url:"admin/submitUpdate",
            type:"post",
            data:{
                "期号":scnum,
                "诗词":sctitle,
                "作者":scauto,
                "日期":scdate,
                "内容":sccontent
            },
            beforeSend:function(){
                $("#loading-content").text("正在提交")
                $("#loadingToast").show()
            },
            complete:function(){
                $("#loadingToast").hide()
            },
            success:function(data){
                if(data.result==true){
                    $("#toast").show();
                    setTimeout(function(){
                        $("#toast").hide();
                    },1000);
                }
                else{
                    $("#suggest-body").text(data.reason);
                    $("#suggest-bg").show();
                    setTimeout(function() {
                        $("#suggest-bg").hide();
                    },2000);
                }
            },
            error:function(msg){
                console.log(msg);
                $("#suggest-body").text("服务器错误. 稍后重试或联系开发者");
                $("#suggest-bg").show();
                setTimeout(function() {
                    $("#suggest-bg").hide();
                },2000);
            }
        });
    }


    $("form").validate({
        rules:{
            期号:{required:true, min:0},
            日期:{required:true},
            作者:{required:true},
            诗词:{required:true},
            内容:{required:true}
        },
        messages:{
            期号:{required:"请输入期号",min:"请输入正确的期号"},
            日期:{required:"请输入日期"},
            作者:{required:"请输入作者"},
            诗词:{required:"请输入题目"},
            内容:{required:"请输入内容"}
        }
    });
</script>