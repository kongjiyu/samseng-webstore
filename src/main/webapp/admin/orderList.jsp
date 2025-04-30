<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="com.samseng.web.models.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="orders" type="java.util.List<com.samseng.web.dto.OrderListingDTO>" scope="request" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order List</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css" rel="stylesheet" integrity="sha384-J3tLcWkdGTGEaRTYfKrKVaK5EGVBuxR9rg5ZzQFWRuQD+0hZABemSLVXimw8Nrb9" crossorigin="anonymous">
    <link href="https://cdn.datatables.net/v/ju/jq-3.7.0/jszip-3.10.1/dt-2.2.2/af-2.7.0/b-3.2.3/b-colvis-3.2.3/b-html5-3.2.3/b-print-3.2.3/cr-2.0.4/date-1.5.5/fc-5.0.4/fh-4.0.1/kt-2.12.1/r-3.0.4/rg-1.5.1/rr-1.5.0/sc-2.4.3/sb-1.8.2/sp-2.3.3/sl-3.0.0/sr-1.4.1/datatables.min.css" rel="stylesheet" integrity="sha384-+g+ndJuu72XLL84+8jRGssDVZnvh7lfMSOeO0+cflHOJjiQbt8aH4cLu2Z6uXaz/" crossorigin="anonymous">

    <script src="https://cdn.datatables.net/v/ju/jq-3.7.0/jszip-3.10.1/dt-2.2.2/af-2.7.0/b-3.2.3/b-colvis-3.2.3/b-html5-3.2.3/b-print-3.2.3/cr-2.0.4/date-1.5.5/fc-5.0.4/fh-4.0.1/kt-2.12.1/r-3.0.4/rg-1.5.1/rr-1.5.0/sc-2.4.3/sb-1.8.2/sp-2.3.3/sl-3.0.0/sr-1.4.1/datatables.min.js" integrity="sha384-DnuiXl3JOiNY1pqRGOFob/Pgul66wDjeFB2C8KQtnYmXhQH4CXcCu2sL9Sxzj0i6" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js" integrity="sha384-4D3G3GikQs6hLlLZGdz5wLFzuqE9v4yVGAcOH86y23JqBDPzj9viv0EqyfIa6YUL" crossorigin="anonymous"></script></head>

<body data-theme="light" class="bg-base-100">
<%@include file="/general/adminHeader.jsp"%>

<div class="container mx-auto my-5 py-5 px-4 bg-base-100 rounded-lg border border-base-200 shadow-sm">
    <!-- Actual List of all Orders -->
        <table id="orderTable" style="width:100%">
            <!-- head -->
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Date</th>
                <th>Status</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orders}">
                <!--This is one single Order-->
                <tr>
                    <td>${order.id()}</td>
                    <td>
                        <div class="flex items-center gap-3">
                            <!-- AVATAR START-->
                            <div class="relative inline-flex items-center justify-center w-10 h-10 overflow-hidden bg-gray-100 rounded-full dark:bg-gray-600">
                                <span class="text-3xl text-base-content uppercase">
                                    <c:forEach var="name" items="${fn:split(order.username(), ' ')}">${name.charAt(0)}</c:forEach>
                                </span>
                            </div>
                            <!-- AVATAR END -->

                            <div>
                                <div class="font-medium">${order.username()}</div>
                                <div class="text-sm opacity-50">${order.email()}</div>
                            </div>
                        </div>
                    </td>
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
                    <td><fmt:formatNumber value="${order.netPrice()}" type="currency" currencySymbol="RM " /></td>
                    <td>
                        <a href=" ${pageContext.request.contextPath}/admin/detail?action=view&id=${order.id()}" class="btn btn-circle btn-text btn-sm" aria-label="Edit">
                            <span class="icon-[tabler--eye] size-5"></span>
                        </a>
                    </td>
                </tr>
            </c:forEach>

            <!-- Just so I remember how to set color for status lol -->

            <%--        <td><span class="badge badge-info badge-soft">Shipping</span></td>--%>
            <%--        <td><span class="badge badge-success badge-soft">Delivery</span></td>--%>

            </tbody>
        </table>
</div>
<%@include file="/general/userFooter.jsp"%>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        new DataTable('#orderTable', {
            columnDefs: [
                { targets: 0, orderData: [0, 1] },
                { targets: 1, orderData: [1, 0] },
                { targets: 2, orderData: [2, 0] },
                { targets: 3, orderData: [3, 0] },
                {
                    targets: 4, // The index of your 'Total' column
                    render: function (data, type, row) {
                        if (type === 'sort' || type === 'type') {
                            // Remove 'RM', commas, and spaces, then parse as float
                            return parseFloat(data.replace(/[^\d.-]/g, '')) || 0;
                        }
                        return data;
                    }
                },
                { targets: 5, orderable: false }
            ],
            order: [[2, 'desc']]
        });
    });
</script>
</body>

</html>
