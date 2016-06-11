/**
 * Created by Administrator on 2016/5/18.
 */
var URL="ws://120.27.120.124:8090/websocket/chat/beginGame";
var webSocket=null;
if('WebSocket' in window) {
    webSocket=new WebSocket(URL);
}else {
    alert("浏览器版本太低，不支持游戏，请升级浏览器后进行游戏！");
}
webSocket.onmessage=function (event){
    setMessageInnerHTML(event.data);
}
window.onbeforeunload= function () {
    webSocket.close();
}

function disconnection(){
    if(WebSocket.OPEN){
        webSocket.close();
    }
}

function forwardMessage(message){
    webSocket.send(message);
}

/**
 * 接收到WebSocket传来的消息所执行的动作
 * @param sendsmessage 接收到的消息,格式: role&#(ds45l%message&#(ds45l%type
 */
function setMessageInnerHTML(sendsmessage){
    var receiveMsg = sendsmessage.split('&#(ds45l%');
    if(sendsmessage=="由您先开始游戏，请输入正确诗词开始游戏！" ||sendsmessage== "游戏开始，请等待对方输入"||sendsmessage=="正在匹配，请等待……" ||sendsmessage=="对方断开连接"){
        ShowMsg("autochat",sendsmessage);
    }
    //接收到对方消息
    else {
        ShowMsg(receiveMsg[0], receiveMsg[1], receiveMsg[2]);
        if (receiveMsg[2] == "round") {
            setTimer(answerTime, "timer", function () {
                GodOrder = true;
                ShowMsg("autochat","答题超时,您输了!新回合开始, 由您出题");
                SendPoetry("autochat","对方答题超时! 新回合开始, 等待对方出题.");
                $.ajax({
                    url: "round/timeout",
                    type: "post",
                    success:function(e){
                        $(".sc-score").text(e.score)
                    },
                    error:function(e){console.error(e)}
                });
                $.ajax({
                    url:"round/restart",
                    type:"post"
                });
            });
            $.ajax({
                url: "round/checkSentence",
                data: {"role": "match", "content": receiveMsg[1]},
                success:function(e){console.info(e)},
                error:function(e){console.error(e)}
            });
        }
    }
}

