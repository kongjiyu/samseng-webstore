<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="orders" type="java.util.List<com.samseng.web.dto.OrderListingDTO>" scope="request"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Orders</title>
    <link href="${pageContext.request.contextPath}/static/css/output.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/static/js/flyonui.js"></script>
</head>
<body class="bg-base-100">

<!-- Navbar -->
<nav class="navbar shadow-sm">
    <div class="navbar-start">
        <a class="text-xl font-bold" href="#">FlyonUI</a>
    </div>
    <div class="navbar-center">
        <ul class="menu menu-horizontal">
            <li><a href="customerDetail.jsp">Profile</a></li>
            <li><a href="orderList.jsp">Order</a></li>
            <li><a href="productList.jsp">Product</a></li>
            <li><a href="#">Customers</a></li>
        </ul>
    </div>
    <div class="navbar-end">
        <div class="dropdown">
            <button class="dropdown-toggle">
                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" class="rounded-full w-10"/>
            </button>
            <ul class="dropdown-menu">
                <li><a href="#">My Profile</a></li>
                <li><a href="#">Settings</a></li>
                <li><a href="#">Billing</a></li>
                <li><a href="#">FAQs</a></li>
                <li><a href="#" class="btn btn-error btn-block">Sign out</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mx-auto p-6 bg-white rounded-lg shadow-sm">
    <!-- Flash message -->
    <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-success mb-4">
                ${sessionScope.msg}
            <c:remove var="msg" scope="session"/>
        </div>
    </c:if>

    <!-- Search -->
    <form method="get" action="orders" class="mb-4 flex justify-end">
        <div class="form-control w-full sm:w-80">
            <div class="input input-bordered flex items-center gap-2">
                <span class="icon-[tabler--search] size-5"></span>
                <input name="searchQuery" type="text" placeholder="Search Order ID"
                       class="grow" value="${searchQuery}"/>
            </div>
        </div>
    </form>

    <!-- Orders Table -->
    <div class="overflow-x-auto">
        <table class="table w-full">
            <thead>
            <tr>
                <th>Order ID</th><th>Customer</th><th>Date</th><th>Status</th><th>Total</th><th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>#${order.id()}</td>
                    <td>
                        <div class="flex items-center gap-3">
                            <div class="avatar">
                                <div class="rounded-full w-8 h-8">
                                    <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-2.png" alt="Avatar"/>
                                </div>
                            </div>
                            <div>
                                <div class="font-bold">${order.username()}</div>
                                <div class="text-sm opacity-50">${order.email()}</div>
                            </div>
                        </div>
                    </td>
                    <td>${order.orderedDate()}</td>
                    <td>
                        <form method="post" action="orders"
                              onsubmit="return confirm('Change status to ' + this.newStatus.value + '?');">
                            <input type="hidden" name="action" value="updateStatus"/>
                            <input type="hidden" name="orderId" value="${order.id()}"/>
                            <input type="hidden" name="currentPage" value="${currentPage}"/>

                            <select name="newStatus" onchange="this.form.submit()" class="badge badge-soft cursor-pointer">
                                <option value="cancel"     ${order.status()=='cancel'    ? 'selected' : ''}>Cancel</option>
                                <option value="delivered"  ${order.status()=='delivered' ? 'selected' : ''}>Delivered</option>
                                <option value="delivering" ${order.status()=='delivering'? 'selected' : ''}>Delivering</option>
                                <option value="pending"    ${order.status()=='pending'   ? 'selected' : ''}>Pending</option>
                                <option value="shipping"   ${order.status()=='shipping'  ? 'selected' : ''}>Shipping</option>
                                <option value="shipped"    ${order.status()=='shipped'   ? 'selected' : ''}>Shipped</option>
                            </select>
                        </form>
                    </td>
                    <td>
                        <fmt:formatNumber value="${order.netPrice()}" type="currency" currencySymbol="RM "/>
                    </td>
                    <td>
                        <a href="orderDetail.jsp?orderId=${order.id()}" class="btn btn-sm btn-outline">View</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <div class="flex flex-col sm:flex-row justify-between items-center mt-6 gap-4">
        <div class="text-sm">
            Showing <strong>${startItem}</strong> – <strong>${endItem}</strong>
            of <strong>${totalItems}</strong> orders
        </div>

        <div class="flex items-center gap-2">
            <c:if test="${currentPage > 1}">
                <a href="orders?page=${currentPage - 1}
                       <c:if test='${not empty searchQuery}'> &amp;searchQuery=${searchQuery}</c:if>"
                   class="btn btn-sm">
                    ‹ Prev
                </a>
            </c:if>

            <c:if test="${currentPage < totalPages}">
                <a href="orders?page=${currentPage + 1}
                       <c:if test='${not empty searchQuery}'> &amp;searchQuery=${searchQuery}</c:if>"
                   class="btn btn-sm">
                    Next ›
                </a>
            </c:if>
        </div>
    </div>

</body>
</html>
