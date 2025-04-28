<%@ page import="com.samseng.web.models.Account" %>
<%@ page import="com.samseng.web.dto.CartItemDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Header</title>
  <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
  <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">

</head>
<body>
<nav class="navbar rounded-box flex w-full items-center justify-between gap-2 shadow-base-300/20 shadow-sm">
  <div class="navbar-start max-md:w-1/4">
    <a class="link text-base-content link-neutral text-xl font-bold no-underline" href="/">
      SAMSENG
    </a>
  </div>
  <div class="navbar-center max-md:hidden">
    <ul class="menu menu-horizontal p-0 font-medium [--menu-active-bg:transparent]">
      <li><a href="<%= request.getContextPath() %>/admin/report.jsp">Dashboard</a></li>
      <li><a href="<%= request.getContextPath() %>/admin/orders">Order</a></li>
      <li><a href="<%= request.getContextPath() %>/admin/product?action=list">Product</a></li>
      <li><a href="<%= request.getContextPath() %>/admin/control">User</a></li>
    </ul>
  </div>

  <div class="navbar-end items-center gap-4">
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
          <span class="icon-[tabler--shopping-bag] size-[1.375rem] text-base"></span>
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
      if(request.getUserPrincipal() !=null) {
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
            <h6 class="text-base-content text-base font-semibold"><%=profile.getUsername()%></h6>
            <small class="text-base-content/50"><%=profile.getRole().name()%></small>
          </div>
        </li>
        <li>
          <a class="dropdown-item active:text-cyan-500" href="<%= request.getContextPath() %>/user/profile">
            <span class="icon-[tabler--user]"></span>
            My Profile
          </a>
        </li>
        <li>
          <a class="dropdown-item active:text-cyan-500" href="<%= request.getContextPath() %>/admin/product">
            <span class="icon-[tabler--settings]"></span>
            Administration
          </a>
        </li>
        <li>
          <a class="dropdown-item active:text-cyan-500" href="<%= request.getContextPath() %>/user/orders">
            <span class="icon-[tabler--receipt-rupee]"></span>
            Order
          </a>
        </li>
        <li class="dropdown-footer gap-2">
          <a class="btn btn-error btn-soft btn-block" href="<%= request.getContextPath() %>/logout"><!--logout-->
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
