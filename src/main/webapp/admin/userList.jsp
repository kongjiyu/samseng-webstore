<%@ page import="com.samseng.web.models.Account" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User List</title>
  <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
  <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css" rel="stylesheet" integrity="sha384-J3tLcWkdGTGEaRTYfKrKVaK5EGVBuxR9rg5ZzQFWRuQD+0hZABemSLVXimw8Nrb9" crossorigin="anonymous">
  <link href="https://cdn.datatables.net/v/ju/jq-3.7.0/jszip-3.10.1/dt-2.2.2/af-2.7.0/b-3.2.3/b-colvis-3.2.3/b-html5-3.2.3/b-print-3.2.3/cr-2.0.4/date-1.5.5/fc-5.0.4/fh-4.0.1/kt-2.12.1/r-3.0.4/rg-1.5.1/rr-1.5.0/sc-2.4.3/sb-1.8.2/sp-2.3.3/sl-3.0.0/sr-1.4.1/datatables.min.css" rel="stylesheet" integrity="sha384-+g+ndJuu72XLL84+8jRGssDVZnvh7lfMSOeO0+cflHOJjiQbt8aH4cLu2Z6uXaz/" crossorigin="anonymous">

  <script src="https://cdn.datatables.net/v/ju/jq-3.7.0/jszip-3.10.1/dt-2.2.2/af-2.7.0/b-3.2.3/b-colvis-3.2.3/b-html5-3.2.3/b-print-3.2.3/cr-2.0.4/date-1.5.5/fc-5.0.4/fh-4.0.1/kt-2.12.1/r-3.0.4/rg-1.5.1/rr-1.5.0/sc-2.4.3/sb-1.8.2/sp-2.3.3/sl-3.0.0/sr-1.4.1/datatables.min.js" integrity="sha384-DnuiXl3JOiNY1pqRGOFob/Pgul66wDjeFB2C8KQtnYmXhQH4CXcCu2sL9Sxzj0i6" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js" integrity="sha384-4D3G3GikQs6hLlLZGdz5wLFzuqE9v4yVGAcOH86y23JqBDPzj9viv0EqyfIa6YUL" crossorigin="anonymous"></script></head>
</head>

<body data-theme="light">
<%@include file="/general/adminHeader.jsp"%>

<div class="container mx-auto my-5 py-5 px-4 bg-base-100 rounded-lg border border-base-200 shadow-sm">
  <div class="flex flex-col flex-wrap gap-3 sm:flex-row sm:items-center sm:justify-between">
    <!-- + New User Button -->
    <button type="button" class="btn btn-soft btn-info rounded-full" aria-haspopup="dialog" aria-expanded="false" aria-controls="create-user-modal" data-overlay="#create-user-modal">
      + New User
    </button>
  </div>

  <div class="mt-8 overflow-x-auto">
    <table id="accountTable" class="table display" style="width:100%">
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

          <a href="#" class="btn btn-circle btn-text btn-sm" aria-label="Edit" onclick="return false;">
            <span class="icon-[tabler--eye] size-5"></span>
          </a>

           <% } else if (account.getRole()==Account.Role.STAFF) { %>

          <a href="<%= request.getContextPath() %>/admin/control?action=view&id=<%= account.getId() %>" class="btn btn-circle btn-text btn-sm" aria-label="Edit">
            <span class="icon-[tabler--eye] size-5"></span>
          </a>
           <% }else { %>
          <a href="<%= request.getContextPath() %>/admin/control?action=view&id=<%= account.getId() %>" class="btn btn-circle btn-text btn-sm" aria-label="Edit">
            <span class="icon-[tabler--eye] size-5"></span>
          </a>
           <% }
          } else { %>
          <a href="<%= request.getContextPath() %>/admin/control?action=view&id=<%= account.getId() %>" class="btn btn-circle btn-text btn-sm" aria-label="Edit">
            <span class="icon-[tabler--eye] size-5"></span>
          </a>
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
</div>

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
<script>
  document.addEventListener('DOMContentLoaded', function () {
    new DataTable('#accountTable', {
      columnDefs: [
        { targets: 0, orderData: [0, 1] },
        { targets: 1, orderData: [1, 0] },
        { targets: 2, orderData: [2, 0] },
        { targets: 3, orderData: [3, 0] },
        { targets: 4, orderable: false }
      ]
    });
  });
</script>
</body>
</html>