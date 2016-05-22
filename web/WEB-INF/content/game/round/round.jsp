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
        剩余答题时间: <div id="timer" style="display:inline;">30</div>
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
<script src="${pageContext.request.contextPath}/support/chat/wechat-ime.js"></script>
<script src="${pageContext.request.contextPath}/support/js/jquery-onepoetry-websocket.js"></script>
<script src="${pageContext.request.contextPath}/support/js/timeCount.js"></script>
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
    var ismy = false;
    //验证诗句
    function CheckPoetry(msg){
        if(!ismyfirst()) {
            $("#convo").append("<li class='autochat'>等待对方开始, 您可以发送聊天消息</li>");
            return;
        }
        if(msg.trim()==="")
            return;
        clearTimer();
        $.ajax({
            url: "round/checkSentence",
            data:{"role":"me","content":msg},
            type:"post",
            beforeSend: function () {
                $(".weui_toast_content").text("验证中");
                $("#loadingToast").show();
            },
            complete:function(){$("#loadingToast").hide();},
            success:function(data){
//                console.log(data);
                if(data.result==true){
                    SendPoetry();
                    $(".sc-score").text(data.score);
                }
                else {
                    setTimer($("#timer").text(),"timer",function(){
                       ShowMsg("autochat","答题超时,您输了");
                        SendPoetry("autochat","对方答题超时")
                        $.ajax({
                            url:"round/timeout",
                            type:"post"
                        });
                    });
                    ShowMsg("autochat",data.reason,"error");
                }
            },
            error:function(data){
                console.log(data);
                ShowMsg("autochat","服务器错误","error");
            }
        });
    }

    function ismyfirst(){
        var lis = $("li.autochat:last");
        if(ismy==false && lis.text() != "由您先开始游戏，请输入正确诗词开始游戏！") {
            return false;
        }
        ismy = true;
        return true;
    }


    //发送消息
    function SendPoetry(type,message){
        if(message==undefined)
            message = $("input[name=sa_tail]").val();
        if($.trim(message)==="")
            return;
        $("input[name=sa_tail]").val("");
        ShowMsg("mychat",message,type);
        forwardMessage(message+"::"+type);
    }

    //显示消息
    function ShowMsg(role,message,type){

        $("input[name=sa_tail]").val("");
        if($.trim(message)==="")
            return;
        var mychat = $("<li></li>");
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
