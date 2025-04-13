<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
  <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
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
<div class="breadcrumbs ml-6">
  <ul>
    <li>
      <a href="#">Admin</a>
    </li>
    <li class="breadcrumbs-separator rtl:rotate-180"><span class="icon-[tabler--chevron-right]"></span></li>
    <li>
      <a href="#">Users</a>
    </li>
    <li class="breadcrumbs-separator rtl:rotate-180"><span class="icon-[tabler--chevron-right]"></span></li>
    <li aria-current="page">User Info</li>
  </ul>
</div>

<div class="flex flex-col gap-6 p-10 backdrop-blur-lg min-h-screen">
  <!-- Profile Section -->
  <div class="bg-base-100 p-8 rounded-lg shadow-lg">
    <h1 class="text-2xl font-bold mb-6">Profile</h1>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <!-- Profile Picture -->
      <div class="col-span-1 flex flex-col items-center">
        <div class="avatar mb-4">
          <div class="w-32 rounded-full ring ring-cyan-400 ring-offset-base-100 ring-offset-2">
            <img src="https://i.pravatar.cc/150?img=3" alt="User Avatar">
          </div>
        </div>
        <input id="avatarUpload" type="file" class="hidden" />
        <button class="btn btn-outline btn-info w-full max-w-xs"
                onclick="document.getElementById('avatarUpload').click();">
          Upload Profile Picture
        </button>
        <button class="btn btn-outline btn-error mt-2">Delete</button>
      </div>

      <!-- Profile Information Form -->
      <div class="col-span-2">
        <form class="space-y-4">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="label">User ID</label>
              <input type="text" class="input input-bordered w-full" placeholder="USR123456"
                     disabled />
            </div>
            <div>
              <label class="label">Username</label>
              <input type="text" class="input input-bordered w-full" placeholder="admin" />
            </div>
            <div>
              <label class="label">Date of Birth</label>
              <input type="date" class="input input-bordered w-full" value="2000-01-01" />
            </div>
            <div>
              <label class="label">Email</label>
              <input type="email" class="input input-bordered w-full"
                     placeholder="user@example.com" />
            </div>
            <div>
              <label class="label">Role</label>
              <select class="select w-full appearance-none" aria-label="select">
                <option disabled selected>User</option>
                <option>Staff</option>
                <option>Admin</option>
              </select>
            </div>
          </div>
          <div class="text-right">
            <button class="btn btn-info">Save</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- Address Section -->
  <div class="bg-base-100 p-8 rounded-lg shadow-lg">
    <h2 class="text-xl font-semibold mb-4">Addresses</h2>
    <div class="space-y-4">
      <!-- First address with default badge -->
      <div class="border border-base-300 p-4 rounded-lg flex justify-between items-start">
        <div>
          <p class="font-semibold">Home Address</p>
          <p class="text-sm">123 Main Street, Springfield</p>
          <p class="text-sm">+1 234 567 890</p>
          <p class="text-sm">USA</p>
          <span class="badge badge-info mt-2">Default</span>
        </div>
        <button class="btn btn-outline btn-sm">Edit</button>
      </div>

      <div class="border border-base-300 p-4 rounded-lg flex justify-between items-start">
        <div>
          <p class="font-semibold">Workplace</p>
          <p class="text-sm">456 Side Road, Shelbyville</p>
          <p class="text-sm">+1 987 654 321</p>
          <p class="text-sm">USA</p>
        </div>
        <button class="btn btn-outline btn-sm">Edit</button>
      </div>
    </div>
    <div class="text-right mt-4">
      <button class="btn btn-info btn-sm">Add New Address</button>
    </div>
  </div>
</div>
</body>
</html>