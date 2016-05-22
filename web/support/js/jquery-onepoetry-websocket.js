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

function setMessageInnerHTML(sendsmessage){
    var type = sendsmessage.split('::');
    //创建一个标签里面显示字体
    console.log(sendsmessage);
    console.log(type);
    if(sendsmessage=="由您先开始游戏，请输入正确诗词开始游戏！" ||sendsmessage== "游戏开始，请等待对方输入"||sendsmessage=="正在匹配，请等待……" ||sendsmessage=="对方断开连接"){
        var mychat = $("<li></li>")
        mychat.append(type[0]);
        mychat.addClass("autochat");
        $("#convo").append(mychat);
    }
    else{
        var mychat = $("<li></li>");
        mychat.append(type[0]);
        mychat.addClass("matchchat");
        if(type[1] != "undefined")
        {
            mychat.addClass(type[1]);
        }
        else {
            setTimer(30,"timer",function(){
                ShowMsg("autochat","答题超时,您输了");
                SendPoetry("autochat","对方答题超时");
                $.ajax({
                    url:"round/timeout",
                    type:"post"
                });
            });
        }
        $("#convo").append(mychat);
        $.ajax({
            url:"round/checkSentence",
            data:{"role":"match","content":type[0]}
        });
    }
    var conv = document.getElementById("convo");
    conv.scrollTop = conv.scrollHeight;
}

