function setTimer(seconds,id,callback){
    var ele = document.getElementById(id);
    ele.innerText = seconds;
    var intervalId = setInterval(function(){
        seconds -= 1;
        ele.innerText = seconds;
        if(seconds == 0){
            callback();
            clearInterval(intervalId);
        }
    },1000);
}

