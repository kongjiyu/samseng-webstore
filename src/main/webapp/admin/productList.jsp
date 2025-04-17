<%@ page import="com.samseng.web.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product List</title>
  <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
  <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>

<body data-theme="light">
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
  <div class="flex flex-col flex-wrap gap-3 sm:flex-row sm:items-center sm:justify-between">
    <button class="btn btn-soft btn-info rounded-full">+ New Product</button>
    <div class="form-control w-full sm:w-80">
      <div
              class="input input-bordered flex items-center gap-2 focus-within:ring-2 focus-within:ring-cyan-400">
        <span class="icon-[tabler--search] text-base-content/80 size-5"></span>
        <input type="text" placeholder="Search" class="grow bg-transparent focus:outline-none" />
      </div>
    </div>
  </div>

  <div class="mt-8 overflow-x-auto">
    <table class="table">
      <!-- head -->
      <thead>
      <tr>
        <th>Product</th>
        <th>Category</th>
        <th>Action</th>
      </tr>
      </thead>
      <tbody>
      <%
        List<Product> products = (List<Product>) request.getAttribute("products");
        if (products != null) {
          for (Product product : products) {
      %>
      <tr>
        <td>
          <div class="flex items-center gap-3">
            <div class="avatar">
              <div class="bg-base-content/10 h-10 w-10 rounded-md">
                <img src="<%= product.getImageUrls().isEmpty() ? '#' : product.getImageUrls().iterator().next() %>" alt="product image" />
              </div>
            </div>
            <div>
              <div class="text-sm opacity-50"><%= product.getId() %></div>
              <div class="font-medium">
                <a class="link link-animated" href="<%= request.getContextPath() %>/admin/product?id=<%= product.getId() %>">
                  <%= product.getName() %>
                </a>
              </div>
            </div>
          </div>
        </td>
        <td><%= product.getCategory() %></td>
        <td>
          <a href="<%= request.getContextPath() %>/admin/product?id=<%= product.getId() %>" class="btn btn-circle btn-text btn-sm" aria-label="Edit">
            <span class="icon-[tabler--pencil] size-5"></span>
          </a>
          <button class="btn btn-circle btn-text btn-sm" aria-label="Delete">
            <span class="icon-[tabler--trash] size-5"></span>
          </button>
        </td>
      </tr>
      <%
          }
        }
      %>
      </tbody>
    </table>
  </div>

  <div class="flex flex-wrap items-center justify-between gap-2 py-4 pt-6">
    <div class="me-2 block max-w-sm text-sm text-base-content/80 sm:mb-0">
      Showing
      <span class="font-semibold text-base-content/80"><%= request.getAttribute("startItem") %> - <%= request.getAttribute("endItem") %></span>
      of
      <span class="font-semibold"><%= request.getAttribute("totalItems") %></span>
      products
    </div>
    <%
      Integer currentPageAttr = (Integer) request.getAttribute("currentPage");
      Integer totalPagesAttr = (Integer) request.getAttribute("totalPages");

      int currentPage = currentPageAttr != null ? currentPageAttr : 1;
      int totalPages = totalPagesAttr != null ? totalPagesAttr : 1;
    %>
    <form method="get" action="<%= request.getContextPath() %>/admin/product" class="flex items-center gap-x-1">
      <input name="action" value="list" type="hidden" />
      <button type="submit" name="page" value="<%= currentPage - 1 %>" class="btn btn-text btn-square" <%= currentPage <= 1 ? "disabled" : "" %> aria-label="Previous Button">
        <span class="icon-[tabler--chevron-left] size-5 rtl:rotate-180"></span>
      </button>
      <span class="text-base-content/80 mx-3"><%= currentPage %> of <%= totalPages %></span>
      <button type="submit" name="page" value="<%= currentPage + 1 %>" class="btn btn-text btn-square" <%= currentPage >= totalPages ? "disabled" : "" %> aria-label="Next Button">
        <span class="icon-[tabler--chevron-right] size-5 rtl:rotate-180"></span>
      </button>
    </form>
  </div>
</div>


</body>

</html>