<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 24 Apr 2025
  Time: 6:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Promotions</title>
</head>
<body data-theme="light">
<%@ include file="/general/userHeader.jsp" %>
<video autoplay muted loop class="fixed top-0 left-0 w-full h-full object-cover -z-10">
    <source src="<%= request.getContextPath() %>/static/video/background3.mp4" type="video/mp4"/>
    Your browser does not support the video tag.
</video>
<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-10 max-w-6xl my-5 mx-auto">
    <div class="bg-base-100 shadow-md border border-hidden overflow-hidden mx-10 rounded-lg max-w-3xs max-h-lvh my-5">
        <img src="${pageContext.request.contextPath}/uploads/promo-welcome.png" alt="promo">
    </div>
    <div class="bg-base-100 shadow-md border border-hidden overflow-hidden mx-10 rounded-lg max-w-3xs max-h-lvh my-5">
        <img src="${pageContext.request.contextPath}/uploads/promo-birthday.png" alt="promo">
    </div>
    <div class="bg-base-100 shadow-md border border-hidden overflow-hidden mx-10 rounded-lg max-w-3xs max-h-lvh my-5">
        <img src="${pageContext.request.contextPath}/uploads/promo-valentine.png" alt="promo">
    </div>
    <div class="bg-base-100 shadow-md border border-hidden overflow-hidden mx-10 rounded-lg max-w-3xs max-h-lvh my-5">
        <img src="${pageContext.request.contextPath}/uploads/promo-newyear.png" alt="promo">
    </div>
    <div class="bg-base-100 shadow-md border border-hidden overflow-hidden mx-10 rounded-lg max-w-3xs max-h-lvh my-5">
        <img src="${pageContext.request.contextPath}/uploads/promo-null1.png" alt="promo">
    </div>
    <div class="bg-base-100 shadow-md border border-hidden overflow-hidden mx-10 rounded-lg max-w-3xs max-h-lvh my-5">
        <img src="${pageContext.request.contextPath}/uploads/promo-null2.png" alt="promo">
    </div>
</div>


<%@ include file="/general/userFooter.jsp" %>
</body>
</html>
