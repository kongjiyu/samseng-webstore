<%@ page import="com.samseng.web.models.Sales_Order" %>
<%@ page import="com.samseng.web.models.Order_Product" %>
<%@ page import="com.samseng.web.models.Address" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
  <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>
<body data-theme="light">
<!--Header-->
<%@ include file="/general/adminHeader.jsp" %>
<% Account account=(Account)request.getAttribute("account"); %>
<% Sales_Order salesOrder =(Sales_Order) request.getAttribute("order");%>
<div class="breadcrumbs ml-6">
  <ul>
    <li>
      <a href="#">Staff</a>
    </li>
    <li class="breadcrumbs-separator rtl:rotate-180"><span class="icon-[tabler--chevron-right]"></span></li>
    <li>
      <a href="#">Orders</a>
    </li>
    <li class="breadcrumbs-separator rtl:rotate-180"><span class="icon-[tabler--chevron-right]"></span></li>
    <li aria-current="page">Order #SHIP001</li>
  </ul>
</div>
<div class="container mx-auto p-6">
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
            <span class="text-base-content/80">Address 1:</span>
            <span class="text-base-content font-medium"><%=address.getAddress_1()%></span>
          </div>
          <div class="flex justify-between py-2">
            <span class="text-base-content/80">Address 2:</span>
            <span class="text-base-content font-medium"><%=address.getAddress_2()%></span>-5678</span>
          </div>
          <%if(address.getAddress_3()!=null) {%>
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

        <!-- Trigger Button -->
        <div class="flex justify-center my-4">
          <button type="button" class="btn btn-info" aria-haspopup="dialog" aria-expanded="false"
                  aria-controls="middle-center-modal" data-overlay="#middle-center-modal">
            Update Stage
          </button>
        </div>

        <!-- FlyonUI Modal -->
        <div id="middle-center-modal"
             class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle overlay-backdrop-open:bg-black/30 overlay-scroll-lock hidden"
             role="dialog" tabindex="-1">
          <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300">
            <div class="modal-content">
              <div class="modal-header">
                <h3 class="modal-title">Update Order Stage</h3>
                <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3"
                        aria-label="Close" data-overlay="#middle-center-modal">
                  <span class="icon-[tabler--x] size-4"></span>
                </button>
              </div>
              <div class="modal-body">
                Are you sure you want to update the stage of this order?
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-soft btn-secondary" data-overlay="#middle-center-modal">Cancel</button>
                <form action="<%= request.getContextPath() %>/admin/detail?action=updateStatus" method="post">
                  <input type="hidden" name="orderId" value="<%= salesOrder.getId() %>">
                  <button type="submit" class="btn btn-info">Confirm</button>
                </form>
              </div>
            </div>
          </div>
        </div>

        <!-- Timeline -->
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

<script>
  function openStageModal() {
    const modal = document.getElementById('confirm-stage-modal');
    if (modal) {
      // Toggle modal visibility using FlyonUI's overlay attributes
      modal.classList.toggle('hidden');
      modal.classList.toggle('overlay-open:opacity-100');
    }
  }

  function confirmStageUpdate() {
    alert("Order stage updated (frontend only)");
  }
</script>

</body>
</html>