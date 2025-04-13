<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/productPage.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>

</head>

<body data-theme="light">

<!--HEADER BLOCK START-->
<nav class="navbar backdrop-blur-lg bg-white/10 text-white shadow-lg gap-4 fixed top-0 left-0 w-full z-50">
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
                <ul class="dropdown-menu dropdown-open:opacity-100 hidden w-48" role="menu" aria-orientation="vertical"
                    aria-labelledby="nested-dropdown">
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
                    class="dropdown-toggle btn btn-text btn-circle dropdown-open:bg-base-content/10 size-10" aria-haspopup="menu"
                    aria-expanded="false" aria-label="Dropdown">
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
            <button id="dropdown-scrollable" type="button" class="dropdown-toggle flex items-center" aria-haspopup="menu"
                    aria-expanded="false" aria-label="Dropdown">
                <div class="avatar">
                    <div class="size-9.5 rounded-full">
                        <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar 1" />
                    </div>
                </div>
            </button>
            <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu" aria-orientation="vertical"
                aria-labelledby="dropdown-avatar">
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
<div id="html-modal-combo-box" class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 hidden"
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
                        <input class="input ps-8 focus:ring-2 focus:ring-cyan-500 focus:border-cyan-500" type="text"
                               placeholder="Search or type a command" role="combobox" aria-expanded="false" value="" autofocus=""
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
                        <div data-combo-box-output-item='{"group": {"name": "recent", "title": "Recent Actions"}}' tabindex="0">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none"
                               href="#">
                                <span class="icon-[tabler--writing] text-base-content/80 size-4 shrink-0"></span>
                                <span class="text-base-content text-sm" data-combo-box-search-text="Write a document"
                                      data-combo-box-value="">
                    Write a document
                  </span>
                                <span class="text-base-content/50 ms-auto hidden text-xs sm:inline"
                                      data-combo-box-search-text="Google Docs" data-combo-box-value="">
                    Google Docs
                  </span>
                            </a>
                        </div>
                        <div data-combo-box-output-item='{"group": {"name": "recent", "title": "Recent Actions"}}' tabindex="1">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none"
                               href="#">
                                <span class="icon-[tabler--calendar] text-base-content/80 size-4 shrink-0"></span>
                                <span class="text-base-content text-sm" data-combo-box-search-text="Schedule a meeting"
                                      data-combo-box-value="">
                    Schedule a meeting
                  </span>
                                <span class="text-base-content/50 ms-auto hidden text-xs sm:inline"
                                      data-combo-box-search-text="Google Calendar" data-combo-box-value="">
                    Google Calendar
                  </span>
                            </a>
                        </div>
                        <div data-combo-box-output-item='{"group": {"name": "recent", "title": "Recent Actions"}}' tabindex="2">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none"
                               href="#">
                                <span class="icon-[tabler--presentation] text-base-content/80 size-4 shrink-0"></span>
                                <span class="text-base-content text-sm" data-combo-box-search-text="Create a presentation"
                                      data-combo-box-value="">
                    Create a presentation
                  </span>
                                <span class="text-base-content/50 ms-auto hidden text-xs sm:inline"
                                      data-combo-box-search-text="Microsoft PowerPoint" data-combo-box-value="">
                    PowerPoint
                  </span>
                            </a>
                        </div>
                        <!-- Group: People -->
                        <div data-combo-box-output-item='{"group": {"name": "people", "title": "People"}}' tabindex="4">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none"
                               href="#">
                                <img class="size-5 shrink-0 rounded-full" src="https://cdn.flyonui.com/fy-assets/avatar/avatar-2.png"
                                     alt="Image Description" />
                                <span class="text-base-content text-sm" data-combo-box-search-text="Alice Johnson"
                                      data-combo-box-value="">
                    Alice Johnson
                  </span>
                                <span class="ms-auto text-xs text-teal-600" data-combo-box-search-text="Online"
                                      data-combo-box-value="">
                    Online
                  </span>
                            </a>
                        </div>
                        <div data-combo-box-output-item='{"group": {"name": "people", "title": "People"}}' tabindex="5">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none"
                               href="#">
                                <img class="size-5 shrink-0 rounded-full" src="https://cdn.flyonui.com/fy-assets/avatar/avatar-11.png"
                                     alt="Image Description" />
                                <span class="text-base-content text-sm" data-combo-box-search-text="David Kim"
                                      data-combo-box-value="">
                    David Kim
                  </span>
                                <span class="text-base-content/50 ms-auto text-xs" data-combo-box-search-text="Offline"
                                      data-combo-box-value="">
                    Offline
                  </span>
                            </a>
                        </div>
                        <div data-combo-box-output-item='{"group": {"name": "people", "title": "People"}}' tabindex="6">
                            <a class="dropdown-item combo-box-selected:dropdown-active focus:ring-2 focus:bg-cyan-100 focus:outline-none"
                               href="#">
                                <img class="size-5 shrink-0 rounded-full" src="https://cdn.flyonui.com/fy-assets/avatar/avatar-12.png"
                                     alt="Image Description" />
                                <span class="text-base-content text-sm" data-combo-box-search-text="Rosa Martinez"
                                      data-combo-box-value="">
                    Rosa Martinez
                  </span>
                                <span class="text-base-content/50 ms-auto text-xs" data-combo-box-search-text="Offline"
                                      data-combo-box-value="">
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
<!--HEADER BLOCK END-->

<!--Banner-->
<div class="h-[40%] flex">
    <img class="hero-image" src="../static/img/phone-store-banner.jpg" alt="phoneBanner" />
    <!--
    <image class="hero-image" style="background-image: url('<%-- request.getContextPath() --%>/static/img/phone-store-banner.jpg');"></image>
    -->
    <div class="hero-text">
        <h1>Smart Phones</h1>
    </div>
</div>


<!--Everything that isn't Header, Banner, or Footer. Don't collapse this if you value your sanity-->
<div class="flex flex-col">

    <!--Collapse these subsections instead-->
    <div class="filter-section">
        <button type="button" id="filter-button" class="btn btn-primary btn-lg !rounded-r-3xl !rounded-l-none"
                aria-haspopup="dialog" aria-expanded="false" aria-controls="overlay-body-scrolling-with-backdrop"
                data-overlay="#overlay-body-scrolling-with-backdrop"
                data-overlay-options='{ "backdropClasses": "transition duration-300 fixed inset-0 bg-black/40 overlay-backdrop" }'>
            Filter<span class="icon-[tabler--filter] size-4.5 shrink-0"></span></button>
    </div>

    <!--Filter Form-->
    <div id="overlay-body-scrolling-with-backdrop"
         class="overlay overlay-open:translate-x-0 drawer drawer-start hidden [--body-scroll:true]" role="dialog"
         tabindex="-1">
        <div class="drawer-header">
            <h3 class="drawer-title">Filter Categories</h3>
            <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close"
                    data-overlay="#overlay-body-scrolling-with-backdrop">
                <span class="icon-[tabler--x] size-5"></span>
            </button>
        </div>
        <form>
            <div class="drawer-body justify-start">

                <!--Product Name-->
                <div class="mb-4">
                    <label class="label-text font-medium" for="productName"> Product Name </label>
                    <input type="text" placeholder="Samseng Galaxy S22" class="input" id="productName" />
                </div>

                <!--Price Range-->
                <div class="mb-4 flex flex-row space-x-4 rtl:flex-row-reverse">
                    <div class="basis-1/2">
                        <label for="inputs-min-target" class="mb-2 block text-sm font-medium">Min price:</label>
                        <input id="inputs-min-target" class="input" type="number" value="150" />
                    </div>
                    <div class="basis-1/2">
                        <label for="inputs-max-target" class="mb-2 block text-sm font-medium">Max price:</label>
                        <input id="inputs-max-target" class="input" type="number" value="650" />
                    </div>
                </div>

                <!--Color Options-->
                <div class="max-w-sm mb-4">
                    <label class="label-text font-medium" for="color-options">Color Options</label>
                    <select id="color-options" multiple="" data-select='{
                      "placeholder": "Select multiple options...",
                      "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                      "toggleClasses": "advance-select-toggle select-disabled:pointer-events-none select-disabled:opacity-40",
                      "toggleSeparators": {
                        "betweenItemsAndCounter": "&"
                      },
                      "toggleCountText": "+",
                      "toggleCountTextPlacement": "prefix-no-space",
                      "toggleCountTextMinItems": 3,
                      "toggleCountTextMode": "nItemsAndCount",
                      "dropdownClasses": "advance-select-menu max-h-44 overflow-y-auto",
                      "optionClasses": "advance-select-option selected:select-active",
                      "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"icon-[tabler--check] shrink-0 size-4 text-primary hidden selected:block \"></span></div>",
                      "extraMarkup": "<span class=\"icon-[tabler--caret-up-down] shrink-0 size-4 text-base-content absolute top-1/2 end-3 -translate-y-1/2 \"></span>"
                    }' class="hidden">
                        <option value="">Choose</option>
                        <option>Milky White</option>
                        <option>Matte Black</option>
                        <option>Navy Blue</option>
                        <option>Titanium Grey</option>
                        <option>Mint Green</option>
                    </select>
                </div>

                <!--Storage Options-->
                <div class="max-w-sm mb-4">
                    <label class="label-text font-medium" for="color-options">Storage Options</label>
                    <select id="multi-cond-count" multiple="" data-select='{
                      "placeholder": "Select multiple options...",
                      "toggleTag": "<button type=\"button\" aria-expanded=\"false\"></button>",
                      "toggleClasses": "advance-select-toggle select-disabled:pointer-events-none select-disabled:opacity-40",
                      "toggleSeparators": {
                        "betweenItemsAndCounter": "&"
                      },
                      "toggleCountText": "+",
                      "toggleCountTextPlacement": "prefix-no-space",
                      "toggleCountTextMinItems": 3,
                      "toggleCountTextMode": "nItemsAndCount",
                      "dropdownClasses": "advance-select-menu max-h-44 overflow-y-auto",
                      "optionClasses": "advance-select-option selected:select-active",
                      "optionTemplate": "<div class=\"flex justify-between items-center w-full\"><span data-title></span><span class=\"icon-[tabler--check] shrink-0 size-4 text-primary hidden selected:block \"></span></div>",
                      "extraMarkup": "<span class=\"icon-[tabler--caret-up-down] shrink-0 size-4 text-base-content absolute top-1/2 end-3 -translate-y-1/2 \"></span>"
                    }' class="hidden">
                        <option value="">Choose</option>
                        <option>256GB</option>
                        <option>512GB</option>
                        <option>1TB</option>
                    </select>
                    <!-- End Select -->
                </div>


            </div>

            <div class="drawer-footer">
                <button type="button" class="btn btn-soft btn-secondary" data-overlay="#overlay-form-example">Close</button>
                <button type="submit" class="btn btn-primary">Save changes</button>
            </div>
        </form>
    </div>

    <div class="product-section">

        <!--Below DIV shall be copied and pasted for testing.-->
        <div class="card sm:max-w-xs">
            <figure><img src="https://cdn.flyonui.com/fy-assets/components/card/image-9.png" alt="Watch" /></figure>
            <div class="card-body">
                <h5 class="card-title mb-2.5">Apple Smart Watch</h5>
                <p class="mb-4">Stay connected, motivated, and healthy with the latest Apple Watch.</p>
                <div class="card-actions">
                    <button class="btn btn-block btn-primary">Add to Cart</button>
                    <div class="tooltip [--trigger:hover]">
                        <div class="tooltip-toggle">
                            <p class="text-primary cursor-pointer select-none flex items-center gap-1">
                                Ratings & reviews
                                <span class="icon-[tabler--eye-closed] tooltip-shown:hidden"></span>
                                <span class="icon-[tabler--eye] hidden tooltip-shown:inline-block"></span>
                            </p>

                            <div class="tooltip-content tooltip-shown:opacity-100 tooltip-shown:visible p-4" role="popover">
                                <div
                                        class="tooltip-body bg-base-100 text-base-content/80 flex max-w-xs flex-col gap-1 rounded-lg p-4 text-start">
                                    <div class="text-primary text-xl flex items-center gap-1 font-medium">
                                        4.35
                                        <span class="icon-[tabler--star-filled] size-5"></span>
                                    </div>
                                    <div class="text-base-content font-medium">Total 300 reviews</div>
                                    <p>All reviews are from genuine customers.</p>
                                    <div class="mt-4 flex items-center justify-between">
                                        <span class="badge badge-soft badge-primary rounded-full">+6 this week</span>
                                        <a href="#" class="link link-primary link-hover text-sm">See all</a>
                                    </div>
                                    <div class="divider my-2"></div>
                                    <div class="space-y-2">
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">5 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="75" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-3/4"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">225</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">4 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">3 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">2 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="5" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[5%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">15</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">1 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-0"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Copy Ends Here-->

        <div class="card sm:max-w-xs">
            <figure><img src="https://cdn.flyonui.com/fy-assets/components/card/image-9.png" alt="Watch" /></figure>
            <div class="card-body">
                <h5 class="card-title mb-2.5">Apple Smart Watch</h5>
                <p class="mb-4">Stay connected, motivated, and healthy with the latest Apple Watch.</p>
                <div class="card-actions">
                    <button class="btn btn-block btn-primary">Add to Cart</button>
                    <div class="tooltip [--trigger:hover]">
                        <div class="tooltip-toggle">
                            <p class="text-primary cursor-pointer select-none flex items-center gap-1">
                                Ratings & reviews
                                <span class="icon-[tabler--eye-closed] tooltip-shown:hidden"></span>
                                <span class="icon-[tabler--eye] hidden tooltip-shown:inline-block"></span>
                            </p>

                            <div class="tooltip-content tooltip-shown:opacity-100 tooltip-shown:visible p-4" role="popover">
                                <div
                                        class="tooltip-body bg-base-100 text-base-content/80 flex max-w-xs flex-col gap-1 rounded-lg p-4 text-start">
                                    <div class="text-primary text-xl flex items-center gap-1 font-medium">
                                        4.35
                                        <span class="icon-[tabler--star-filled] size-5"></span>
                                    </div>
                                    <div class="text-base-content font-medium">Total 300 reviews</div>
                                    <p>All reviews are from genuine customers.</p>
                                    <div class="mt-4 flex items-center justify-between">
                                        <span class="badge badge-soft badge-primary rounded-full">+6 this week</span>
                                        <a href="#" class="link link-primary link-hover text-sm">See all</a>
                                    </div>
                                    <div class="divider my-2"></div>
                                    <div class="space-y-2">
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">5 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="75" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-3/4"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">225</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">4 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">3 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">2 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="5" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[5%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">15</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">1 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-0"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card sm:max-w-xs">
            <figure><img src="https://cdn.flyonui.com/fy-assets/components/card/image-9.png" alt="Watch" /></figure>
            <div class="card-body">
                <h5 class="card-title mb-2.5">Apple Smart Watch</h5>
                <p class="mb-4">Stay connected, motivated, and healthy with the latest Apple Watch.</p>
                <div class="card-actions">
                    <button class="btn btn-block btn-primary">Add to Cart</button>
                    <div class="tooltip [--trigger:hover]">
                        <div class="tooltip-toggle">
                            <p class="text-primary cursor-pointer select-none flex items-center gap-1">
                                Ratings & reviews
                                <span class="icon-[tabler--eye-closed] tooltip-shown:hidden"></span>
                                <span class="icon-[tabler--eye] hidden tooltip-shown:inline-block"></span>
                            </p>

                            <div class="tooltip-content tooltip-shown:opacity-100 tooltip-shown:visible p-4" role="popover">
                                <div
                                        class="tooltip-body bg-base-100 text-base-content/80 flex max-w-xs flex-col gap-1 rounded-lg p-4 text-start">
                                    <div class="text-primary text-xl flex items-center gap-1 font-medium">
                                        4.35
                                        <span class="icon-[tabler--star-filled] size-5"></span>
                                    </div>
                                    <div class="text-base-content font-medium">Total 300 reviews</div>
                                    <p>All reviews are from genuine customers.</p>
                                    <div class="mt-4 flex items-center justify-between">
                                        <span class="badge badge-soft badge-primary rounded-full">+6 this week</span>
                                        <a href="#" class="link link-primary link-hover text-sm">See all</a>
                                    </div>
                                    <div class="divider my-2"></div>
                                    <div class="space-y-2">
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">5 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="75" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-3/4"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">225</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">4 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">3 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">2 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="5" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[5%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">15</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">1 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-0"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card sm:max-w-xs">
            <figure><img src="https://cdn.flyonui.com/fy-assets/components/card/image-9.png" alt="Watch" /></figure>
            <div class="card-body">
                <h5 class="card-title mb-2.5">Apple Smart Watch</h5>
                <p class="mb-4">Stay connected, motivated, and healthy with the latest Apple Watch.</p>
                <div class="card-actions">
                    <button class="btn btn-block btn-primary">Add to Cart</button>
                    <div class="tooltip [--trigger:hover]">
                        <div class="tooltip-toggle">
                            <p class="text-primary cursor-pointer select-none flex items-center gap-1">
                                Ratings & reviews
                                <span class="icon-[tabler--eye-closed] tooltip-shown:hidden"></span>
                                <span class="icon-[tabler--eye] hidden tooltip-shown:inline-block"></span>
                            </p>

                            <div class="tooltip-content tooltip-shown:opacity-100 tooltip-shown:visible p-4" role="popover">
                                <div
                                        class="tooltip-body bg-base-100 text-base-content/80 flex max-w-xs flex-col gap-1 rounded-lg p-4 text-start">
                                    <div class="text-primary text-xl flex items-center gap-1 font-medium">
                                        4.35
                                        <span class="icon-[tabler--star-filled] size-5"></span>
                                    </div>
                                    <div class="text-base-content font-medium">Total 300 reviews</div>
                                    <p>All reviews are from genuine customers.</p>
                                    <div class="mt-4 flex items-center justify-between">
                                        <span class="badge badge-soft badge-primary rounded-full">+6 this week</span>
                                        <a href="#" class="link link-primary link-hover text-sm">See all</a>
                                    </div>
                                    <div class="divider my-2"></div>
                                    <div class="space-y-2">
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">5 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="75" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-3/4"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">225</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">4 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">3 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">2 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="5" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[5%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">15</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">1 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-0"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card sm:max-w-xs">
            <figure><img src="https://cdn.flyonui.com/fy-assets/components/card/image-9.png" alt="Watch" /></figure>
            <div class="card-body">
                <h5 class="card-title mb-2.5">Apple Smart Watch</h5>
                <p class="mb-4">Stay connected, motivated, and healthy with the latest Apple Watch.</p>
                <div class="card-actions">
                    <button class="btn btn-block btn-primary">Add to Cart</button>
                    <div class="tooltip [--trigger:hover]">
                        <div class="tooltip-toggle">
                            <p class="text-primary cursor-pointer select-none flex items-center gap-1">
                                Ratings & reviews
                                <span class="icon-[tabler--eye-closed] tooltip-shown:hidden"></span>
                                <span class="icon-[tabler--eye] hidden tooltip-shown:inline-block"></span>
                            </p>

                            <div class="tooltip-content tooltip-shown:opacity-100 tooltip-shown:visible p-4" role="popover">
                                <div
                                        class="tooltip-body bg-base-100 text-base-content/80 flex max-w-xs flex-col gap-1 rounded-lg p-4 text-start">
                                    <div class="text-primary text-xl flex items-center gap-1 font-medium">
                                        4.35
                                        <span class="icon-[tabler--star-filled] size-5"></span>
                                    </div>
                                    <div class="text-base-content font-medium">Total 300 reviews</div>
                                    <p>All reviews are from genuine customers.</p>
                                    <div class="mt-4 flex items-center justify-between">
                                        <span class="badge badge-soft badge-primary rounded-full">+6 this week</span>
                                        <a href="#" class="link link-primary link-hover text-sm">See all</a>
                                    </div>
                                    <div class="divider my-2"></div>
                                    <div class="space-y-2">
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">5 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="75" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-3/4"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">225</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">4 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">3 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">2 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="5" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[5%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">15</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">1 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-0"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card sm:max-w-xs">
            <figure><img src="https://cdn.flyonui.com/fy-assets/components/card/image-9.png" alt="Watch" /></figure>
            <div class="card-body">
                <h5 class="card-title mb-2.5">Apple Smart Watch</h5>
                <p class="mb-4">Stay connected, motivated, and healthy with the latest Apple Watch.</p>
                <div class="card-actions">
                    <button class="btn btn-block btn-primary">Add to Cart</button>
                    <div class="tooltip [--trigger:hover]">
                        <div class="tooltip-toggle">
                            <p class="text-primary cursor-pointer select-none flex items-center gap-1">
                                Ratings & reviews
                                <span class="icon-[tabler--eye-closed] tooltip-shown:hidden"></span>
                                <span class="icon-[tabler--eye] hidden tooltip-shown:inline-block"></span>
                            </p>

                            <div class="tooltip-content tooltip-shown:opacity-100 tooltip-shown:visible p-4" role="popover">
                                <div
                                        class="tooltip-body bg-base-100 text-base-content/80 flex max-w-xs flex-col gap-1 rounded-lg p-4 text-start">
                                    <div class="text-primary text-xl flex items-center gap-1 font-medium">
                                        4.35
                                        <span class="icon-[tabler--star-filled] size-5"></span>
                                    </div>
                                    <div class="text-base-content font-medium">Total 300 reviews</div>
                                    <p>All reviews are from genuine customers.</p>
                                    <div class="mt-4 flex items-center justify-between">
                                        <span class="badge badge-soft badge-primary rounded-full">+6 this week</span>
                                        <a href="#" class="link link-primary link-hover text-sm">See all</a>
                                    </div>
                                    <div class="divider my-2"></div>
                                    <div class="space-y-2">
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">5 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="75" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-3/4"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">225</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">4 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">3 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="10" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[10%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">30</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">2 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="5" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-[5%]"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">15</span>
                                        </div>
                                        <div class="flex w-full items-center gap-2">
                                            <span class="text-sm text-nowrap font-medium leading-5">1 Star</span>
                                            <div class="progress" role="progressbar" aria-valuenow="0" aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <div class="progress-bar progress-primary w-0"></div>
                                            </div>
                                            <span class="text-sm font-medium leading-5">00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>


<footer class="footer bg-base-200 flex flex-col items-center gap-4 p-6" data-theme="dark">
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
