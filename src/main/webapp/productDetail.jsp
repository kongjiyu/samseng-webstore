<jsp:useBean id="product" scope="session" class="com.samseng.web.models.Product" />
<%@page import="com.samseng.web.models.*" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Detail</title>
  <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
  <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>
<body data-theme="light">
<!--Header-->
<nav class="navbar rounded-box flex w-full items-center justify-between gap-2 shadow-base-300/20 shadow-sm">
  <div class="navbar-start max-md:w-1/4">
    <a class="link text-base-content link-neutral text-xl font-bold no-underline" href="#">
      FlyonUI
    </a>
  </div>
  <div class="navbar-center max-md:hidden">
    <ul class="menu menu-horizontal p-0 font-medium [--menu-active-bg:transparent]">
      <li><a href="staffProfile.jsp">Profile</a></li>
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

<div class="container mx-auto p-6 py-16">
  <div class="flex flex-col lg:flex-row lg:items-stretch bg-base-100 border rounded-lg shadow divide-y lg:divide-y-0 lg:divide-x divide-base-300">
    <!-- Left Panel: Product Information -->
    <div class="w-full lg:w-1/3 p-10 space-y-4">
      <h2 class="text-2xl font-bold">Product Information</h2>
      <div class="card bg-base-100 shadow-md p-4 space-y-4">
        <img class="rounded-lg mt-4" src="http://140.245.115.94<%= ((Product) request.getAttribute("product")).getImages() %>" alt="Product Image">        <div>
          <label class="block font-semibold">Product ID:</label>
          <input type="text" class="input input-bordered w-full" value="<%= ((Product) request.getAttribute("product")).getId() %>" disabled>
        </div>
        <div>
          <label class="block font-semibold">Product Name:</label>
          <input type="text" class="input input-bordered w-full" value="<%= ((Product) request.getAttribute("product")).getName() %>">
        </div>
        <div>
          <label class="block font-semibold">Category:</label>
          <input type="text" class="input input-bordered w-full" value="<%= ((Product) request.getAttribute("product")).getCategory() %>">
        </div>
        <div>
          <label class="block font-semibold">Description:</label>
          <textarea class="textarea resize-y textarea-bordered w-full" rows="5"><%= ((Product) request.getAttribute("product")).getDesc() %></textarea>
        </div>
      </div>
    </div>

    <!-- Right Panel: Product Variants -->
    <div class="w-full lg:w-2/3 p-10 space-y-4">
      <h2 class="text-2xl font-bold">Product Variants</h2>
      <div class="overflow-x-auto">
        <table class="table table-zebra w-full">
          <thead>
          <tr>
            <th class="w-24">VARIANT ID</th>
            <th class="w-60">NAME</th>
            <th>COLOR</th>
            <th>STORAGE</th>
            <th>PRICE</th>
            <th>ACTION</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td><input type="text" class="input input-bordered input-sm" value="V001" disabled></td>
            <td><input type="text" class="input input-bordered input-sm" value="Galaxy Z Flip - Graphite"></td>
            <td><input type="text" class="input input-bordered input-sm" value="Graphite"></td>
            <td><input type="text" class="input input-bordered input-sm" value="256GB"></td>
            <td><input type="text" class="input input-bordered input-sm" value="$999"></td>
            <td>
              <button class="btn btn-circle btn-text btn-sm" aria-label="Edit">
                <span class="icon-[tabler--pencil] size-5"></span>
              </button>
              <button class="btn btn-circle btn-text btn-sm" aria-label="Delete">
                <span class="icon-[tabler--trash] size-5"></span>
              </button>
            </td>
          </tr>
          <tr>
            <td><input type="text" class="input input-bordered input-sm" value="V002" disabled></td>
            <td><input type="text" class="input input-bordered input-sm" value="Galaxy Z Flip - Lavender"></td>
            <td><input type="text" class="input input-bordered input-sm" value="Lavender"></td>
            <td><input type="text" class="input input-bordered input-sm" value="512GB"></td>
            <td><input type="text" class="input input-bordered input-sm" value="$1199"></td>
            <td>
              <button class="btn btn-circle btn-text btn-sm" aria-label="Edit">
                <span class="icon-[tabler--pencil] size-5"></span>
              </button>
              <button class="btn btn-circle btn-text btn-sm" aria-label="Delete">
                <span class="icon-[tabler--trash] size-5"></span>
              </button>
            </td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>