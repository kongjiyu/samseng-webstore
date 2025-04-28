<%--
  Created by IntelliJ IDEA.
  User: kongjy
  Date: 21/04/2025
  Time: 4:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<video autoplay muted loop class="fixed top-0 left-0 w-full h-full object-cover -z-10">
  <source src="<%= request.getContextPath() %>/static/video/background3.mp4" type="video/mp4" />
  Your browser does not support the video tag.
</video>
<%@ include file="/general/userHeader.jsp" %>
  <% Account account=(Account)request.getAttribute("account"); %>
  <%Sales_Order salesOrder =(Sales_Order) request.getAttribute("order");%>
<div class="container mx-auto p-6 mt-[5.5rem]">
  <div class="flex flex-col md:flex-row gap-6">
    <div class="flex flex-col gap-6 md:w-2/3">
      --Profile--
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
      --/Profile--
      --Purchase Details--
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold">Purchase Details</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Status</span>
            <span class="text-base-content font-medium"><%= salesOrder.getStatus()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Payment Method</span>
            <span class="text-base-content font-medium"><%= salesOrder.getPaymentMethod()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Reference No</span>
            <span class="text-base-content font-medium"><%= salesOrder.getRefNo()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Voucher Applied</span>
            <%if(salesOrder.getPromo_code()!=null) {%>
            <span class="text-base-content font-medium"><%= salesOrder.getPromo_code().getId()%></span>
            <% } else {%>
            <span class="text-base-content font-medium"></span>
            <% } %>
          </div>
        </div>
      </div>
      --/Purchase Detail--
      --Invoice--
      <div class="bg-base-100 border rounded-lg shadow p-6 w-full">
        <h2 class="text-2xl font-bold mb-4">Invoice</h2>
        --Invoice--
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
            <%for(Order_Product orderList :orderProductList) {%>
            <tr>
              <td><%= orderList.getVariant().getVariantName()%></td>
              <td class="text-center"><%= orderList.getQuantity()%></td>
              <td class="text-right">$<%=orderList.getPrice()%></td>
            </tr>
            <% } %>
            <tr class="font-bold">
              <td></td>
              <td class="text-right">Subtotal</td>
              <td class="text-right">$<%=salesOrder.getGrossPrice()%></td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Gross Price</td>
              <td class="text-right text-base-content font-medium">$<%=salesOrder.getGrossPrice()%></td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Tax Charge</td>
              <td class="text-right text-base-content font-medium">$<%=salesOrder.getTaxCharge()%></td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Delivery Charge</td>
              <td class="text-right text-base-content font-medium">$<%=salesOrder.getDeliveryCharge()%></td>
            </tr>
            <% if(salesOrder.getPromo_code()!=null){%>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Discount Amount</td>
              <td class="text-right text-base-content font-medium">$<%=salesOrder.getDiscountAmount()%></td>
            </tr>
            <%}%>
            <tr class="text-lg font-bold">
              <td></td>
              <td class="text-right">Grand Total</td>
              <td class="text-right">$<%=salesOrder.getNetPrice()%></td>
            </tr>
            </tbody>
          </table>
        </div>
        --/Invoice--
      </div>
    </div>
    <%Address address =(Address) request.getAttribute("addresses"); %>
    <div class="flex flex-col gap-6 md:w-1/3">
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold">Buyer Address</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Receiver Name:</span>
            <span class="text-base-content font-medium"><%=account.getUsername()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Address:</span>
            <span class="text-base-content font-medium"><%=address.getAddress_1()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Address:</span>
            <span class="text-base-content font-medium"><%=address.getAddress_2()%></span>
          </div>
          <%if(address.getAddress_3()!=null) {%>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Address:</span>
            <span class="text-base-content font-medium"><%=address.getAddress_3()%></span>
          </div>
          <% } %>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Contact No:</span>
            <span class="text-base-content font-medium"><%=address.getContact_no()%></span>
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
        <h2 class="text-2xl font-bold">Order History</h2>
        <ul class="timeline timeline-vertical">
          <%if(salesOrder.getDeliverDate()!=null){%>
          <li>
            <div class="timeline-start text-base-content font-medium"><%=salesOrder.getDeliverDate()%></div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Delivered</div>
            <hr />
          </li>
          <li>
            <hr />
            <div class="timeline-start text-base-content font-medium"><%=salesOrder.getShipDate()%></div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Shipped</div>
            <hr />
          </li>
          <li>
            <hr />
            <div class="timeline-start text-base-content font-medium"><%=salesOrder.getPackDate()%></div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Packed</div>
            <hr />
          </li>
          <li>
            <hr />
            <div class="timeline-start text-base-content font-medium"><%=salesOrder.getOrderedDate()%></div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Ordered</div>
            <hr />
          </li>
          <% } else if (salesOrder.getShipDate()!=null) { %>
          <li>
            <hr />
            <div class="timeline-start text-base-content font-medium"><%=salesOrder.getShipDate()%></div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Shipped</div>
            <hr />
          </li>
          <li>
            <hr />
            <div class="timeline-start text-base-content font-medium"><%=salesOrder.getPackDate()%></div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Packed</div>
            <hr />
          </li>
          <li>
            <hr />
            <div class="timeline-start text-base-content font-medium"><%=salesOrder.getOrderedDate()%></div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Ordered</div>
            <hr />
          </li>
          <% } else if (salesOrder.getPackDate()!=null) { %>
          <li>
            <hr />
            <div class="timeline-start text-base-content font-medium"><%=salesOrder.getPackDate()%></div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Packed</div>
            <hr />
          </li>
          <li>
            <hr />
            <div class="timeline-start text-base-content font-medium"><%=salesOrder.getOrderedDate()%></div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Ordered</div>
            <hr />
          </li>
         <% } else {%>
          <li>
            <hr />
            <div class="timeline-start text-base-content font-medium"><%=salesOrder.getOrderedDate()%></div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Ordered</div>
            <hr />
          </li>
          <% } %>
        </ul>
      </div>
    </div>
  </div>
</div>
<%@include file="/general/userFooter.jsp"%>
</body>
</html>
