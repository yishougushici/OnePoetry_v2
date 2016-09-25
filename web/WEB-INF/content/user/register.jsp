<%--用户注册--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/content/shared/layoutHead.jsp" />
<%
    if(request.getAttribute("error_message")!=null){
%>
<div class="error_message">
    <%=request.getAttribute("error_message")%><!--TODO:这里被我改了,仅为调试-->
</div>
<%
    }
%>
<%--<%=request.getAttribute("error_message")%><!--TODO:这里被我改了,仅为调试-->--%>
<%--用户名作为主键, 唯一标识用户--%>
<form action="registerCheck.action">
	<div class="row">
		<div class="col-xs-10 col-lg-10 col-md-10 col-sm-10 col-lg-offset-1 col-sm-offset-1 col-md-offset-1 col-xs-offset-1">
            <span class="input input--hoshi">
                <input class="input__field input__field--hoshi" type="text" name="suser_name" id="suser_name" />
                <label class="input__label input__label--hoshi input__label--hoshi-color-1" for="suser_name">
	                <span class="input__label-content input__label-content--hoshi">用户名 <span for="suser_name"></span></span>
                </label>
            </span>

            <span class="input input--hoshi">
                <input class="input__field input__field--hoshi" type="password" name="suser_password" id="suser_password" />
                <label class="input__label input__label--hoshi input__label--hoshi-color-1" for="suser_password">
	                <span class="input__label-content input__label-content--hoshi">密码 <span for="suser_password"></span></span>
                </label>
            </span>

            <span class="input input--hoshi">
                <input class="input__field input__field--hoshi" type="password" name="check_password" id="check_password" />
                <label class="input__label input__label--hoshi input__label--hoshi-color-1" for="check_password">
                    <span class="input__label-content input__label-content--hoshi">确认密码 <span for="check_password"></span></span>
                </label>
            </span>

            <span class="input input--hoshi">
                <input class="input__field input__field--hoshi" type="text" name="suser_email" id="suser_eamil" /><!--TODO:这里被我改了,原来是suser_eamil-->
                <label class="input__label input__label--hoshi input__label--hoshi-color-1" for="suser_eamil">
	                <span class="input__label-content input__label-content--hoshi">E-mail <span for="suser_eamil"></span></span>
                </label>
            </span>
		</div>
	</div>
	<div class="row">
		<div class="col-xs-10 col-xs-offset-1">
			<input type="submit" class="btn btn-success" value="注册">
			&emsp;
			<input type="reset" class="btn btn-default" value="重置">
		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/content/shared/layoutFoot.jsp"/>

<script>
    $(function(){
        $("input[name=suser_name]").blur(function(){
            var username=$("input[name=suser_name]").val();
            $.ajax({
                url:"usernameCheck",
                data:{"suser_name":username},
                type:"post",
                success: function(data){
                    var message = $("<span class=error></span>")
                    message.append(data);
                    $( "span[for='suser_name']" ).children().remove();
                    $( "span[for='suser_name']" ).append(message);
                },
                error: function(msg){
                    $(".errormessage").append(msg);
                }
            })
        });

       $("form").validate({
            errorElement: "span",
            errorPlacement: function (error, element) {
                $( element )
                        .closest( "form" )
                        .find( "span[for='" + element.attr( "id" ) + "']")
                        .children().remove();
                $( element )
                        .closest( "form" )
                        .find( "span[for='" + element.attr( "id" ) + "']")
                        .append( error );
            },
            rules:{
                suser_name:{
                    required:true,
                    maxlength:8,
                },
                suser_password:{
                    required:true,
                    maxlength:15,
                    minlength:4,
                },
                check_password:{
                    equalTo: "#suser_password"
                },
                suser_email:{
                    required:true,
                    email:true,
                }
            },
            messages:{
                suser_name:{
                    required:"请输入用户名",
                    maxlength:"用户名最长不超过{0}位"
                },
                suser_password:{
                    required:"请输入密码",
                    maxlength:"用户名最长不超过{0}位",
                    minlength:"用户名最少{0}位"
                },
                check_password:{
                    equalTo: "两次输入的密码不匹配",
                },
                suser_email:{
                    required:"请输入邮件地址",
                    email:"请输入正确的邮件地址",
                }
            }
        });
    });
</script>