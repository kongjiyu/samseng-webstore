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

<body data-theme="light">
<%@include file="/general/adminHeader.jsp"%>

<div class="container mx-auto my-5 py-5 px-4 bg-base-100 rounded-lg border border-base-200 shadow-sm">
  <div class="flex flex-col flex-wrap gap-3 sm:flex-row sm:items-center sm:justify-between">
    <!-- + New User Button -->
    <button type="button" class="btn btn-soft btn-info rounded-full" aria-haspopup="dialog" aria-expanded="false" aria-controls="create-user-modal" data-overlay="#create-user-modal">
      + New User
    </button>
    <form action="/admin/control" method="post" class="form-control w-full sm:w-80">
      <input type="hidden" name="action" value="search" />
      <input type="hidden" name="page" value="1" />
      <div class="flex items-center gap-2 mb-4">
          <input type="text" name="search" placeholder="Search" class="px-3 py-1 rounded border border-gray-300" />
          <button type="submit" class="btn btn-primary">Search</button>
      </div>
    </form>
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
      <% if (account.getRole()!=null &&  account.getEmail()!=null){%>
      <tr>
        <td><%= account.getId() %></td>
        <td>
          <div class="flex items-center gap-3">
            <div class="relative inline-flex items-center justify-center w-10 h-10 overflow-hidden bg-secondary rounded-full">
              <%
                String[] nameParts = account.getUsername().trim().split("\\s+");
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
        <%Account profileCheck = (Account) session.getAttribute("profile");%>
        <td>
          <%if (profileCheck.getRole()==Account.Role.STAFF){ %>
          <% if(account.getRole()==Account.Role.ADMIN ){ %>
          <div class="dropdown relative inline-flex">
            <button type="button"
                    class="dropdown-toggle btn btn-circle btn-text btn-sm" aria-haspopup="menu"
                    aria-expanded="false" aria-label="Dropdown">
              <span class="icon-[tabler--dots] size-5"></span>
            </button>
            <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu">
              <li>
                <a class="dropdown-item text-gray-400 cursor-not-allowed" href="#" onclick="return false;">View</a>
              </li>
              <li>
                <a class="dropdown-item text-gray-400 cursor-not-allowed" href="#" onclick="return false;">Delete</a>
              </li>
            </ul>
          </div>
          <% } else if (account.getRole()==Account.Role.STAFF) { %>
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
                <a class="dropdown-item text-gray-400 cursor-not-allowed" href="#" onclick="return false;">Delete</a>
              </li>
            </ul>
          </div>

          <% }else { %>
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
                <a class="dropdown-item" href="<%= request.getContextPath() %>/admin/control?action=delete&id=<%= account.getId() %>"
                   onclick="return confirm('Are you sure you want to delete this account?');">
                  Delete
                </a>
              </li>
            </ul>
          </div>
          <% }
          } else { %>
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
                <a class="dropdown-item" href="<%= request.getContextPath() %>/admin/control?action=delete&id=<%= account.getId() %>"
                   onclick="return confirm('Are you sure you want to delete this account?');">
                  Delete
                </a>
              </li>
            </ul>
          </div>
          <%}%>
        </td>
      </tr>
      <% }  %>
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
      Showing
      <span class="font-semibold text-base-content/80"><%= request.getAttribute("startItem") %> - <%= request.getAttribute("endItem") %></span>
      of
      <span class="font-semibold"><%= request.getAttribute("totalItems") %></span>
      account
    </div>
    <%
      Integer currentPageAttr = (Integer) request.getAttribute("currentPage");
      Integer totalPagesAttr = (Integer) request.getAttribute("totalPages");

      int currentPage = currentPageAttr != null ? currentPageAttr : 1;
      int totalPages = totalPagesAttr != null ? totalPagesAttr : 1;
    %>
    <form method="get" action="<%= request.getContextPath() %>/admin/control" class="flex items-center gap-x-1">
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

<!-- Create User Modal -->
<div id="create-user-modal" class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden" role="dialog" tabindex="-1">
  <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300">
    <form action="/admin/control" method="post" class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title">Create New User</h3>
        <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close" data-overlay="#create-user-modal">
          <span class="icon-[tabler--x] size-4"></span>
        </button>
      </div>
      <div class="modal-body space-y-4">
        <input type="hidden" name="action" value="create" />
        <div>
          <label class="label">Username</label>
          <input type="text" class="input input-bordered w-full" name="username" required />
        </div>
        <div>
          <label class="label">Date of Birth</label>
          <input type="date" class="input input-bordered w-full" name="dob" required />
        </div>
        <div>
          <label class="label">Email</label>
          <input type="email" class="input input-bordered w-full" name="email" required />
        </div>
        <div>
          <label class="label">Role</label>
          <select class="select w-full appearance-none" name="role" required>
            <option value="USER">User</option>
            <option value="STAFF">Staff</option>
            <option value="ADMIN">Admin</option>
          </select>
        </div>
        <p class="text-sm text-warning">Default password for new users will be <code>"changeit"</code></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-soft btn-secondary" data-overlay="#create-user-modal">Cancel</button>
        <button type="submit" class="btn btn-primary">Create</button>
      </div>
    </form>
  </div>
</div>

</html>