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

<div class="container mx-auto p-6 mt-[5.5rem]">
  <div class="flex flex-col md:flex-row gap-6">
    <div class="flex flex-col gap-6 md:w-2/3">
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold">Buyer Information</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Shipment ID:</span>
            <span class="text-base-content font-medium">#SHIP001</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Username:</span>
            <span class="text-base-content font-medium">johndoe</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Email:</span>
            <span class="text-base-content font-medium">john@example.com</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Date of Birth:</span>
            <span class="text-base-content font-medium">1990-05-15</span>
          </div>
        </div>
      </div>
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold">Purchase Details</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Status</span>
            <span class="text-base-content font-medium">Shipped</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Payment Method</span>
            <span class="text-base-content font-medium">Credit Card</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Reference No</span>
            <span class="text-base-content font-medium">#REF12345678</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Voucher Applied</span>
            <span class="text-base-content font-medium">WELCOME10</span>
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
            <tr>
              <td>Samsung Galaxy Z Flip</td>
              <td class="text-center">1</td>
              <td class="text-right">$999</td>
            </tr>
            <tr>
              <td>Galaxy Buds Pro</td>
              <td class="text-center">1</td>
              <td class="text-right">$199</td>
            </tr>
            <tr class="font-bold">
              <td></td>
              <td class="text-right">Subtotal</td>
              <td class="text-right">$1198</td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Gross Price</td>
              <td class="text-right text-base-content font-medium">$1198</td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Tax Charge</td>
              <td class="text-right text-base-content font-medium">$119.8</td>
            </tr>
            <tr>
              <td></td>
              <td class="text-right text-base-content/80">Delivery Charge</td>
              <td class="text-right text-base-content font-medium">$20</td>
            </tr>
            <tr class="text-lg font-bold">
              <td></td>
              <td class="text-right">Grand Total</td>
              <td class="text-right">$1337.8</td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div class="flex flex-col gap-6 md:w-1/3">
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold">Buyer Address</h2>
        <div class="divide-y divide-base-200">
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Receiver Name:</span>
            <span class="text-base-content font-medium">John Doe</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Address:</span>
            <span class="text-base-content font-medium">123 Galaxy Road, Suite 100</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Contact No:</span>
            <span class="text-base-content font-medium">+82 10-1234-5678</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Country:</span>
            <span class="text-base-content font-medium">South Korea</span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">State:</span>
            <span class="text-base-content font-medium">Seoul</span>
          </div>
        </div>
      </div>
      <div class="bg-base-100 border rounded-lg shadow p-6">
        <h2 class="text-2xl font-bold">Order History</h2>
        <ul class="timeline timeline-vertical">
          <li>
            <div class="timeline-start text-base-content font-medium">4 April 2025</div>
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
            <div class="timeline-start text-base-content font-medium">2 April 2025</div>
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
            <div class="timeline-start text-base-content font-medium">1 April 2025</div>
            <div class="timeline-middle">
                            <span class="bg-info/20 flex size-4.5 items-center justify-center rounded-full">
                              <span class="badge badge-info size-3 rounded-full p-0"></span>
                            </span>
            </div>
            <div class="timeline-end timeline-box">Orderd</div>
            <hr />
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>
<%@include file="/general/userFooter.jsp"%>
</body>
</html>
