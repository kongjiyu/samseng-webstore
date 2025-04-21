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
<nav class="navbar rounded-box flex w-full items-center justify-between gap-2 shadow-base-300/20 shadow-sm">
  <div class="navbar-start max-md:w-1/4">
    <a class="link text-base-content link-neutral text-xl font-bold no-underline" href="#">
      FlyonUI
    </a>
  </div>
  <div class="navbar-center max-md:hidden">
    <ul class="menu menu-horizontal p-0 font-medium [--menu-active-bg:transparent]">
      <li><a href="customerDetail.jsp">Profile</a></li>
      <li><a href="orderList.jsp">Order</a></li>
      <li><a href="productList.jsp">Product</a></li>
      <li><a href="#">Customers</a></li>
    </ul>
  </div>

  <div class="navbar-end items-center gap-4">
    <div class="dropdown relative inline-flex [--auto-close:inside] [--offset:8] [--placement:bottom-end]">
      <button id="dropdown-scrollable" type="button" class="dropdown-toggle flex items-center"
              aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
        <div class="avatar">
          <div class="size-9.5 rounded-full">
            <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar 1" />
          </div>
        </div>
      </button>
      <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu"
          aria-orientation="vertical" aria-labelledby="dropdown-avatar">
        <li class="dropdown-header gap-2">
          <div class="avatar">
            <div class="w-10 rounded-full">
              <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar" />
            </div>
          </div>
          <div>
            <h6 class="text-base-content text-base font-semibold">John Doe</h6>
            <small class="text-base-content/50">Admin</small>
          </div>
        </li>
        <li>
          <a class="dropdown-item" href="#">
            <span class="icon-[tabler--user]"></span>
            My Profile
          </a>
        </li>
        <li>
          <a class="dropdown-item" href="#">
            <span class="icon-[tabler--settings]"></span>
            Settings
          </a>
        </li>
        <li>
          <a class="dropdown-item" href="#">
            <span class="icon-[tabler--receipt-rupee]"></span>
            Billing
          </a>
        </li>
        <li>
          <a class="dropdown-item" href="#">
            <span class="icon-[tabler--help-triangle]"></span>
            FAQs
          </a>
        </li>
        <li class="dropdown-footer gap-2">
          <a class="btn btn-error btn-soft btn-block" href="#">
            <span class="icon-[tabler--logout]"></span>
            Sign out
          </a>
        </li>
      </ul>
    </div>
  </div>

</nav>
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
                <button type="button" class="btn btn-info" onclick="confirmStageUpdate()">Confirm</button>
              </div>
            </div>
          </div>
        </div>

        <!-- Timeline -->
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
            <div class="timeline-start text-base-content font-medium">3 April 2025</div>
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
            <div class="timeline-end timeline-box">Ordered</div>
            <hr />
          </li>
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