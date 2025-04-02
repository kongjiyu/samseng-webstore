<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Tailwind v3 with JSP</title>
  <link href="./static/css/output.css" rel="stylesheet">
  <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
  <script src="<%= request.getContextPath() %>/static/js/accordion.js"></script></head>
<body>
<nav class="navbar rounded-t-box gap-4">
  <div class="navbar-start items-center">
    <a class="link text-base-content link-neutral text-xl font-bold no-underline" href="#">
      FlyonUI
    </a>
  </div>
  <div class="navbar-end flex items-center gap-4">
    <button class="btn btn-sm btn-text btn-circle size-8.5 md:hidden">
      <span class="icon-[tabler--search] size-5.5"></span>
    </button>
    <div class="input max-md:hidden rounded-full max-w-56">
      <span class="icon-[tabler--search] text-base-content/80 my-auto me-3 size-5 shrink-0"></span>
      <label class="sr-only" for="submenuInput">Full Name</label>
      <input type="search" class="grow" placeholder="Search" id="submenuInput" />
    </div>
    <div class="dropdown relative inline-flex [--auto-close:inside] [--offset:8] [--placement:bottom-end]">
      <button id="dropdown-scrollable" type="button" class="dropdown-toggle flex items-center" aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
        <div class="avatar">
          <div class="size-9.5 rounded-full">
            <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar 1" />
          </div>
        </div>
      </button>
      <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-52" role="menu" aria-orientation="vertical" aria-labelledby="dropdown-avatar">
        <li class="dropdown-header gap-3 border-0 pt-3">
          <div class="avatar">
            <div class="w-10 rounded-full">
              <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" href="#" alt="avatar 1" />
            </div>
          </div>
          <div>
            <h6 class="text-base-content text-base font-semibold">John Doe</h6>
            <small class="text-base-content/50">Admin</small>
          </div>
        </li>
        <li><hr class="border-base-content/25 -mx-2 " /></li>
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
        <li><hr class="border-base-content/25 -mx-2" /></li>
        <li>
          <a class="dropdown-item btn btn-text btn-error" href="#">
            <span class="icon-[tabler--logout]"></span>
            Sign out
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>
<div class="bg-base-100 flex w-full items-center">
  <ul class="menu menu-horizontal gap-2 text-base">
    <li><a href="#">Link 1</a></li>
    <li><a href="#">Link 2</a></li>
    <li><a href="#">Link 3</a></li>
  </ul>
</div>
</body>
</html>