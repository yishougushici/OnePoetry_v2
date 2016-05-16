<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutHead.jsp" />
 <link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/game.css">
 <div class="row">
     <div class="col-xs-10 col-xs-offset-1">
         <div class="jumbotron">
             <div class="ans-num">
                 10
             </div>
             <div class="err-elem-container">
 
             </div>
         </div>
     </div>
 </div>
 <script>
     var elem = ["西","风","扬","子","江","边","柳"];
     for(var i=0; i<elem.length; i++){
         var div = $("<div></div>");
         div.addClass("err-elem");
         div.append(elem[i]);
         $(".err-elem-container").append(div);
     }
 </script>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/content/shared/layoutFoot.jsp"/>