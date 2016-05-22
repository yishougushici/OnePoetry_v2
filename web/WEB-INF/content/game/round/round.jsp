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
        剩余答题时间: <div id="timer" style="display:inline;">150</div>
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
    var ismy = false; //是否轮到我答题

    $(".game-start").click(function(){
        $(".jumbotron").hide();
        $("#game-content").show();
    });

    //点击发送按钮
    $("#round_send").click(function(){
        var message = $("input[name=sa_tail]").val();
        if($.trim(message)==="")
            return;
        CheckPoetry(message);
    });

    //点击聊天按钮
    $("#chat-send").click(function(){
        var message = $("input[name=sa_tail]").val();
        if($.trim(message)==="")
            return;
        ShowMsg("mychat",message,"chat");
        SendPoetry("matchchat",message.val(),"chat");
    });

    $("input[name=sa_tail]").keyup(function(e){
        var message = $("input[name=sa_tail]").val();
        if($.trim(message)==="")
            return;
        if(e.keyCode==13){//发送诗词验证, 如果验证成功, 发送出去
            CheckPoetry(message);
        }
        if(e.keyCode == 38 ){//绕过诗词验证, 直接发送
            ShowMsg("mychat",message,"chat");
            SendPoetry("matchchat",message,"chat");
        }
    });


    /**
     * 验证诗句
     */
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
            complete:function(){
                $("#loadingToast").hide();
            },
            success:function(data){
                if(data.result==true){
                    SendPoetry("matchchat",msg,"round");
                    ShowMsg("mychat",msg,"round");
                    $(".sc-score").text(data.score);
                }
                else {
                    ShowMsg("autochat",data.reason,"error");
                    setTimer($("#timer").text(),"timer",function(){
                        ShowMsg("autochat","答题超时,您输了");
                        SendPoetry("autochat","对方答题超时")
                        $.ajax({
                            url:"round/timeout",
                            type:"post"
                        });
                    });
                }
            },
            error:function(data){
                console.log(data);
                ShowMsg("autochat","服务器错误","error");
            }
        });
    }


    /**
     * 是否轮到我答题
     */
    function ismyfirst(){
        if(ismy==true)
            return true;
        var roundlis = $("li.round");
        var autolis = $("li.autochat:last")
        if(roundlis.length>0 || autolis.text() == "由您先开始游戏，请输入正确诗词开始游戏！")
        {
            ismy = true;
            return true;
        }
        return false;
    }


    /**
     * 发送消息
     * @param role 角色 mychat:我, matchchat:对方, autochat: 机器人
     * @param message 消息内容
     * @param type 类型: chat代表聊天消息
     * @constructor
     */
    function SendPoetry(role,message,type){
        $("input[name=sa_tail]").val("");
        forwardMessage(role+"&#(ds45l%"+message+"&#(ds45l%"+type);
    }

    /**
     *显示消息
     * @param role 角色 mychat:我, matchchat:对方, autochat: 机器人
     * @param message 消息内容
     * @param type 类型: chat代表聊天消息
     * @constructor
     */
    function ShowMsg(role,message,type){
        $("input[name=sa_tail]").val("");

        var chatMsg = $("<li></li>");
        chatMsg.append(message);
        chatMsg.addClass(role);
        if(type != undefined && type != "undefined"){
            chatMsg.addClass(type);
        }
        $("#convo").append(chatMsg);
        //将窗口滚动到最底部
        var conv = document.getElementById("convo");
        conv.scrollTop = conv.scrollHeight;
    }
</script>
