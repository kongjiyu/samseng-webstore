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
            <div class="form-control w-full sm:w-80">
                <div
                        class="input input-bordered flex items-center gap-2 focus-within:ring-2 focus-within:ring-cyan-400">
                    <span class="icon-[tabler--search] text-base-content/80 size-5"></span>
                    <input type="text" placeholder="Search" class="grow bg-transparent focus:outline-none"/>
                </div>
            </div>
        </div>

        <div class="mt-8 overflow-x-auto">
            <table class="table">
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
                        <td><span class="badge badge-warning badge-soft">${order.status()}</span></td>
                        <td><fmt:formatNumber value="${order.netPrice()}" type="currency" currencySymbol="RM "/></td>
                        <td>
                            <div class="dropdown relative inline-flex">
                                <button id="dropdown-menu-icon" type="button"
                                        class="dropdown-toggle btn btn-circle btn-text btn-sm" aria-haspopup="menu"
                                        aria-expanded="false" aria-label="Dropdown">
                                    <span class="icon-[tabler--dots] size-5"></span>
                                </button>
                                <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu"
                                    aria-orientation="vertical" aria-labelledby="dropdown-menu-icon">
                                    <li>
                                        <a class="dropdown-item"
                                           href="${pageContext.request.contextPath}/user/detail?action=view&id=${order.id()}">
                                            View
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Pagination View -->
        <div class="flex flex-wrap items-center justify-between gap-2 py-4 pt-6">
            <div class="me-2 block max-w-sm text-sm text-base-content/80 sm:mb-0">
                Showing
                <span class="font-semibold text-base-content/80"><%= request.getAttribute("startItem") %> - <%= request.getAttribute("endItem") %></span>
                of
                <span class="font-semibold"><%= request.getAttribute("totalItems") %></span>
                orders

            </div>
            <%
                Integer currentPageAttr = (Integer) request.getAttribute("currentPage");
                Integer totalPagesAttr = (Integer) request.getAttribute("totalPages");

                int currentPage = currentPageAttr != null ? currentPageAttr : 1;
                int totalPages = totalPagesAttr != null ? totalPagesAttr : 1;
            %>
            <form method="get" action="<%= request.getContextPath() %>/admin/orders" class="flex items-center gap-x-1">
                <input name="action" value="list" type="hidden"/>
                <button type="submit" name="page" value="<%= currentPage - 1 %>"
                        class="btn btn-text btn-square" <%= currentPage <= 1 ? "disabled" : "" %>
                        aria-label="Previous Button">
                    <span class="icon-[tabler--chevron-left] size-5 rtl:rotate-180"></span>
                </button>
                <span class="text-base-content/80 mx-3"><%= currentPage %> of <%= totalPages %></span>
                <button type="submit" name="page" value="<%= currentPage + 1 %>"
                        class="btn btn-text btn-square" <%= currentPage >= totalPages ? "disabled" : "" %>
                        aria-label="Next Button">
                    <span class="icon-[tabler--chevron-right] size-5 rtl:rotate-180"></span>
                </button>
            </form>
        </div>
    </div>

<%--    <%--%>
<%--    Account profile = (Account) session.getAttribute("profile");--%>
<%--    %>--%>


</div>
<%@include file="/general/userFooter.jsp" %>
</body>

</html>