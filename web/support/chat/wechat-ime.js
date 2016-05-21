// 判断是否为文本框
function is_text(type){
    if (type=="text" || type=="number" || type=="password" || type=="tel" || type=="url" || type=="email") {
        return true;
    };
}

// 判断是否是微信
function is_weixn(){  
    var ua = navigator.userAgent.toLowerCase();  
    if(ua.match(/MicroMessenger/i)=="micromessenger") {  
        return true;  
    } else {  
        return false;  
    }  
}

// 用于解决微信自带浏览器输入法遮挡文本框的处理
$(function(){
    if (is_weixn()){
        var inp = $("input"),
            win = $(window),
            bod = $("body"),
            winH = win.height();
        inp.each(function(){
            var t = $(this),
                tTop = t.offset().top,
                tType = t.prop('type');
            if (is_text(tType)) {
                t.on('click',function(event) {
                    bod.height(winH+300);
                    bod.animate({scrollTop: tTop-100 + 'px'}, 200);
                });
            }
        });
    }
});