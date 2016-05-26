<%--诗词推荐--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/content/shared/layoutHead.jsp" />

<div class="row">
    <form action="javascript:addori();">
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
            <textarea name="sorin_content" id="sorin_content" placeholder="诗词正文" class="weui_textarea" style="overflow:scroll; overflow-x:hidden;" rows="4"></textarea>
            <span for="sorin_content"></span>
            <br>
            <input type="submit" class="btn btn-primary btn-block" value="提交推荐">
        </div>
    </form>
</div>
<%--提示框--%>
<jsp:include page="/WEB-INF/content/shared/dialogPage.jsp"/>
<%--加载框--%>
<jsp:include page="/WEB-INF/content/shared/loadingPage.jsp"/>
<jsp:include page="/WEB-INF/content/shared/layoutFoot.jsp"/>
<script>
    function addori(){
      $.ajax({
          url:"add",
          type:"post",
          data:{
              "sorin_title":$("input[name=sorin_title]").val(),
              "sorin_auth":$("input[name=sorin_auth]").val(),
              "sorin_content":$("textarea[name=sorin_content]").val()
          },
          beforeSend:function(){$("#loadingToast").show();},
          complete:function(){$("#loadingToast").hide();},
          success:function(data){
              if(data=="成功"){
                  data="提交成功!<br>期待您的诗词被推送!";
              }
              $("#suggest-body").html(data);
              $("#suggest-bg").show();
              setTimeout(function () {
                  $("#suggest-bg").hide();
              },3000);
          },
          error:function(msg){
              $("#suggest-body").html("服务器崩了.......");
              $("#suggest-bg").show();
              setTimeout(function () {
                  $("#suggest-bg").hide();
              },3000);
              console.log(msg);
          }
        });
    }

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
