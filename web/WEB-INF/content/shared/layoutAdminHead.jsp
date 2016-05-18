<%--布局: 头部--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="IE=dege">
    <meta name="viewport" content="width-device-width, initial-scale=1">
    <title><%=request.getAttribute("pageTitle")%></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/support/css/weui.min.css">
    <script src="${pageContext.request.contextPath}/support/js/jquery-2.2.3.js"></script>
    <script src="${pageContext.request.contextPath}/support/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="sc-content col-lg-6 col-md-6 col-sm-12 col-xs-12 col-lg-offset-3 col-md-offset-3 col-sm-offset-0 col-xs-offset-0">
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
