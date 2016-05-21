/**
 * Created by Administrator on 2016/5/18.
 */
var URL="ws://120.27.120.124:8080/websocket/chat/beginGame";
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
    if(sendsmessage=="由您先开始游戏，请输入正确诗词开始游戏！" ||sendsmessage== "游戏开始，请等待对方输入"||sendsmessage=="正在匹配，请等待……" ||sendsmessage=="对方断开连接"){
        var mychat = $("<li></li>")
        mychat.append(type[0]);
        mychat.addClass("autochat");
        $("#convo").append(mychat);
    }
    else{
        var mychat = $("<li></li>")
        mychat.append(type[0]);
        if(type.length>1)
        {
            mychat.addClass(type[1]);
        }
        mychat.addClass("matchchat");
        $("#convo").append(mychat);

    }
    var conv = document.getElementById("convo");
    conv.scrollTop = conv.scrollHeight;
}

