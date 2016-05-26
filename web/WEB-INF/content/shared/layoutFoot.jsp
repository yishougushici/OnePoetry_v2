<%--布局: 底部--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <div class="sc-back">
                <a href="javascript:history.back();"><img src="${pageContext.request.contextPath}/support/image/back.png" alt=""></a>
            </div>
            </div>
            <div class="sc-fbg col-lg-6 col-md-6 col-sm-12 col-xs-12 col-lg-offset-3 col-md-offset-3">
                <div class="sc-footer">
                    <div class="sc-copyright">
                        &copy;一首古诗词 2015-2016
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<!--Countly script-->
<script type='text/javascript' src='http://wolfogre-public.oss-cn-hangzhou.aliyuncs.com/countly.min.js'></script>
<script type='text/javascript'>
    //使用参数启动 countly
    Countly.init({
        app_key: "eb64f5ea785c950ab57557235f71c12842ea604a",
        url: "http://countly.wolfogre.com", //或者对于默认 countly cloud 来说不包含此项
        debug:true
    });
    //在每个页面视图上启动会话
    Countly.begin_session();
    //添加您需要的任何事件，如 pageView
    Countly.add_event({
        "key": "pageView",
        "segmentation": {
            "url": window.location.pathname
        }
    });
    //在离开页面上结束会话
    window.onunload = function(){
        Countly.end_session();
    };
</script>

