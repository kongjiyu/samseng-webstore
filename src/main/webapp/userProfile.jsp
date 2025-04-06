<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<video autoplay muted loop class="fixed top-0 left-0 w-full h-full object-cover -z-10">
    <source src="<%= request.getContextPath() %>/static/video/background3.mp4" type="video/mp4" />
    Your browser does not support the video tag.
</video>
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

<div class="flex flex-col gap-6 p-10 pt-[5.5rem] backdrop-blur-lg min-h-screen">
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
                            <input type="date" class="input input-bordered w-full" value="2000-01-01" disabled />
                        </div>
                        <div>
                            <label class="label">Email</label>
                            <input type="email" class="input input-bordered w-full"
                                   placeholder="user@example.com" />
                        </div>
                        <div>
                            <label class="label">Role</label>
                            <input type="text" class="input input-bordered w-full" placeholder="User" disabled />
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

<footer data-theme="dark" class="footer bg-base-200 flex flex-col items-center gap-4 p-6">
    <div class="flex items-center gap-2 text-xl font-bold">
        <span>SAMSENG</span>
    </div>
    <aside>
        <p>©2025 SAMSENG</p>
    </aside>
    <nav class="text-base-content grid-flow-col gap-4">
        <a class="link link-hover" href="#">License</a>
        <a class="link link-hover" href="#">Help</a>
        <a class="link link-hover" href="#">Contact</a>
        <a class="link link-hover" href="#">Policy</a>
    </nav>
    <div class="flex h-5 gap-4">
        <a href="#" class="link" aria-label="Github Link">
            <span class="icon-[tabler--brand-github] size-5"></span>
        </a>
        <a href="#" class="link" aria-label="Facebook Link">
            <span class="icon-[tabler--brand-facebook] size-5"></span>
        </a>
        <a href="#" class="link" aria-label="X Link">
            <span class="icon-[tabler--brand-x] size-5"></span>
        </a>
        <a href="#" class="link" aria-label="Google Link">
            <span class="icon-[tabler--brand-google] size-5"></span>
        </a>
    </div>
</footer>
</body>

</html>