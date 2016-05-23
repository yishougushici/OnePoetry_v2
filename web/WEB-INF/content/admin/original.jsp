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
                <div class="panel-footer">
                    <div class="sc-reason">
                        赏析
                    </div>
                </div>
            </div>
            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                <div class="btn-group" role="group">
                    <button type="button" id="Pass" class="btn btn-primary">通过</button>
                </div>
                <div class="btn-group" role="group">
                    <button type="button" id="Denied" class="btn btn-danger">不通过</button>
                </div>
                <div class="btn-group" role="group">
                    <button type="button" id="Next" class="btn btn-default">下一条</button>
                </div>
            </div>
        </div>
    </div>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminFoot.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadingPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadedPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/dialogPage.jsp"/>
<script>
    getData();
    $("#Pass").click(function(){Option("pass")});//通过
    $("#Denied").click(function(){Option("denied")});//不通过
    $("#Next").click(getData());//下一条

    function Option(opt){
        $.ajax({
            url:"admin/setOriginal",
            type:"post",
            data:{"option":opt},//setOriginal所执行的操作
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
                getData();
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

    function getData(){
        $.ajax({
            url:"admin/getOriginal",
            type:"post",
            success: function (data) {
                $(".sc-title").text(data.sorin_title);
                $(".sc-author").text(data.sorin_auth);
                $(".sc-body").text(data.sorin_content);
                $(".sc-date").text(data.sorin_time);
            },
            error: function (msg) {
                console.error(msg);
            }
        });
    }
</script>