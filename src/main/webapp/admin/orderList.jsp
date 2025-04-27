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
    <title>Order</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
    <link href="<%= request.getContextPath() %>/static/css/datatables.min.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/datatables.min.js"></script>
</head>

<body data-theme="light" class="bg-base-100">

<!-- HEADER -->
<nav class="navbar rounded-box flex w-full items-center justify-between gap-2 shadow-base-300/20 shadow-sm">
    <div class="navbar-start max-md:w-1/4">
        <a class="link text-base-content link-neutral text-xl font-bold no-underline" href="#">
            FlyonUI
        </a>
    </div>
    <div class="navbar-center max-md:hidden">
        <ul class="menu menu-horizontal p-0 font-medium [--menu-active-bg:transparent]">
            <li><a href="customerDetail.jsp">Profile</a></li>
            <li><a href="orderList.jsp">Order</a></li>
            <li><a href="productList.jsp">Product</a></li>
            <li><a href="#">Customers</a></li>
        </ul>
    </div>

    <div class="navbar-end items-center gap-4">
        <div class="dropdown relative inline-flex [--auto-close:inside] [--offset:8] [--placement:bottom-end]">
            <button id="dropdown-scrollable" type="button" class="dropdown-toggle flex items-center"
                    aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
                <div class="avatar">
                    <div class="size-9.5 rounded-full">
                        <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar 1" />
                    </div>
                </div>
            </button>
            <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu"
                aria-orientation="vertical" aria-labelledby="dropdown-avatar">
                <li class="dropdown-header gap-2">
                    <div class="avatar">
                        <div class="w-10 rounded-full">
                            <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar" />
                        </div>
                    </div>
                    <div>
                        <h6 class="text-base-content text-base font-semibold">John Doe</h6>
                        <small class="text-base-content/50">Admin</small>
                    </div>
                </li>
                <li>
                    <a class="dropdown-item" href="#">
                        <span class="icon-[tabler--user]"></span>
                        My Profile
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="#">
                        <span class="icon-[tabler--settings]"></span>
                        Settings
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="#">
                        <span class="icon-[tabler--receipt-rupee]"></span>
                        Billing
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="#">
                        <span class="icon-[tabler--help-triangle]"></span>
                        FAQs
                    </a>
                </li>
                <li class="dropdown-footer gap-2">
                    <a class="btn btn-error btn-soft btn-block" href="#">
                        <span class="icon-[tabler--logout]"></span>
                        Sign out
                    </a>
                </li>
            </ul>
        </div>
    </div>

</nav>


<div class="container mx-auto my-5 py-5 px-4 bg-base-100 rounded-lg border border-base-200 shadow-sm">
    <!-- Actual List of all Orders -->
    <div class="mt-8 overflow-x-auto">
        <table id="orderTable" class="table display" style="width:100%">
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
                    <td><span class="badge badge-warning badge-soft">${order.status()}</span></td>
                    <td><fmt:formatNumber value="${order.netPrice()}" type="currency" currencySymbol="RM " /></td>
                    <td>
                        <div class="dropdown relative inline-flex">
                            <button id="dropdown-menu-icon" type="button"
                                    class="dropdown-toggle btn btn-circle btn-text btn-sm" aria-haspopup="menu"
                                    aria-expanded="false" aria-label="Dropdown">
                                <span class="icon-[tabler--dots] size-5"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu"
                                aria-orientation="vertical" aria-labelledby="dropdown-menu-icon">
                                <li><a class="dropdown-item" href="#">View</a></li>
                            </ul>
                        </div>
                    </td>
                </tr>
            </c:forEach>

            <!-- Just so I remember how to set color for status lol -->

            <%--        <td><span class="badge badge-info badge-soft">Shipping</span></td>--%>
            <%--        <td><span class="badge badge-success badge-soft">Delivery</span></td>--%>

            </tbody>
        </table>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        new DataTable('#orderTable', {
            columnDefs: [
                { targets: 0, orderData: [0, 1] },
                { targets: 1, orderData: [1, 0] },
                { targets: 2, orderData: [2, 0] },
                { targets: 3, orderData: [3, 0] },
                { targets: 4, orderData: [4, 0] },
                { targets: 5, orderable: false }
            ]
        });
    });
</script>
</body>

</html>
