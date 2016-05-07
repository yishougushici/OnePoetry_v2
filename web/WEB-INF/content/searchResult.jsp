<%@ page import="gushici.domain.PushRecord" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Jason Song(wolfogre.com)
  Date: 2016/5/7
  Time: 21:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
	if(request.getAttribute("error") != null){
%>
<div>
	<i class="weui_icon_msg weui_icon_warn"></i>
	<br><%=request.getAttribute("error")%>
<%
		return;
	}
%>

<%
	List<PushRecord> resultList = (List<PushRecord>)request.getAttribute("resultList");
%>
<div id="toast" style="display: none;">
	<div class="weui_mask_transparent"></div>
	<div class="weui_toast">
		<i class="weui_icon_toast"></i>
		<p class="weui_toast_content">已完成</p>
	</div>
</div>

<% for(PushRecord pushRecord : resultList)
{
%>
<div class="panel panel-success">
	<div class="panel-heading">
		<div class = "sc-num">
			<%=pushRecord.getIdNum()%>
		</div>
		<div class = "sc-heading">
			<div class="sc-title">
				<%=pushRecord.get诗词()%>
			</div>
			<div class="sc-author">
				<%=pushRecord.get作者()%>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<div class="sc-body">
			<%=pushRecord.get内容().replace("\n","<br/>\n")%>
		</div>
		<div class="panelfooter">
			<%=pushRecord.get日期()%>
		</div>
	</div>
</div>
<%
	}
%>