<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.samseng.web.models.Sales_Order" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order #${order.id} Detail</title>
  <link href="${pageContext.request.contextPath}/static/css/output.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/static/js/flyonui.js"></script>
</head>
<body class="bg-base-200">

<jsp:include page="/general/adminHeader.jsp" />

<!-- Breadcrumbs -->
<div class="breadcrumbs ml-6 my-4">
  <ul>
    <li><a href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
    <li class="breadcrumbs-separator rtl:rotate-180"><span class="icon-[tabler--chevron-right]"></span></li>
    <li aria-current="page">Order #${order.id}</li>
  </ul>
</div>

<div class="container mx-auto p-6">
  <div class="flex flex-col md:flex-row gap-6">

    <!-- Left Column -->
    <div class="flex flex-col gap-6 md:w-2/3">

      <!-- Buyer Information -->
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold mb-4">Buyer Information</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Order ID:</span>
            <span class="text-base-content font-medium">#${order.id != null ? order.id : 'N/A'}</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Username:</span>
            <span class="text-base-content font-medium">${account.username != null ? account.username : 'N/A'}</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Email:</span>
            <span class="text-base-content font-medium">${account.email != null ? account.email : 'N/A'}</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Order Date:</span>
            <span class="text-base-content font-medium">${order.orderedDate != null ? order.orderedDate : 'N/A'}</span>
          </div>
        </div>
      </div>

      <!-- Purchase Details -->
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold mb-4">Purchase Details</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Status:</span>
            <span class="text-base-content font-medium">${order.status != null ? order.status : 'N/A'}</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Payment Method:</span>
            <span class="text-base-content font-medium">${order.paymentMethod != null ? order.paymentMethod : 'N/A'}</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Reference No:</span>
            <span class="text-base-content font-medium">${order.refNo != null ? order.refNo : 'N/A'}</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Voucher Applied:</span>
            <span class="text-base-content font-medium">${order.promo_code != null ? order.promo_code : 'N/A'}</span>
          </div>
        </div>
      </div>

      <!-- Invoice -->
      <div class="bg-base-100 border rounded-lg shadow p-6 w-full">
        <h2 class="text-2xl font-bold mb-4">Invoice</h2>
        <div class="overflow-x-auto">
          <table class="table table-zebra w-full">
            <thead>
            <tr>
              <th class="font-bold">Product</th>
              <th class="font-bold text-center">Qty</th>
              <th class="font-bold text-right">Price</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${order.products}">
              <tr>
                <td>${item.variant.variantName != null ? item.variant.variantName : 'N/A'}</td>
                <td class="text-center">${item.quantity != null ? item.quantity : '0'}</td>
                <td class="text-right">RM ${item.price != null ? item.price : '0.00'}</td>
              </tr>
            </c:forEach>
            <tr class="font-bold">
              <td></td>
              <td class="text-right">Subtotal</td>
              <td class="text-right">RM ${order.grossPrice != null ? order.grossPrice : '0.00'}</td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Tax Charge</td>
              <td class="text-right text-base-content font-medium">RM ${order.taxCharge != null ? order.taxCharge : '0.00'}</td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Delivery Charge</td>
              <td class="text-right text-base-content font-medium">RM ${order.deliveryCharge != null ? order.deliveryCharge : '0.00'}</td>
            </tr>
            <tr class="text-lg font-bold">
              <td></td>
              <td class="text-right">Grand Total</td>
              <td class="text-right">RM ${order.netPrice != null ? order.netPrice : '0.00'}</td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>

    </div>

    <!-- Right Column -->
    <div class="flex flex-col gap-6 md:w-1/3">

      <!-- Buyer Address -->
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold mb-4">Buyer Address</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Receiver Name:</span>
            <span class="text-base-content font-medium">${account.username != null ? account.username : 'N/A'}</span>
          </div>
          <div class="flex flex-col py-2">
            <span class="text-base-content/80">Address:</span>
            <span class="text-base-content font-medium">${order.address.address_1 != null ? order.address.address_1 : 'N/A'}</span>
            <span class="text-base-content font-medium">${order.address.address_2 != null ? order.address.address_2 : ''}</span>
            <span class="text-base-content font-medium">${order.address.address_3 != null ? order.address.address_3 : ''}</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Contact No:</span>
            <span class="text-base-content font-medium">${order.address.contact_no != null ? order.address.contact_no : 'N/A'}</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Country:</span>
            <span class="text-base-content font-medium">${order.address.country != null ? order.address.country : 'N/A'}</span>
          </div>
        </div>
      </div>

      <!-- Order History -->
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold mb-4">Order History</h2>
        <ul class="timeline timeline-vertical">
          <li>
            <div class="timeline-start text-base-content font-medium">${order.orderedDate != null ? order.orderedDate : 'N/A'}</div>
            <div class="timeline-middle">
              <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                <span class="badge badge-info size-3 rounded-full p-0"></span>
              </span>
            </div>
            <div class="timeline-end timeline-box">${order.status != null ? order.status : 'N/A'}</div>
            <hr />
          </li>
        </ul>
      </div>

    </div>
  </div>
</div>

</body>
</html>
