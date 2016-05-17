<%--
  Created by IntelliJ IDEA.
  User: zhaokuo
  Date: 2016/5/8
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/support/chat/style.css">

<div class="row">
    <div class="col-xs-10 col-xs-offset-1">
        <div class="chat-thread" id="convo">
            <li class="autochat">左键聊天, 右键接龙</li>
            <li class="autochat">pc端回车接龙, ↑ 箭头聊天</li>
        </div>
        <div class="input-group">
            <span class="input-group-btn">
                <button class="btn btn-info" id="chat-send">
                    <span class="glyphicon glyphicon-ice-lolly-tasted"></span>
                </button>
            </span>
            <input type="text" name="sa_tail" class="form-control" aria-describedby="ans_send">
            <span class="input-group-btn" id="round_send">
                <button class="btn btn-success">
                    <span class="glyphicon glyphicon-send"></span>
                </button>
            </span>
        </div>
    </div>
</div>

<script>
    $("#round_send").click(function(){SendMsg();});
    $("input[name=sa_tail]").keyup(function(e){
//        console.log(e.keyCode);
        if(e.keyCode==13){
            SendMsg("mychat",$("input[name=sa_tail]").val());
        }
        if(e.keyCode == 38 ){
            alert("hhh");
        }
    });

    function SendMsg(role,message){
        $("input[name=sa_tail]").val("");
        if(message.trim()==""){return;}
        var mychat = $("<li></li>")
        mychat.append(message);
        mychat.addClass(role);
        $("#convo").append(mychat);
        var conv = document.getElementById("convo");
        conv.scrollTop = conv.scrollHeight;
    }
</script>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>
