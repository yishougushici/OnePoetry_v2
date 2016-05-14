<%--登录页--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />
<%=request.getAttribute("error_message")%><!--TODO:这里被我改了-->
<div class="row">
  <div class="col-xs-10 col-lg-10 col-md-10 col-sm-10 col-lg-offset-1 col-sm-offset-1 col-md-offset-1 col-xs-offset-1">
    <form action="loginCheck.action"><!--TODO:这里被我改了-->
      <span class="input input--hoshi">
        <input class="input__field input__field--hoshi" type="text" name="suser_name" id="suser_name" />
        <label class="input__label input__label--hoshi input__label--hoshi-color-2" for="suser_name">
          <span class="input__label-content input__label-content--hoshi">用户名</span>
        </label>
      </span>
      <span class="input input--hoshi">
        <input class="input__field input__field--hoshi" type="text" name="suser_password" id="suser_password" />
        <label class="input__label input__label--hoshi input__label--hoshi-color-2" for="suser_password">
          <span class="input__label-content input__label-content--hoshi">密码</span>
        </label>
      </span>
      <input type="submit" class="btn btn-block btn-success" value="登录">
    </form>
  </div>
</div>
<p />
<div class="row">
  <div class="col-xs-10 col-xs-offset-1">
    <a href="/feedback.jsp"><button class="btn btn-block btn-primary">反馈建议</button></a>
  </div>
</div>
<br>
<div class="row">
  <div class="col-xs-offset-8">
    <a href="/register.jsp">新用户?点击注册</a>
  </div>
</div>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>