<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@page import="com.samseng.web.models.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="orders" type="java.util.List<com.samseng.web.dto.OrderListingDTO>" scope="request"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
    <link href="<%= request.getContextPath() %>/static/css/datatables.min.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/datatables.min.js"></script>
</head>

<body class="flex flex-col min-h-screen">
<video autoplay muted loop class="fixed top-0 left-0 w-full h-full object-cover -z-10">
    <source src="<%= request.getContextPath() %>/static/video/background3.mp4" type="video/mp4"/>
    Your browser does not support the video tag.
</video>
<%@ include file="/general/userHeader.jsp" %>

<div class="flex-grow">
    <div class="container mx-auto my-5 py-5 px-4 bg-base-100 rounded-lg border border-base-200 shadow-sm mt-[5.5rem]">
        <div class="flex flex-col flex-wrap gap-3 sm:flex-row sm:items-center sm:justify-between">
            <div class=""></div>
        </div>

        <div class="mt-8 overflow-x-auto">
            <table id="userOrderTable" class="table" style="width:100%">
                <!-- head -->
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>#${order.id()}</td>
                        <td>${order.orderedDate()}</td>
                        <td>
                            <c:choose>
                                <c:when test="${order.status() == 'Ordered'}">
                                    <span class="badge badge-info badge-soft">${order.status()}</span>
                                </c:when>
                                <c:when test="${order.status() == 'Packaged'}">
                                    <span class="badge badge-primary badge-soft">${order.status()}</span>
                                </c:when>
                                <c:when test="${order.status() == 'Shipped'}">
                                    <span class="badge badge-warning badge-soft">${order.status()}</span>
                                </c:when>
                                <c:when test="${order.status() == 'Delivered'}">
                                    <span class="badge badge-success badge-soft">${order.status()}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-secondary badge-soft">${order.status()}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatNumber value="${order.netPrice()}" type="currency" currencySymbol="RM "/></td>
                        <td>
                            <a href=" ${pageContext.request.contextPath}/user/detail?action=view&id=${order.id()}" class="btn btn-circle btn-text btn-sm" aria-label="Edit">
                                <span class="icon-[tabler--eye] size-5"></span>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

<%--    <%--%>
<%--    Account profile = (Account) session.getAttribute("profile");--%>
<%--    %>--%>


</div>
<%@include file="/general/userFooter.jsp" %>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        new DataTable('#userOrderTable', {
            order: [[1, 'desc']], // Sort by Date column (2nd column, index 1) descending
            columnDefs: [
                { targets: 0, orderData: [0, 1] },
                { targets: 1, orderData: [1, 0] },
                { targets: 2, orderData: [2, 0] },
                { targets: 3, orderData: [3, 0] },
                { targets: 4, orderable: false }
            ]
        });
    });
</script>
</body>

</html>