<%@ page import="com.samseng.web.models.Account" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order</title>
  <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
  <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>

<body>
<nav class="navbar rounded-box flex w-full items-center justify-between gap-2 shadow-base-300/20 shadow-sm">
  <div class="navbar-start max-md:w-1/4">
    <a class="link text-base-content link-neutral text-xl font-bold no-underline" href="#">
      FlyonUI
    </a>
  </div>
  <div class="navbar-center max-md:hidden">
    <ul class="menu menu-horizontal p-0 font-medium [--menu-active-bg:transparent]">
      <li><a href="#">Profile</a></li>
      <li><a href="#">Order</a></li>
      <li><a href="#">Product</a></li>
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
    <div class="form-control w-full sm:w-user80">
      <div
              class="input input-bordered flex items-center gap-2 focus-within:ring-2 focus-within:ring-cyan-400">
        <span class="icon-[tabler--search] text-base-content/80 size-5"></span>
        <form action="/admin/control" method="post" class="flex items-center gap-2">
          <input type="text" name="search" placeholder="Search" class="grow bg-transparent border border-gray-300 rounded px-3 py-1 focus:outline-none focus:ring focus:ring-blue-300"/>
          <input type="hidden" name="action" value="search" />
          <input type="hidden" name="page" value="1" />
          <button type="submit" class="bg-blue-500 text-white px-4 py-1 rounded hover:bg-blue-600 transition">
            Search
          </button>
        </form>
      </div>
    </div>
  </div>

  <div class="mt-8 overflow-x-auto">
    <table class="table">
      <!-- head -->
      <thead>
      <tr>
        <th>User ID</th>
        <th>Customer</th>
        <th>Date Of Birth</th>
        <th>Role</th>
        <th>Action</th>
      </tr>
      </thead>
      <tbody>
      <%
        List<Account> accountList = (List<Account>) request.getAttribute("accountList");
        if (accountList != null) {
          for (Account account : accountList) {
      %>
      <tr>
        <td>#<%= account.getId() %></td>
        <td>
          <div class="flex items-center gap-3">
            <div class="avatar avatar-placeholder">
              <div class="bg-base-content/10 h-10 w-10 rounded-full">
                <img src="../img/avatar-placeholder.jpg" %>"
                     alt="Customer avatar" />
              </div>
            </div>
            <div>
              <div class="font-medium"><%= account.getUsername() %></div>
              <div class="text-sm opacity-50"><%= account.getEmail() %></div>
            </div>
          </div>
        </td>
        <td><%= account.getDob()%></td>
        <td>
          <div class="font-medium"><%= account.getRole() %></div>
        </td>
        <td>
          <div class="dropdown relative inline-flex">
            <button type="button"
                    class="dropdown-toggle btn btn-circle btn-text btn-sm" aria-haspopup="menu"
                    aria-expanded="false" aria-label="Dropdown">
              <span class="icon-[tabler--dots] size-5"></span>
            </button>
            <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu">
              <li>
                <a class="dropdown-item" href="<%= request.getContextPath() %>/admin/control?action=view&id=<%= account.getId() %>">View</a>
              </li>
              <li>
                <a class="dropdown-item" href="<%= request.getContextPath() %>/admin/control?action=update&id=<%= account.getId() %>">Update</a>
              </li>
              <li>
                <a class="dropdown-item" href="<%= request.getContextPath() %>/admin/control?action=delete&id=<%= account.getId() %>"
                   onclick="return confirm('Are you sure you want to delete this account?');">
                  Delete
                </a>
              </li>

            </ul>
          </div>
        </td>
      </tr>
      <%
        }
      } else {
      %>
      <tr>
        <td colspan="5">No accounts found.</td>
      </tr>
      <%
        }
      %>
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