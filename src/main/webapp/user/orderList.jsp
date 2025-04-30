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
    <title>Order List</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css" rel="stylesheet" integrity="sha384-J3tLcWkdGTGEaRTYfKrKVaK5EGVBuxR9rg5ZzQFWRuQD+0hZABemSLVXimw8Nrb9" crossorigin="anonymous">
    <link href="https://cdn.datatables.net/v/ju/jq-3.7.0/jszip-3.10.1/dt-2.2.2/af-2.7.0/b-3.2.3/b-colvis-3.2.3/b-html5-3.2.3/b-print-3.2.3/cr-2.0.4/date-1.5.5/fc-5.0.4/fh-4.0.1/kt-2.12.1/r-3.0.4/rg-1.5.1/rr-1.5.0/sc-2.4.3/sb-1.8.2/sp-2.3.3/sl-3.0.0/sr-1.4.1/datatables.min.css" rel="stylesheet" integrity="sha384-+g+ndJuu72XLL84+8jRGssDVZnvh7lfMSOeO0+cflHOJjiQbt8aH4cLu2Z6uXaz/" crossorigin="anonymous">

    <script src="https://cdn.datatables.net/v/ju/jq-3.7.0/jszip-3.10.1/dt-2.2.2/af-2.7.0/b-3.2.3/b-colvis-3.2.3/b-html5-3.2.3/b-print-3.2.3/cr-2.0.4/date-1.5.5/fc-5.0.4/fh-4.0.1/kt-2.12.1/r-3.0.4/rg-1.5.1/rr-1.5.0/sc-2.4.3/sb-1.8.2/sp-2.3.3/sl-3.0.0/sr-1.4.1/datatables.min.js" integrity="sha384-DnuiXl3JOiNY1pqRGOFob/Pgul66wDjeFB2C8KQtnYmXhQH4CXcCu2sL9Sxzj0i6" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js" integrity="sha384-4D3G3GikQs6hLlLZGdz5wLFzuqE9v4yVGAcOH86y23JqBDPzj9viv0EqyfIa6YUL" crossorigin="anonymous"></script></head>
</head>

<body data-theme="light" class="flex flex-col min-h-screen bg-transparent">
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