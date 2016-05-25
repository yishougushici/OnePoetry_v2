<%--查看用户反馈--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminHead.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/admin.css">
    <div class="panel panel-success">
        <div class="panel-heading">
            <b>用户: <span id="admin-fb-user"></span></b>
        </div>
        <div class="panel-body">
            <div id="admin-fb-content"></div>
        </div>
        <div class="panel-footer">
            <div class="row">
                <div class="col-xs-6 fb-public">
                    允许公开: <span id="admin-fb-public"></span>
                </div>
                <div class="col-xs-6" id="admin-fb-time"></div>
            </div>
        </div>
    </div>
    <div class="btn-group btn-group-justified" role="group" aria-label="...">
        <div class="btn-group" role="group">
            <button type="button" id="preItem" class="btn btn-default"><span class="glyphicon glyphicon-chevron-left"></span>上一条</button>
        </div>
        <div class="btn-group" role="group">
            <button type="button" id="setYes" class="btn btn-default"><span class="glyphicon glyphicon-eye-close"></span>处理</button>
        </div>
        <div class="btn-group" role="group">
            <button type="button" id="nextItem" class="btn btn-default">下一条<span class="glyphicon glyphicon-chevron-right"></span></button>
        </div>
    </div>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminFoot.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadingPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadedPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/dialogPage.jsp"/>
<script>
    var itemId = -1;
    getData("next");
    $("#preItem").click(function(){
       getData("previous");
    });
    $("#nextItem").click(function(){
        getData("next");
    });
    $("#setYes").click(function(){
        Option("Y");
    });

    function Option(opt){
        if(itemId==-1)
            return;
        $.ajax({
            url:"admin/setFeedback",
            type:"post",
            data:{"id":itemId,"option":opt},//setOriginal所执行的操作
            beforeSend:function(){
                $("#loading-content").text("正在提交")
                $("#loadingToast").show()
            },
            success:function(data){
                $("#loadingToast").hide();
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
                getData("next");
            },
            error:function(msg){
                $("#loadingToast").hide();
                console.log(msg);
                $("#suggest-body").text("服务器错误. 稍后重试或联系开发者");
                $("#suggest-bg").show();
                setTimeout(function() {
                    $("#suggest-bg").hide();
                },2000);
            }
        });
    }

    function getData(mode){
        $.ajax({
            url:"admin/getFeedback",
            type:"post",
            data:{"id":itemId, "mode":mode},
            beforeSend:function(){
                $("#loading-content").text("获取中")
                $("#loadingToast").show()
            },
            complete:function(){
                $("#loadingToast").hide()
            },
            success: function (message) {
                console.log(message);
                if(message.result == true){
                    var canPublix = (message.data.sfb_pass=="Y") ? "是" : "否";
                    itemId = message.data.sfb_id;
                    $("#admin-fb-user").text(message.data.sfb_user);
                    $("#admin-fb-content").text(message.data.sfb_content);
                    $("#admin-fb-time").text(message.data.sfb_date);
                    $("#admin-fb-public").text(canPublix);
                }
                else{
                    var info = (mode=="next") ? "已经到最后一条" : "已经是第一条";
                    $("#suggest-body").text(info);
                    $("#suggest-bg").show();
                    setTimeout(function() {
                        $("#suggest-bg").hide();
                    },1000);
                }
            },
            error: function (msg) {
                console.error(msg);
            }
        });
    }
</script>
