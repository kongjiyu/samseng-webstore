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
<%@ include file="/general/adminHeader.jsp" %>


<div class="container mx-auto my-5 py-5 px-4 bg-base-100 rounded-lg border border-base-200 shadow-sm">
  <div class="flex flex-col flex-wrap gap-3 sm:flex-row sm:items-center sm:justify-between">
    <a href="<%= request.getContextPath() %>/admin/product?action=create" class="btn btn-soft btn-info rounded-full">+ New Product</a>
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
          <button type="button" class="btn btn-circle btn-text btn-sm" aria-haspopup="dialog" aria-expanded="false" aria-controls="delete-modal-<%= product.getId() %>" data-overlay="#delete-modal-<%= product.getId() %>" aria-label="Delete">            <span class="icon-[tabler--trash] size-5"></span>
          </button>
        </td>
      </tr>
      <div id="delete-modal-<%= product.getId() %>" class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden" role="dialog" tabindex="-1">
        <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300">
          <div class="modal-content">
            <div class="modal-header">
              <h3 class="modal-title">Confirm Delete</h3>
              <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close" data-overlay="#delete-modal-<%= product.getId() %>">
                <span class="icon-[tabler--x] size-4"></span>
              </button>
            </div>
            <div class="modal-body">
              Are you sure you want to delete the product "<%= product.getName() %>"?
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-soft btn-secondary" data-overlay="#delete-modal-<%= product.getId() %>">Cancel</button>
              <form method="post" action="<%= request.getContextPath() %>/admin/product">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="productId" value="<%= product.getId() %>"/>
                <button type="submit" class="btn btn-error">Delete</button>
              </form>
            </div>
          </div>
        </div>
      </div>
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