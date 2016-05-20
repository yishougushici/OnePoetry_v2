var URL="ws://120.27.120.124:8080/websocket/chat/index";
var webSocket=null;
if('WebSocket' in window) {
    webSocket = new WebSocket(URL);
}else {
    alert("浏览器版本太低，不支持游戏，请升级浏览器后进行游戏！");
}
//
function setMessageInnerHTML(innerHTML){
    document.getElementById("userNumber").innerHTML+=innerHTML+"</br>";
}
webSocket.onmessage= function (event) {
    setMessageInnerHTML(event.data);
}

function startGame() {
    webSocket.close();
}
