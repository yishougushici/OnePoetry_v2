<%--查看用户反馈--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminHead.jsp" />

    <div class="panel panel-success">
        <div class="panel-heading">
            <b>用户: <span id="admin-fb-user"></span></b>
        </div>
        <div class="panel-body">
            <div id="admin-fb-content"></div>
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
<%--<script src="${pageContext.request.contextPath}/support/js/jqPaginator.min.js"></script>--%>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/dialogPage.jsp" />
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutAdminFoot.jsp"/>
<script>
    $(document).ready(function () {
        var currentItem = 1;
        //上一条
        $("#preItem").click(function(){
            if(currentItem==1)
                return;
            currentItem--;
            requestItem(currentItem);
        });
        //下一条
        $("#nextItem").click(requestItem((++currentItem)));
        //设置为已处理
        $("#setYes").click(function(){
            $.ajax({
               url:"admin/feedback/set",
                data:{"item":currentItem},
                type:"post",
                success: function (data) {
                    if(data=="true"){
                        requestItem(++currentItem);
                    }
                },
                error:function(msg){
                    $("#suggest-body").text("服务器错误");
                    $("#suggest-bg").show();
                    console.error(msg);
                    setTimeout(function () {
                        $("#suggest-bg").hide();
                    },3000);
                }
            });
        });
        //以item为索引获取反馈内容
        function requestItem(item){
            $.ajax({
                url:"admin/feedback/getItem",
                data:{"item":item},
                type:"post",
                success:function(data){
                    $("#admin-fb-user").text(data.user);
                    $("#admin-fb-content").text(data.content);
                }
            });
        }
    })
</script>
