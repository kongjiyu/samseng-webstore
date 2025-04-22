<jsp:useBean id="Account" scope="session" class="com.samseng.web.models.Account"/>
<%@page import="com.samseng.web.models.*" %>
<html>
<head>
    <title>Header</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>
<body>
<nav class="navbar backdrop-blur-lg bg-white/10 text-white shadow-lg gap-4 fixed top-0 left-0 w-full z-50">
    <div class="navbar-start items-center justify-between max-md:w-full">
        <a class="link text-white text-xl font-bold no-underline" href="<%= request.getContextPath() %>/index.jsp">
            SAMSENG
        </a>
    </div>
    <div class="navbar-center max-md:hidden bg-transparent text-white">
        <ul
                class="menu menu-horizontal gap-2 p-0 text-base rtl:ml-20 !bg-transparent !text-white !shadow-none !border-none ">
            <li
                    class="dropdown relative inline-flex [--auto-close:inside] [--offset:9] [--placement:bottom-end]">
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
                                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png"
                                     alt="avatar 1" />
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
                                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-2.png"
                                     alt="avatar 2" />
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
                                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-8.png"
                                     alt="avatar 8" />
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
                                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-10.png"
                                     alt="avatar 10" />
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
                                <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-3.png"
                                     alt="avatar 3" />
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
        <!--User Profile-->
        <%
            if(request.getUserPrincipal() !=null) {
                Account profile = (Account) session.getAttribute("profile");
        %>
        <div class="dropdown relative inline-flex [--auto-close:inside] [--offset:8] [--placement:bottom-end]">
            <button id="dropdown-scrollable" type="button" class="dropdown-toggle flex items-center"
                    aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
                <div class="relative inline-flex items-center justify-center w-10 h-10 overflow-hidden bg-gray-100 rounded-full dark:bg-gray-600">
                    <%
                        String[] nameParts = profile.getUsername().trim().split("\\s+");
                        StringBuilder initials = new StringBuilder();
                        for (String part : nameParts) {
                            if (!part.isEmpty()) {
                                initials.append(part.charAt(0));
                                if (initials.length() == 2) break;
                            }
                        }
                    %>
                    <span class="text-3xl text-base-content uppercase"><%= initials.toString() %></span>
                </div>
            </button>
            <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu"
                aria-orientation="vertical" aria-labelledby="dropdown-avatar">
                <li class="dropdown-header gap-2">
                    <div class="relative inline-flex items-center justify-center w-10 h-10 overflow-hidden bg-gray-100 rounded-full dark:bg-gray-600">
                        <span class="text-3xl uppercase"><%= initials.toString() %></span>
                    </div>
                    <div>
                        <h6 class="text-base-content text-base font-semibold"><%=profile.getUsername()%></h6>
                        <small class="text-base-content/50"><%=profile.getRole().name()%></small>
                    </div>
                </li>
                <li>
                    <a class="dropdown-item active:text-cyan-500" href="<%= request.getContextPath() %>/user/profile">
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
                    <a class="btn btn-error btn-soft btn-block" href="<%= request.getContextPath() %>/logout"><!--logout-->
                        <span class="icon-[tabler--logout]"></span>
                        Sign out
                    </a>
                </li>
            </ul>
        </div>
        <% } else {%>
        <a href="<%= request.getContextPath() %>/login-flow">
            <button class="btn btn-gradient btn-secondary rounded-full">Log In -></button>
        </a>
        <%}%>
    </div>
</nav>
<div id="html-modal-combo-box" class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 [--body-scroll:true] hidden"
     role="dialog" tabindex="-1">
    <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300">
        <div class="modal-content">
            <div class="relative" data-combo-box='{
                    "preventVisibility": true,
                    "groupingType": "default",
                    "preventSelection": true,
                    "isOpenOnFocus": true,
                    "groupingTitleTemplate": "<div class=\"block text-xs text-base-content/50 m-3 mb-1\"></div>"
                  }'>
                <div class="modal-header block">
                    <div class="relative">
                        <input class="input ps-8 focus:ring-2 focus:ring-cyan-500 focus:border-cyan-500" type="text" placeholder="Search or type a command"
                               role="combobox" aria-expanded="false" value="" autofocus=""
                               data-combo-box-input="" />
                        <span
                                class="icon-[tabler--search] text-base-content absolute start-3 top-1/2 size-4 shrink-0 -translate-y-1/2"
                                data-combo-box-toggle=""></span>
                    </div>
                </div>
                <!-- SearchBox Modal Body -->
                <div class="modal-body overflow-y-auto mt-0 max-h-72 p-1.5" data-combo-box-output="">
                    <div class="space-y-0.5 p-0.5" data-combo-box-output-items-wrapper="">
                        <!-- Group: Recent Actions -->
                        <div data-combo-box-output-item='{"group": {"name": "recent", "title": "Recent Actions"}}'
                             tabindex="0">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none" href="#">
                                        <span
                                                class="icon-[tabler--writing] text-base-content/80 size-4 shrink-0"></span>
                                <span class="text-base-content text-sm"
                                      data-combo-box-search-text="Write a document" data-combo-box-value="">
                                            Write a document
                                        </span>
                                <span class="text-base-content/50 ms-auto hidden text-xs sm:inline"
                                      data-combo-box-search-text="Google Docs" data-combo-box-value="">
                                            Google Docs
                                        </span>
                            </a>
                        </div>
                        <div data-combo-box-output-item='{"group": {"name": "recent", "title": "Recent Actions"}}'
                             tabindex="1">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none" href="#">
                                        <span
                                                class="icon-[tabler--calendar] text-base-content/80 size-4 shrink-0"></span>
                                <span class="text-base-content text-sm"
                                      data-combo-box-search-text="Schedule a meeting" data-combo-box-value="">
                                            Schedule a meeting
                                        </span>
                                <span class="text-base-content/50 ms-auto hidden text-xs sm:inline"
                                      data-combo-box-search-text="Google Calendar" data-combo-box-value="">
                                            Google Calendar
                                        </span>
                            </a>
                        </div>
                        <div data-combo-box-output-item='{"group": {"name": "recent", "title": "Recent Actions"}}'
                             tabindex="2">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none" href="#">
                                        <span
                                                class="icon-[tabler--presentation] text-base-content/80 size-4 shrink-0"></span>
                                <span class="text-base-content text-sm"
                                      data-combo-box-search-text="Create a presentation" data-combo-box-value="">
                                            Create a presentation
                                        </span>
                                <span class="text-base-content/50 ms-auto hidden text-xs sm:inline"
                                      data-combo-box-search-text="Microsoft PowerPoint" data-combo-box-value="">
                                            PowerPoint
                                        </span>
                            </a>
                        </div>
                        <!-- Group: People -->
                        <div data-combo-box-output-item='{"group": {"name": "people", "title": "People"}}'
                             tabindex="4">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none" href="#">
                                <img class="size-5 shrink-0 rounded-full"
                                     src="https://cdn.flyonui.com/fy-assets/avatar/avatar-2.png"
                                     alt="Image Description" />
                                <span class="text-base-content text-sm"
                                      data-combo-box-search-text="Alice Johnson" data-combo-box-value="">
                                            Alice Johnson
                                        </span>
                                <span class="ms-auto text-xs text-teal-600" data-combo-box-search-text="Online"
                                      data-combo-box-value="">
                                            Online
                                        </span>
                            </a>
                        </div>
                        <div data-combo-box-output-item='{"group": {"name": "people", "title": "People"}}'
                             tabindex="5">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none" href="#">
                                <img class="size-5 shrink-0 rounded-full"
                                     src="https://cdn.flyonui.com/fy-assets/avatar/avatar-11.png"
                                     alt="Image Description" />
                                <span class="text-base-content text-sm" data-combo-box-search-text="David Kim"
                                      data-combo-box-value="">
                                            David Kim
                                        </span>
                                <span class="text-base-content/50 ms-auto text-xs"
                                      data-combo-box-search-text="Offline" data-combo-box-value="">
                                            Offline
                                        </span>
                            </a>
                        </div>
                        <div data-combo-box-output-item='{"group": {"name": "people", "title": "People"}}'
                             tabindex="6">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none" href="#">
                                <img class="size-5 shrink-0 rounded-full"
                                     src="https://cdn.flyonui.com/fy-assets/avatar/avatar-12.png"
                                     alt="Image Description" />
                                <span class="text-base-content text-sm"
                                      data-combo-box-search-text="Rosa Martinez" data-combo-box-value="">
                                            Rosa Martinez
                                        </span>
                                <span class="text-base-content/50 ms-auto text-xs"
                                      data-combo-box-search-text="Offline" data-combo-box-value="">
                                            Offline
                                        </span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
