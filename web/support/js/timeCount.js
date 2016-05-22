var scTimer;
function setTimer(seconds,id,callback){
    var ele = document.getElementById(id);
    ele.innerText = seconds;
    scTimer = setInterval(function(){
        seconds -= 1;
        ele.innerText = seconds;
        if(seconds == 0){
            callback();
            clearInterval(scTimer);
            ele.innerText("");
        }
    },1000);
}

function clearTimer(){
    clearInterval(scTimer);
}

