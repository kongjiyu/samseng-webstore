<jsp:useBean id="Account" scope="session" class="com.samseng.web.models.Account"/>
<%@page import="com.samseng.web.models.*" %>
<%@page import="com.samseng.web.dto.CartItemDTO" %>
<%@page import="java.util.List" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Header</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">

</head>
<body>
<nav class="navbar backdrop-blur-lg bg-white/10 text-white shadow-lg gap-4 fixed top-0 left-0 w-full z-50">
    <div class="navbar-start items-center justify-between max-md:w-full">
        <a class="link text-white text-xl font-bold no-underline" href="<%= request.getContextPath() %>/index.jsp">
            SAMSENG
        </a>
    </div>
    <div class="navbar-center max-md:hidden bg-transparent text-white">
        <ul
                class="menu menu-horizontal gap-2 p-0 text-base rtl:ml-20 !bg-transparent !text-white !shadow-none !border-none ">
            <li><a href="/products" class="!bg-transparent !text-white">Products</a></li>
            <li><a href="/promotions.jsp" class="!bg-transparent !text-white">Promotion</a></li>
            <li><a href="/contactUs.jsp" class="!bg-transparent !text-white">Contact Us</a></li>
        </ul>
    </div>

    <div class="navbar-end flex items-center gap-4">
        <!--Search Button-->
        <div class="navbar-end items-center gap-4">
            <button class="btn btn-sm btn-text btn-circle size-8.5" aria-label="Search Button" type="button"
                    aria-haspopup="dialog" aria-expanded="false" aria-controls="html-modal-combo-box"
                    data-overlay="#html-modal-combo-box">
                <span class="icon-[tabler--search] size-[1.375rem] text-base text-white"></span>
            </button>
        </div>
        <!--Cart Button-->
        <%
            List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("cart");
        %>
        <div class="dropdown relative inline-flex [--auto-close:inside] [--offset:8] [--placement:bottom-end]">
            <button id="dropdown-scrollable" type="button"
                    class="dropdown-toggle btn btn-text btn-circle dropdown-open:bg-base-content/10 size-10"
                    aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
                <div class="indicator">
                    <span class="indicator-item badge badge-secondary badge-sm rounded-full"><%=cart != null && !cart.isEmpty() ? cart.size() : "0"%></span>
                    <span class="icon-[tabler--shopping-bag] size-[1.375rem] text-base text-white"></span>
                </div>
            </button>
            <div class="dropdown-menu dropdown-open:opacity-100 hidden" role="menu" aria-orientation="vertical"
                 aria-labelledby="dropdown-scrollable">
                <div class="dropdown-header justify-center">
                    <h6 class="text-base-content text-base">Cart</h6>
                </div>
                <div
                        class="vertical-scrollbar horizontal-scrollbar rounded-scrollbar text-base-content/80 max-h-56 overflow-auto max-md:max-w-60">
                    <%
                        if (cart != null && !cart.isEmpty()) {
                            for (CartItemDTO item : cart) {
                    %>
                    <a href="<%= request.getContextPath() %>/product?productId=<%= item.variant().getProduct().getId()%>" class="no-underline">
                    <div class="dropdown-item">
                        <div class="avatar">
                            <div class="w-10 rounded-full">
                                <img src="/uploads/<%= item.imageUrl() %>" alt="product image"/>
                            </div>
                        </div>
                        <div class="w-60">
                            <h6 class="truncate text-base"><%= item.variant().getVariantName() %>
                            </h6>
                            <small class="text-base-content/50 truncate">Qty: <%= item.quantity() %>
                            </small>
                        </div>
                    </div>
                    </a>
                    <%
                        }
                    } else {
                    %>
                    <div class="dropdown-item">
                        <div class="w-full text-center text-base-content/50">
                            No products in cart
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <a href="<%= request.getContextPath() %>/cart" class="dropdown-footer justify-center gap-1">
                    <span class="icon-[tabler--eye] size-4"></span>
                    View all
                </a>
            </div>
        </div>
        <!--User Profile-->
        <%
            if (request.getUserPrincipal() != null) {
                Account profile = (Account) session.getAttribute("profile");
        %>
        <div class="dropdown relative inline-flex [--auto-close:inside] [--offset:8] [--placement:bottom-end]">
            <button id="dropdown-scrollable" type="button" class="dropdown-toggle flex items-center"
                    aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
                <div class="relative inline-flex items-center justify-center w-10 h-10 overflow-hidden bg-secondary rounded-full">
                    <%
                        String[] nameParts = profile.getUsername().trim().split("\\s+");
                        StringBuilder initials = new StringBuilder();
                        for (String part : nameParts) {
                            if (!part.isEmpty()) {
                                initials.append(part.charAt(0));
                                if (initials.length() == 2) break;
                            }
                        }
                    %>
                    <span class="text-3xl text-white uppercase"><%= initials.toString() %></span>
                </div>
            </button>
            <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu"
                aria-orientation="vertical" aria-labelledby="dropdown-avatar">
                <li class="dropdown-header gap-2">
                    <div class="relative inline-flex items-center justify-center w-10 h-10 overflow-hidden bg-secondary rounded-full">
                        <span class="text-3xl text-white uppercase"><%= initials.toString() %></span>
                    </div>
                    <div>
                        <h6 class="text-base-content text-base font-semibold"><%=profile.getUsername()%>
                        </h6>
                        <small class="text-base-content/50"><%=profile.getRole().name()%>
                        </small>
                    </div>
                </li>
                <li>
                    <a class="dropdown-item active:text-cyan-500" href="<%= request.getContextPath() %>/user/profile">
                        <span class="icon-[tabler--user]"></span>
                        My Profile
                    </a>
                </li>
                <%if(profile.getRole().name().equals("ADMIN")||profile.getRole().name().equals("STAFF")){ %>
                <li>
                    <a class="dropdown-item active:text-cyan-500" href="<%= request.getContextPath() %>/admin/report.jsp">
                        <span class="icon-[tabler--user-cog]"></span>
                        Administration
                    </a>
                </li>
                <% } %>
                <li>
                    <a class="dropdown-item active:text-cyan-500" href="<%= request.getContextPath() %>/user/orders">
                        <span class="icon-[tabler--receipt-rupee]"></span>
                        Order Detail
                    </a>
                </li>
                <li class="dropdown-footer gap-2">
                    <a class="btn btn-error btn-soft btn-block" href="<%= request.getContextPath() %>/logout">
                        <!--logout-->
                        <span class="icon-[tabler--logout]"></span>
                        Sign out
                    </a>
                </li>
            </ul>
        </div>
        <% } else {%>
        <a href="<%= request.getContextPath() %>/login-flow">
            <button class="btn btn-gradient btn-secondary rounded-full">Log In</button>
        </a>
        <%}%>
    </div>
</nav>
<div id="html-modal-combo-box"
     class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 [--body-scroll:true] hidden"
     role="dialog" tabindex="-1">
    <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300">
        <div class="modal-content">
            <div class="relative" data-combo-box='{
                    "preventVisibility": true,
                    "groupingType": "default",
                    "preventSelection": true,
                    "isOpenOnFocus": true,
                    "groupingTitleTemplate": "<div class=\"block text-xs text-base-content/50 m-3 mb-1\"></div>"
                  }'>
                <div class="modal-header block">
                    <div class="relative">
                        <input class="input ps-8 focus:ring-2 focus:ring-cyan-500 focus:border-cyan-500" type="text"
                               placeholder="Search or type a command"
                               role="combobox" aria-expanded="false" value="" autofocus=""
                               data-combo-box-input=""/>
                        <span
                                class="icon-[tabler--search] text-base-content absolute start-3 top-1/2 size-4 shrink-0 -translate-y-1/2"
                                data-combo-box-toggle=""></span>
                    </div>
                </div>
                <!-- SearchBox Modal Body -->
                <div class="modal-body overflow-y-auto mt-0 max-h-72 p-1.5" data-combo-box-output="">
                    <div class="space-y-0.5 p-0.5" data-combo-box-output-items-wrapper="">
                        <!-- Item -->
                        <%
                            List<Product> searchableProducts = (List<Product>) session.getAttribute("searchableProducts");
                            if (searchableProducts != null) {
                                for (Product product : searchableProducts) {
                        %>
                        <div data-combo-box-output-item='{"group": {"name": "best" , "title": ""}}'
                             tabindex="0">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none"
                               href="<%= request.getContextPath() %>/user/product?productId=<%= product.getId() %>">
                                <div class="avatar">
                                    <div class="bg-base-content/10 h-10 w-10 rounded-md">
                                        <img src="/uploads/<%= product.getImageUrls().isEmpty() ? '#' : product.getImageUrls().iterator().next() %>" alt="product image" />
                                    </div>
                                </div>

                                <div class="flex flex-col">
                                    <div class="text-sm opacity-50"><%= product.getId() %></div>
                                    <div class="font-medium"><%= product.getName() %></div>
                                    <span class="text-base-content/50 ms-auto hidden text-xs sm:inline"
                                          data-combo-box-search-text="<%= product.getName() %>" data-combo-box-value="">
                                        </span>
                                </div>
                            </a>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.js"></script>
<%
    String toastMessage = (String) session.getAttribute("toastMessage");
    String toastType = (String) session.getAttribute("toastType");
    session.removeAttribute("toastMessage");
    session.removeAttribute("toastType");
    if (toastMessage != null) {
%>
<script>
    window.addEventListener('DOMContentLoaded', () => {
        // Create an instance of Notyf
        var notyf = new Notyf();

        notyf.<%=toastType%>("<%=toastMessage%>");
    });
</script>
<% } %>
</body>
</html>
