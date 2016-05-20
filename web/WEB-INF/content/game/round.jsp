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
        <div id="game-content">
            <div class="chat-thread" id="convo">
                <li class="autochat">左键聊天, 右键接龙. PC端回车接龙, ↑键聊天</li>
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
</div>
<%--加载框--%>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/loadingPage.jsp"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>

<script src="${pageContext.request.contextPath}/support/js/jquery-onepoetry-websocket.js"></script>
<script>
    $(".game-start").click(function(){
        $(".jumbotron").hide();
        $("#game-content").show();
    });

    //点击发送按钮
    $("#round_send").click(function(){
        CheckPoetry($("input[name=sa_tail]").val());
    });
    //点击聊天按钮
    $("#chat-send").click(function(){
        SendPoetry("chat");
    });

    $("input[name=sa_tail]").keyup(function(e){
        if(e.keyCode==13){
            //发送诗词验证, 如果验证成功, 发送出去
            CheckPoetry($("input[name=sa_tail]").val());
        }
        if(e.keyCode == 38 ){
            //绕过诗词验证, 直接发送
            SendPoetry("chat");
        }
    });

    //验证诗句
    function CheckPoetry(msg){
        $.ajax({
            url: "",
            data:{"message":msg},
            type:"post",
//            beforeSend: function () {$("#loadingToast").show();},
//            complete:function(){$("#loadingToast").hide();},
            success:function(){
                ShowMsg("mychat",$("input[name=sa_tail]").val(),"round");
            },
            error:function(data){
                ShowMsg("autochat","服务器错误...");
            }
        });
    }

    //发送消息
    function SendPoetry(type){
        var message = $("input[name=sa_tail]").val();
        ShowMsg("mychat",message,type);
        forwardMessage(message+"::"+type);
    }

    function ShowMsg(role,message,type){
        $("input[name=sa_tail]").val("");
        if(message.trim()==""){return;}
        var mychat = $("<li></li>")
        mychat.append(message);
        mychat.addClass(role);
        if(type != undefined){
            mychat.addClass(type);
        }
        $("#convo").append(mychat);
        var conv = document.getElementById("convo");
        conv.scrollTop = conv.scrollHeight;
    }
</script>
