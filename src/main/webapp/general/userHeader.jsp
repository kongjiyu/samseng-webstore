<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Header</title>
</head>
<body>
<nav data-theme="dark" class="navbar backdrop-blur-lg bg-black/10 text-white shadow-lg gap-4 fixed top-0 left-0 w-full z-50">
    <div class="navbar-start items-center justify-between max-md:w-full">
        <a class="link text-white text-xl font-bold no-underline" href="#">
            SAMSENG
        </a>
    </div>
    <div class="navbar-center max-md:hidden bg-transparent text-white">
        <ul
                class="menu menu-horizontal gap-2 p-0 text-base rtl:ml-20 !bg-transparent !text-white !shadow-none !border-none ">
            <li class="dropdown relative inline-flex [--auto-close:inside] [--offset:9] [--placement:bottom-end]">
                <button id="dropdown-end" type="button"
                        class="dropdown-toggle dropdown-open:bg-base-content/10 dropdown-open:text-base-content max-md:px-2 !bg-transparent !text-white"
                        aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
                    Products
                    <span class="icon-[tabler--chevron-down] dropdown-open:rotate-180 size-4"></span>
                </button>
                <ul class="dropdown-menu dropdown-open:opacity-100 hidden w-48" role="menu"
                    aria-orientation="vertical" aria-labelledby="nested-dropdown">
                    <li><a class="dropdown-item" href="#">Mobile</a></li>
                    <li><a class="dropdown-item" href="#">TV</a></li>
                    <li><a class="dropdown-item" href="#">Accessories</a></li>
                </ul>
            </li>
            <li><a href="#" class="!bg-transparent !text-white">Promotion</a></li>
            <li><a href="#" class="!bg-transparent !text-white">Contact Us</a></li>
        </ul>
    </div>

    <div class="navbar-end flex items-center gap-4">
        <!--Search Button-->
        <div class="navbar-end items-center gap-4">
            <button class="btn btn-sm btn-text btn-circle size-8.5" aria-label="Search Button" type="button"
                    aria-haspopup="dialog" aria-expanded="false" aria-controls="html-modal-combo-box"
                    data-overlay="#html-modal-combo-box">
                <span class="icon-[tabler--search] text-white size-[1.375rem] text-base"></span>
            </button>
        </div>
        <!--Cart Button-->
        <div class="dropdown relative inline-flex [--auto-close:inside] [--offset:8] [--placement:bottom-end]">
            <button id="dropdown-scrollable" type="button"
                    class="dropdown-toggle btn btn-text btn-circle dropdown-open:bg-base-content/10 size-10"
                    aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
                <div class="indicator">
                    <span class="indicator-item bg-error size-2 rounded-full"></span>
                    <span class="icon-[tabler--shopping-bag] text-white size-[1.375rem] text-base"></span>
                </div>
            </button>
            <div class="dropdown-menu dropdown-open:opacity-100 hidden" role="menu" aria-orientation="vertical"
                 aria-labelledby="dropdown-scrollable">
                <div class="dropdown-header justify-center">
                    <h6 class="text-base-content text-base">Cart</h6>
                </div>
                <div
                        class="vertical-scrollbar horizontal-scrollbar rounded-scrollbar text-base-content/80 max-h-56 overflow-auto max-md:max-w-60">
                    <div class="dropdown-item">
                        <div class="avatar away-bottom">
                            <div class="w-10 rounded-full">
                                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar 1" />
                            </div>
                        </div>
                        <div class="w-60">
                            <h6 class="truncate text-base">Charles Franklin</h6>
                            <small class="text-base-content/50 truncate">Accepted your connection</small>
                        </div>
                    </div>
                    <div class="dropdown-item">
                        <div class="avatar">
                            <div class="w-10 rounded-full">
                                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-2.png" alt="avatar 2" />
                            </div>
                        </div>
                        <div class="w-60">
                            <h6 class="truncate text-base">Martian added moved Charts & Maps task to the done
                                board.</h6>
                            <small class="text-base-content/50 truncate">Today 10:00 AM</small>
                        </div>
                    </div>
                    <div class="dropdown-item">
                        <div class="avatar online-bottom">
                            <div class="w-10 rounded-full">
                                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-8.png" alt="avatar 8" />
                            </div>
                        </div>
                        <div class="w-60">
                            <h6 class="truncate text-base">New Message</h6>
                            <small class="text-base-content/50 truncate">You have new message from
                                Natalie</small>
                        </div>
                    </div>
                    <div class="dropdown-item">
                        <div class="avatar placeholder">
                            <div class="bg-neutral text-neutral-content w-10 rounded-full p-2">
                                <span class="icon-[tabler--user] size-full"></span>
                            </div>
                        </div>
                        <div class="w-60">
                            <h6 class="truncate text-base">Application has been approved 🚀</h6>
                            <small class="text-base-content/50 text-wrap">Your ABC project application has been
                                approved.</small>
                        </div>
                    </div>
                    <div class="dropdown-item">
                        <div class="avatar">
                            <div class="w-10 rounded-full">
                                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-10.png" alt="avatar 10" />
                            </div>
                        </div>
                        <div class="w-60">
                            <h6 class="truncate text-base">New message from Jane</h6>
                            <small class="text-base-content/50 text-wrap">Your have new message from
                                Jane</small>
                        </div>
                    </div>
                    <div class="dropdown-item">
                        <div class="avatar">
                            <div class="w-10 rounded-full">
                                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-3.png" alt="avatar 3" />
                            </div>
                        </div>
                        <div class="w-60">
                            <h6 class="truncate text-base">Barry Commented on App review task.</h6>
                            <small class="text-base-content/50 truncate">Today 8:32 AM</small>
                        </div>
                    </div>
                </div>
                <a href="#" class="dropdown-footer justify-center gap-1">
                    <span class="icon-[tabler--eye] size-4"></span>
                    View all
                </a>
            </div>
        </div>
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
                    <a class="dropdown-item active:text-cyan-500" href="#">
                        <span class="icon-[tabler--user]"></span>
                        My Profile
                    </a>
                </li>
                <li>
                    <a class="dropdown-item active:text-cyan-500" href="#">
                        <span class="icon-[tabler--settings]"></span>
                        Settings
                    </a>
                </li>
                <li>
                    <a class="dropdown-item active:text-cyan-500" href="#">
                        <span class="icon-[tabler--receipt-rupee]"></span>
                        Order
                    </a>
                </li>
                <li>
                    <a class="dropdown-item active:text-cyan-500" href="#">
                        <span class="icon-[tabler--help-triangle]"></span>
                        Vouchers
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
        <button class="btn btn-gradient btn-secondary rounded-full">Log In -></button>
    </div>
</nav>

</body>
</html>
