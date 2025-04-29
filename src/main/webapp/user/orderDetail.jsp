<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="order" scope="request" class="com.samseng.web.models.Sales_Order" />
<html>
<head>
    <title>Order Detail</title>
</head>
<body data-theme="light" class="bg-transparent">
<video autoplay muted loop class="fixed top-0 left-0 w-full h-full object-cover -z-10">
  <source src="<%= request.getContextPath() %>/static/video/background3.mp4" type="video/mp4" />
  Your browser does not support the video tag.
</video>
<%@ include file="/general/userHeader.jsp" %>
<% Account account = (Account) request.getAttribute("account"); %>
<div class="container mx-auto p-6">
  <div class="flex flex-col w-full bg-base-100 p-10 px-24 rounded-lg shadow">
    <div class="flex flex-col md:flex-row items-center justify-between mb-10 gap-4 md:gap-0">
      <%
        boolean isOrdered = order.getOrderedDate() != null;
        boolean isPacked = order.getPackDate() != null;
        boolean isShipped = order.getShipDate() != null;
        boolean isDelivered = order.getDeliverDate() != null;
      %>
      <!-- Order Placed -->
      <div class="flex flex-col gap-2 items-center text-center">
        <div class="w-16 h-16 md:w-20 md:h-20 rounded-full border-4 <%= isOrdered ? "border-success text-success" : "border-gray-400 text-gray-400" %> flex items-center justify-center">
          <span class="icon-[tabler--shopping-cart] size-8"></span>
        </div>
        <p class="text-sm <%= isOrdered ? "text-base-content/70" : "text-gray-400" %>">Order Placed</p>
        <% if (isOrdered) { %>
        <p class="text-xs text-base-content/50"><%= order.getOrderedDate() %></p>
        <% } %>
      </div>
      <!-- Connecting Line: Order Placed -> Order Packed -->
      <div class="hidden md:flex flex-1 h-1 mx-2 mt-[-40px] <%= isPacked ? "bg-success" : "bg-gray-400" %>"></div>
      <!-- Order Packed -->
      <div class="flex flex-col gap-2 items-center text-center">
        <div class="w-16 h-16 md:w-20 md:h-20 rounded-full border-4 <%= isPacked ? "border-success text-success" : "border-gray-400 text-gray-400" %> flex items-center justify-center">
          <span class="icon-[tabler--package] size-8"></span>
        </div>
        <p class="text-sm <%= isPacked ? "text-base-content/70" : "text-gray-400" %>">Order Packed</p>
        <% if (isPacked) { %>
        <p class="text-xs text-base-content/50"><%= order.getPackDate() %></p>
        <% } %>
      </div>
      <!-- Connecting Line: Order Packed -> Order Shipped -->
      <div class="hidden md:flex flex-1 h-1 mx-2 mt-[-40px] <%= isShipped ? "bg-success" : "bg-gray-400" %>"></div>
      <!-- Order Shipped -->
      <div class="flex flex-col gap-2 items-center text-center">
        <div class="w-16 h-16 md:w-20 md:h-20 rounded-full border-4 <%= isShipped ? "border-success text-success" : "border-gray-400 text-gray-400" %> flex items-center justify-center">
          <span class="icon-[tabler--truck-delivery] size-8"></span>
        </div>
        <p class="text-sm <%= isShipped ? "text-base-content/70" : "text-gray-400" %>">Order Shipped</p>
        <% if (isShipped) { %>
        <p class="text-xs text-base-content/50"><%= order.getShipDate() %></p>
        <% } %>
      </div>
      <!-- Connecting Line: Order Shipped -> Order Delivered -->
      <div class="hidden md:flex flex-1 h-1 mx-2 mt-[-40px] <%= isDelivered ? "bg-success" : "bg-gray-400" %>"></div>
      <!-- Order Delivered -->
      <div class="flex flex-col gap-2 items-center text-center">
        <div class="w-16 h-16 md:w-20 md:h-20 rounded-full border-4 <%= isDelivered ? "border-success text-success" : "border-gray-400 text-gray-400" %> flex items-center justify-center">
          <span class="icon-[tabler--home-check] size-8"></span>
        </div>
        <p class="text-sm <%= isDelivered ? "text-base-content/70" : "text-gray-400" %>">Order Delivered</p>
        <% if (isDelivered) { %>
        <p class="text-xs text-base-content/50"><%= order.getDeliverDate() %></p>
        <% } %>
      </div>
    </div>
  </div>
</div>
<div class="container mx-auto p-6">
  <div class="flex flex-col md:flex-row gap-6">
    <div class="flex flex-col gap-6 md:w-2/3">
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold">Purchase Details</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Status</span>
            <span class="text-base-content font-medium"><%= order.getStatus()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Payment Method</span>
            <span class="text-base-content font-medium"><%= order.getPaymentMethod()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Reference No</span>
            <span class="text-base-content font-medium"><%= order.getRefNo()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Voucher Applied</span>
            <%if (order.getPromo_code() != null) {%>
            <span class="text-base-content font-medium"><%= order.getPromo_code().getId()%></span>
            <% } else {%>
            <span class="text-base-content font-medium"></span>
            <% } %>
          </div>
        </div>
      </div>
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
            <%List<Order_Product> orderProductList = (List<Order_Product>) request.getAttribute("products");%>
            <%for (Order_Product orderList : orderProductList) {%>
            <tr>
              <td><%= orderList.getVariant().getVariantName()%>
              </td>
              <td class="text-center"><%= orderList.getQuantity()%>
              </td>
              <td class="text-right">RM<%=orderList.getPrice()%>
              </td>
            </tr>
            <% } %>
            <tr class="font-bold">
              <td></td>
              <td class="text-right">Subtotal</td>
              <td class="text-right">RM<%=order.getGrossPrice()%>
              </td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Gross Price</td>
              <td class="text-right text-base-content font-medium">RM<%=order.getGrossPrice()%>
              </td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Tax Charge</td>
              <td class="text-right text-base-content font-medium">RM<%=order.getTaxCharge()%>
              </td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Delivery Charge</td>
              <td class="text-right text-base-content font-medium">RM<%=order.getDeliveryCharge()%>
              </td>
            </tr>
            <% if (order.getPromo_code() != null) {%>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Discount Amount</td>
              <td class="text-right text-base-content font-medium">RM<%=order.getDiscountAmount()%>
              </td>
            </tr>
            <%}%>
            <tr class="text-lg font-bold">
              <td></td>
              <td class="text-right">Grand Total</td>
              <td class="text-right">RM<%=order.getNetPrice()%>
              </td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <%Address address = (Address) request.getAttribute("addresses"); %>
    <div class="flex flex-col gap-6 md:w-1/3">
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold">Buyer Address</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Receiver Name:</span>
            <span class="text-base-content font-medium"><%=account.getUsername()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Address 1:</span>
            <span class="text-base-content font-medium"><%=address.getAddress_1()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Address 2:</span>
            <span class="text-base-content font-medium"><%=address.getAddress_2()%></span>
          </div>
          <%if (address.getAddress_3() != null) {%>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Address 3:</span>
            <span class="text-base-content font-medium"><%=address.getAddress_3()%></span>
          </div>
          <% } %>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Contact No:</span>
            <span class="text-base-content font-medium"><%=address.getContact_no()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Postcode:</span>
            <span class="text-base-content font-medium"><%=address.getPostcode()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">State:</span>
            <span class="text-base-content font-medium"><%=address.getState()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Country:</span>
            <span class="text-base-content font-medium"><%=address.getCountry()%></span>
          </div>
        </div>
      </div>
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold">Buyer Information</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Shipment ID:</span>
            <span class="text-base-content font-medium">#SHIP001</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Username:</span>
            <span class="text-base-content font-medium"><%= account.getUsername() %></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Email:</span>
            <span class="text-base-content font-medium"><%= account.getEmail() %></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Date of Birth:</span>
            <span class="text-base-content font-medium"><%= account.getDob() %></span>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<%@include file="/general/userFooter.jsp"%>
</body>
</html>
