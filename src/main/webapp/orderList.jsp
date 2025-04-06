<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order</title>
  <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
  <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>

<body data-theme="light" class="bg-base-100">
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

<div class="container mx-auto my-5 py-5 px-4 bg-base-100 rounded-lg border border-base-200 shadow-sm">
  <div class="flex flex-col flex-wrap gap-3 sm:flex-row sm:items-center sm:justify-between">
    <div class=""></div>
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
        <th>Order ID</th>
        <th>Customer</th>
        <th>Date</th>
        <th>Status</th>
        <th>Total</th>
        <th>Action</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td>#ORD001</td>
        <td>
          <div class="flex items-center gap-3">
            <div class="avatar avatar-placeholder">
              <div class="bg-base-content/10 h-10 w-10 rounded-full">
                <img src="../img/avatar-placeholder.jpg"
                     alt="Customer avatar" />
              </div>
            </div>
            <div>
              <div class="font-medium">John Doe</div>
              <div class="text-sm opacity-50">johndoe@example.com</div>
            </div>
          </div>
        </td>
        <td>Apr 5, 2025</td>
        <td><span class="badge badge-warning badge-soft">Packaging</span></td>
        <td>$1,499</td>
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
      <tr>
        <td>#ORD002</td>
        <td>
          <div class="flex items-center gap-3">
            <div class="avatar">
              <div class="bg-base-content/10 h-10 w-10 rounded-full">
                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png"
                     alt="Customer avatar" />
              </div>
            </div>
            <div>
              <div class="font-medium">John Doe</div>
              <div class="text-sm opacity-50">johndoe@example.com</div>
            </div>
          </div>
        </td>
        <td>Apr 5, 2025</td>
        <td><span class="badge badge-info badge-soft">Shipping</span></td>
        <td>$1,499</td>
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
      <tr>
        <td>#ORD003</td>
        <td>
          <div class="flex items-center gap-3">
            <div class="avatar">
              <div class="bg-base-content/10 h-10 w-10 rounded-full">
                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png"
                     alt="Customer avatar" />
              </div>
            </div>
            <div>
              <div class="font-medium">John Doe</div>
              <div class="text-sm opacity-50">johndoe@example.com</div>
            </div>
          </div>
        </td>
        <td>Apr 5, 2025</td>
        <td><span class="badge badge-success badge-soft">Delivery</span></td>
        <td>$1,499</td>
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
      </tbody>
    </table>
  </div>

  <div class="flex flex-wrap items-center justify-between gap-2 py-4 pt-6">
    <div class="me-2 block max-w-sm text-sm text-base-content/80 sm:mb-0">
      Showing <span class="font-semibold text-base-content/80">1-4</span> of <span
            class="font-semibold">20</span> orders
    </div>
    <nav class="join">
      <button type="button" class="btn btn-text btn-square" aria-label="Previous Button">
        <span class="icon-[tabler--chevron-left] size-5 rtl:rotate-180"></span>
      </button>
      <div class="flex items-center gap-x-1">
        <button type="button" class="btn btn-text btn-square pointer-events-none"
                aria-current="page">1</button>
        <span class="text-base-content/80 mx-3">of</span>
        <button type="button" class="btn btn-text btn-square pointer-events-none">3</button>
      </div>
      <button type="button" class="btn btn-text btn-square" aria-label="Next Button">
        <span class="icon-[tabler--chevron-right] size-5 rtl:rotate-180"></span>
      </button>
    </nav>
  </div>
</div>


</body>

</html>
