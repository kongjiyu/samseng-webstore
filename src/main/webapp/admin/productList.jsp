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
  <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css" rel="stylesheet" integrity="sha384-J3tLcWkdGTGEaRTYfKrKVaK5EGVBuxR9rg5ZzQFWRuQD+0hZABemSLVXimw8Nrb9" crossorigin="anonymous">
  <link href="https://cdn.datatables.net/v/ju/jq-3.7.0/jszip-3.10.1/dt-2.2.2/af-2.7.0/b-3.2.3/b-colvis-3.2.3/b-html5-3.2.3/b-print-3.2.3/cr-2.0.4/date-1.5.5/fc-5.0.4/fh-4.0.1/kt-2.12.1/r-3.0.4/rg-1.5.1/rr-1.5.0/sc-2.4.3/sb-1.8.2/sp-2.3.3/sl-3.0.0/sr-1.4.1/datatables.min.css" rel="stylesheet" integrity="sha384-+g+ndJuu72XLL84+8jRGssDVZnvh7lfMSOeO0+cflHOJjiQbt8aH4cLu2Z6uXaz/" crossorigin="anonymous">

  <script src="https://cdn.datatables.net/v/ju/jq-3.7.0/jszip-3.10.1/dt-2.2.2/af-2.7.0/b-3.2.3/b-colvis-3.2.3/b-html5-3.2.3/b-print-3.2.3/cr-2.0.4/date-1.5.5/fc-5.0.4/fh-4.0.1/kt-2.12.1/r-3.0.4/rg-1.5.1/rr-1.5.0/sc-2.4.3/sb-1.8.2/sp-2.3.3/sl-3.0.0/sr-1.4.1/datatables.min.js" integrity="sha384-DnuiXl3JOiNY1pqRGOFob/Pgul66wDjeFB2C8KQtnYmXhQH4CXcCu2sL9Sxzj0i6" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js" integrity="sha384-4D3G3GikQs6hLlLZGdz5wLFzuqE9v4yVGAcOH86y23JqBDPzj9viv0EqyfIa6YUL" crossorigin="anonymous"></script></head>
</head>

<body data-theme="light">
<%@ include file="/general/adminHeader.jsp" %>


<div class="container mx-auto my-5 py-5 px-4 bg-base-100 rounded-lg border border-base-200 shadow-sm">
  <div class="flex flex-col flex-wrap gap-3 sm:flex-row sm:items-center sm:justify-between">
    <a href="<%= request.getContextPath() %>/admin/product?action=create" class="btn btn-soft btn-info rounded-full">+ New Product</a>
  </div>

  <div class="mt-8 overflow-x-auto">
    <table id="productTable" class="table display" style="width:100%">
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
        <!-- Product Image and Name -->
        <td>
          <div class="flex items-center gap-3">
            <div class="avatar">
              <div class="bg-base-content/10 h-10 w-10 rounded-md">
                <img src="/uploads/<%= product.getImageUrls().isEmpty() ? '#' : product.getImageUrls().iterator().next() %>" alt="product image" />
              </div>
            </div>
            <div>
              <div class="text-sm opacity-50"><%= product.getId() %></div>
              <div class="font-medium">
                <a class="link link-animated" href="<%= request.getContextPath() %>/admin/product?productId=<%= product.getId() %>">
                  <%= product.getName() %>
                </a>
              </div>
            </div>
          </div>
        </td>

        <!-- Product Category-->
        <td><%= product.getCategory() %></td>

        <!-- Actions -->
        <td>
          <a href="<%= request.getContextPath() %>/admin/product?productId=<%= product.getId() %>" class="btn btn-circle btn-text btn-sm" aria-label="Edit">
            <span class="icon-[tabler--pencil] size-5"></span>
          </a>
        </td>
      </tr>
      <%
          }
        }
      %>
      </tbody>
    </table>
  </div>

</div>
<%@include file="/general/userFooter.jsp"%>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    new DataTable('#productTable', {
      pageLength: 5,
      lengthMenu: [ [5, 10, 25, 50, -1], [5, 10, 25, 50, "All"] ],
      columnDefs: [
        { targets: 0, orderData: [0, 1] },
        { targets: 1, orderData: [1, 0] },
        { targets: 2, orderable: false }
      ]
    });
  });
</script>
</body>

</html>