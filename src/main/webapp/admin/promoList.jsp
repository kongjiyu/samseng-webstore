<%@ page import="com.samseng.web.models.Promo_Code" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voucher List</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>

<body data-theme="light">
<%@ include file="/general/adminHeader.jsp" %>

<div class="container mx-auto my-5 py-5 px-4 bg-base-100 rounded-lg border border-base-200 shadow-sm">
    <div class="flex flex-col flex-wrap gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div class="form-control w-full sm:w-80">
            <button type="button" class="btn btn-soft btn-info rounded-full" aria-haspopup="dialog"
                    aria-expanded="false" aria-controls="new-promo-modal" data-overlay="#new-promo-modal">+ New Promo
                Code
            </button>
        </div>
    </div>

    <div class="mt-8 overflow-x-auto">
        <table class="table">
            <thead>
            <tr>
                <th>Promo Code</th>
                <th>Description</th>
                <th>Discount</th>
                <th>Status</th>
                <th>Availability</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Promo_Code> promoList = (List<Promo_Code>) request.getAttribute("promoList");
                if (promoList != null) {
                    for (Promo_Code promo : promoList) {
            %>
            <tr>
                <td><%= promo.getId() %>
                </td>
                <td><%= promo.getDesc() %>
                </td>
                <td><%= String.format("%.2f", promo.getDiscount() * 100) %>%</td>
                <td>
    <span class="badge <%= promo.isAvailability() ? "badge-success" : "badge-neutral" %> badge-soft">
      <%= promo.isAvailability() ? "Active" : "Inactive" %>
    </span>
                </td>
                <td>
                    <form action="<%=request.getContextPath()%>/admin/promo" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="toggle" />
                        <input type="hidden" name="code" value="<%= promo.getId() %>" />
                        <input type="hidden" name="available" value="<%= !promo.isAvailability() %>" id="availability-<%= promo.getId() %>" />
                        <input
                                type="checkbox"
                                class="switch switch-info"
                                <%= promo.isAvailability() ? "checked" : "" %>
                                onchange="this.form.submit();"
                        />
                    </form>
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
<!-- New Promo Code Modal -->
<div id="new-promo-modal"
     class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden backdrop-blur-sm [--body-scroll:true]"
     role="dialog" tabindex="-1">
    <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Create New Promo Code</h3>
                <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close"
                        data-overlay="#new-promo-modal">
                    <span class="icon-[tabler--x] size-4"></span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addPromoForm" class="space-y-4" action="<%=request.getContextPath()%>/admin/promo" method="post">
                  <input type="hidden" name="action" value="add" />
                  <input type="text" name="code" placeholder="Promo Code" class="input input-bordered w-full" required/>
                  <input type="text" name="description" placeholder="Description" class="input input-bordered w-full" required/>
                  <input type="number" name="discount" placeholder="Discount %" class="input input-bordered w-full" step="0.01" required/>
                  <label class="flex items-center gap-2">
                      <span>Availability:</span>
                      <input type="checkbox" name="available" class="switch switch-info" checked/>
                  </label>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft btn-secondary" data-overlay="#new-promo-modal">Cancel</button>
                <button type="submit" form="addPromoForm" class="btn btn-info">Save Promo Code</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/general/userFooter.jsp"%>

</body>

</html>