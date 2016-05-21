var URL="ws://120.27.120.124:8090/websocket/chat/index";
var statusSocket=null;
if('WebSocket' in window) {
    statusSocket = new WebSocket(URL);
}else {
    alert("浏览器版本太低，不支持游戏，请升级浏览器后进行游戏！");
}
//
function setMessageInnerHTML(innerHTML){
    document.getElementById("userNumber").innerHTML+=innerHTML+"</br>";
}
statusSocket.onmessage= function (event) {
    setMessageInnerHTML(event.data);
}

function startGame() {
    statusSocket.close();
}
