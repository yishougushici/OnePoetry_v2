<%--处理原创诗词--%>

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
                    <div class="sc-date">
                        日期
                    </div>
                </div>
            </div>
        </div>
    <div class="col-xs-12">
        <div class="btn-group btn-group-justified" role="group" aria-label="...">
            <div class="btn-group" role="group">
                <button type="button" id="Previous" class="btn btn-lg btn-default">
                    <span class="glyphicon glyphicon-menu-left"></span>
                </button>
            </div>
            <div class="btn-group" role="group">
                <button type="button" id="Pass" class="btn btn-success">通过</button>
            </div>
            <div class="btn-group" role="group">
                <button type="button" id="Denied" class="btn btn-danger">不通过</button>
            </div>
            <div class="btn-group" role="group">
                <button type="button" id="Next" class="btn btn-lg btn-default">
                    <span class="glyphicon glyphicon-menu-right"></span>
                </button>
            </div>
        </div>
    </div>
    </div>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminFoot.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadingPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadedPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/dialogPage.jsp"/>
<script>
    var itemId = -1;
    getData("next");
    $("#Previous").click(function(){
        getData("previous");
    })
    $("#Pass").click(function(){
        Option("Y")
    });//通过
    $("#Denied").click(function(){
        Option("I")
    });//不通过
    $("#Next").click(function(){
        getData("next");
    });//下一条

    function Option(opt){
        if(itemId==-1)
            return;
        $.ajax({
            url:"admin/setOriginal",
            type:"post",
            data:{"id":itemId,"option":opt},//setOriginal所执行的操作
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
                getData("next");
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

    function getData(mode){
        $.ajax({
            url:"admin/getOriginal",
            type:"post",
            data:{"id":itemId, "mode":mode},
            success: function (message) {
                if(message.result == true){
                    itemId = message.data.sorin_id;
                    $(".sc-title").text(message.data.sorin_title);
                    $(".sc-author").text(message.data.sorin_auth);
                    $(".sc-body").text(message.data.sorin_content);
                    $(".sc-date").text(message.data.sorin_time);
                }
                else{
                    var info = (mode=="next") ? "已经是第一条" : "已经到最后一条";
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