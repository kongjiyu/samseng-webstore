<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link href="./output.css" rel="stylesheet">
  <script defer src="../node_modules/flyonui/flyonui.js"></script>
</head>
<body>
<!--Header-->
<nav class="navbar rounded-box flex w-full items-center justify-between gap-2 shadow-base-300/20 shadow-sm">
  <div class="navbar-start max-md:w-1/4">
    <a class="link text-base-content link-neutral text-xl font-bold no-underline" href="#">
      FlyonUI
    </a>
  </div>
  <div class="navbar-center max-md:hidden">
    <ul class="menu menu-horizontal p-0 font-medium [--menu-active-bg:transparent]">
      <li><a href="#">Profile</a></li>
      <li><a href="#">Order</a></li>
      <li><a href="#">Product</a></li>
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

<div class="container mx-auto p-6 py-16 w-9/10">
  <form method="post" action="<%= request.getContextPath() %>/admin/productDetail?action=update">
    <div class="flex flex-col lg:flex-row lg:items-start bg-base-100 border rounded-lg shadow divide-y lg:divide-y-0 lg:divide-x divide-base-300 gap-0">
      <!-- Left Panel: Product Information -->
      <div class="w-full lg:w-1/3 p-10 space-y-4">
        <h2 class="text-2xl font-bold">Product Information</h2>
        <div class="card bg-base-100 shadow-md p-4 space-y-4">
          <div id="horizontal-thumbnails" data-carousel='{ "loadingClasses": "opacity-0" }' class="relative w-full">
            <div class="carousel">
              <div class="carousel-body opacity-100">
                <div class="carousel-slide">
                  <div class="flex size-full justify-center">
                    <img src="http://halleyey.uk/uploads/SP-S24-1.png" class="object-contain w-auto h-[28rem] mx-auto" alt="product image 1" />
                  </div>
                </div>
                <div class="carousel-slide">
                  <div class="flex size-full justify-center">
                    <img src="https://cdn.flyonui.com/fy-assets/components/table/product-19.png" class="object-contain w-auto h-[28rem] mx-auto" alt="product image 2" />
                  </div>
                </div>
                <div class="carousel-slide">
                  <div class="flex size-full justify-center">
                    <img src="https://cdn.flyonui.com/fy-assets/components/table/product-19.png" class="object-contain w-auto h-[28rem] mx-auto" alt="product image 3" />
                  </div>
                </div>
              </div>
              <div class="carousel-pagination bg-base-100 absolute bottom-0 end-0 start-0 z-1 h-16 flex justify-center gap-2 overflow-x-auto pt-2">
                <img src="https://cdn.flyonui.com/fy-assets/components/table/product-19.png" class="carousel-pagination-item carousel-active:opacity-100 grow object-cover opacity-30 h-20" alt="thumb 1" />
                <img src="https://cdn.flyonui.com/fy-assets/components/table/product-19.png" class="carousel-pagination-item carousel-active:opacity-100 grow object-cover opacity-30 h-20" alt="thumb 2" />
                <img src="https://cdn.flyonui.com/fy-assets/components/table/product-19.png" class="carousel-pagination-item carousel-active:opacity-100 grow object-cover opacity-30 h-20" alt="thumb 3" />
              </div>
              <button type="button" class="carousel-prev">
                  <span class="mb-15" aria-hidden="true">
                    <span class="size-9.5 bg-base-100 flex items-center justify-center rounded-full shadow-base-300/20 shadow-sm">
                      <span class="icon-[tabler--chevron-left] size-5 cursor-pointer rtl:rotate-180"></span>
                    </span>
                  </span>
                <span class="sr-only">Previous</span>
              </button>
              <button type="button" class="carousel-next">
                <span class="sr-only">Next</span>
                <span class="mb-15" aria-hidden="true">
                    <span class="size-9.5 bg-base-100 flex items-center justify-center rounded-full shadow-base-300/20 shadow-sm">
                      <span class="icon-[tabler--chevron-right] size-5 cursor-pointer rtl:rotate-180"></span>
                    </span>
                  </span>
              </button>
            </div>
          </div>
          <div>
            <div>
              <label class="block font-semibold">Product ID:</label>
              <input type="text" class="input input-bordered w-full" value="#12345" disabled>
            </div>
            <div>
              <label class="block font-semibold">Product Name:</label>
              <input type="text" class="input input-bordered w-full" value="Samsung Galaxy Z Flip">
            </div>
            <div>
              <label class="block font-semibold">Category:</label>
              <input type="text" class="input input-bordered w-full" value="Smartphone">
            </div>
            <div>
              <label class="block font-semibold">Description:</label>
              <textarea class="textarea textarea-bordered w-full" rows="4">A foldable phone with premium build, perfect for compact use and style.</textarea>
            </div>
          </div>
        </div>
      </div>

      <!-- Variant Configuration Panel -->
      <div class="w-full lg:w-2/3 p-10 space-y-4">
        <h2 class="text-2xl font-bold mb-2">Attribute</h2>
        <div class="flex justify-end">
          <button type="button" class="btn btn-info btn-sm" aria-haspopup="dialog" aria-expanded="false" aria-controls="add-attribute-modal" data-overlay="#add-attribute-modal">
            <span class="icon-[tabler--plus] mr-1"></span>
            Add Attribute
          </button>
        </div>
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
          <div>
            <label class="font-semibold block mb-2">Color</label>
            <div class="flex flex-wrap gap-2">
              <input type="text" placeholder="e.g. White" class="input input-bordered input-sm" />
              <input type="text" placeholder="e.g. Black" class="input input-bordered input-sm" />
              <input type="text" placeholder="e.g. Yellow" class="input input-bordered input-sm" />
            </div>
            <button type="button" class="btn btn-outline btn-sm mt-2" onclick="addValue(this)">Add Value</button>
          </div>
          <div>
            <label class="font-semibold block mb-2">Storage</label>
            <div class="flex flex-wrap gap-2">
              <input type="text" placeholder="e.g. 256GB" class="input input-bordered input-sm" />
              <input type="text" placeholder="e.g. 512GB" class="input input-bordered input-sm" />
              <input type="text" placeholder="e.g. 1TB" class="input input-bordered input-sm" />
            </div>
            <button type="button" class="btn btn-outline btn-sm mt-2" onclick="addValue(this)">Add Value</button>
          </div>
        </div>
        <div class="flex justify-end mt-4">
          <button class="btn btn-info btn-sm">
            <span class="icon-[tabler--device-floppy] mr-1"></span>
            Save attributes
          </button>
        </div>

        <h2 class="text-2xl font-bold mb-2">Variant</h2>
        <div class="overflow-x-auto">
          <table class="table table-zebra w-full">
            <thead>
            <tr>
              <th>Color</th>
              <th>Storage</th>
              <th>Price</th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <td>White</td>
              <td>256GB</td>
              <td><input type="text" class="input input-bordered input-sm w-28" placeholder="$"></td>
            </tr>
            <tr>
              <td>White</td>
              <td>512GB</td>
              <td><input type="text" class="input input-bordered input-sm w-28" placeholder="$"></td>
            </tr>
            <tr>
              <td>Black</td>
              <td>1TB</td>
              <td><input type="text" class="input input-bordered input-sm w-28" placeholder="$"></td>
            </tr>
            </tbody>
          </table>
        </div>
        <div class="flex justify-end mt-4">
          <button class="btn btn-info btn-sm">
            <span class="icon-[tabler--device-floppy] mr-1"></span>
            Save Variants
          </button>
        </div>
      </div>
  </form>
</div>

<div id="add-attribute-modal" class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden overlay-backdrop-open:bg-black/30" role="dialog" tabindex="-1">
  <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title">Add Attribute</h3>
        <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close" data-overlay="#add-attribute-modal">
          <span class="icon-[tabler--x] size-4"></span>
        </button>
      </div>
      <div class="modal-body">
        <label for="attributeName" class="block font-medium mb-1">Attribute Name:</label>
        <input id="attributeName" type="text" placeholder="e.g. Color" class="input input-bordered w-full">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-soft btn-secondary" data-overlay="#add-attribute-modal">Cancel</button>
        <button type="button" class="btn btn-info" onclick="saveAttribute()">Add Attribute</button>
      </div>
    </div>
  </div>
</div>

<script>
  function addValue(button) {
    const container = button.previousElementSibling;
    const input = document.createElement('input');
    input.type = 'text';
    input.placeholder = 'e.g. New Value';
    input.className = 'input input-bordered input-sm';
    container.appendChild(input);
  }

  function saveAttribute() {
    const name = document.getElementById("attributeName").value.trim();
    if (name) {
      alert("Attribute added: " + name);
      document.querySelector('[data-overlay="#add-attribute-modal"]').click();
    }
  }
</script>
</body>
</html>