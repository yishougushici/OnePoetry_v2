/**
 * Created by zhaokuo on 2016/5/21.
 */
$(function(){
    var c;
    function setDownCount(time){
        c = time;
        timedCount();
    }
    function timedCount()
    {
        $("#txt").text(c--);
        if(c==0){
            Timeout();
            return;
        }
        setTimeout("timedCount()",1000)
    }
});
