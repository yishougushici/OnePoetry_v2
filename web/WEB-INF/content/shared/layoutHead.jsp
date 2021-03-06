<%--布局: 头部--%>

<%--

    tagTitle : 页面标签标题
    pageTitle: 页面大标题
    username : 用户名
    score: 游戏分数
    isGame: 是否进入游戏状态

--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="IE=dege">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title><%=request.getAttribute("pageTitle")%></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/weui.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/component.css">
    <link rel="icon" href="${pageContext.request.contextPath}/support/image/logoICO.ico">
    <script src="${pageContext.request.contextPath}/support/js/jquery-2.2.3.js"></script>
    <script src="${pageContext.request.contextPath}/support/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/support/js/jquery.validate.min.js"></script>
    <%--<script src="${pageContext.request.contextPath}/support/js/messages_zh.js"></script>--%>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="sc-content col-lg-6 col-md-6 col-sm-12 col-xs-12 col-lg-offset-3 col-md-offset-3">
            <div class="row" style="margin-top:.5em;">
                <div class="col-xs-6" style="text-align: left">
                    <div class="sc-username">
                        <%
                            if(session.getAttribute("username") != null){
                        %>
                        <span class="sc-info-icon glyphicon glyphicon-user">
                            <%=(session.getAttribute("username"))%>
                        </span>
                        <%}%>

                    </div>
                </div>
                <div class="col-xs-6" style="text-align: right">
                    <%
                        if(request.getAttribute("isGame")!=null){//如果已经进入游戏状态
                    %>
                    <span class="glyphicon glyphicon-heart sc-score">
                        <%=session.getAttribute("score")%>
                    </span>
                    <%
                        }
                    %>
                </div>
            </div><!--row-->
            <div class="row">
                <div class="sc-logo">
                    <img src="${pageContext.request.contextPath}/support/image/logo.png" alt="一首古诗词">
                </div>
            </div>
            <div class="row">
                <div class="sc-title">
                    <h1><%=request.getAttribute("pageTitle")%></h1>
                </div>
            </div>
