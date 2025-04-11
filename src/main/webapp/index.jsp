<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html class="scroll-smooth">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/static/css/output.css" rel="stylesheet">
    <link href="/static/css/index.css" rel="stylesheet">
    <script src="/static/js/flyonui.js"></script>
</head>

<body data-theme="dark" class="bg-base-200">
<div class="loader">
    <span class="loading loading-spinner loading-lg"></span>
</div>
<div class="h-screen">
    <nav class="navbar backdrop-blur-lg bg-white/10 text-white shadow-lg gap-4 fixed top-0 left-0 w-full z-50">
        <div class="navbar-start items-center justify-between max-md:w-full">
            <a class="link text-white text-xl font-bold no-underline" href="#">
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
            <a href="loginRegisterForm.jsp">
            <button class="btn btn-gradient btn-secondary rounded-full">Log In -></button>
            </a>
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

    <div class="relative isolate px-6 pt-14 lg:px-8">
        <div class="absolute inset-0 z-[-10]">
            <video autoplay muted loop playsinline preload="auto" class="w-full h-full object-cover" id="hero-video">
                <source src="<%= request.getContextPath() %>/static/video/background.mp4" type="video/mp4" />
                Your browser does not support the video tag.
            </video>
            <div
                    class="absolute inset-x-0 bottom-0 h-96 bg-gradient-to-b from-transparent via-black/80 to-black z-[-1] pointer-events-none">
            </div>
        </div>
        <div class="absolute inset-x-0 -top-40 -z-10 transform-gpu overflow-hidden blur-3xl sm:-top-80"
             aria-hidden="true">
            <div class="relative left-[calc(50%-11rem)] aspect-1155/678 w-[36.125rem] -translate-x-1/2 rotate-[30deg] bg-linear-to-tr from-[#ff80b5] to-[#9089fc] opacity-30 sm:left-[calc(50%-30rem)] sm:w-[72.1875rem]"
                 style="clip-path: polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)">
            </div>
        </div>
        <div class="mx-auto max-w-2xl py-32 sm:py-48 lg:py-56">
            <div class="hidden sm:mb-8 sm:flex sm:justify-center">
                <div
                        class="relative rounded-full px-3 py-1 text-sm/6 text-white ring-1 ring-white/30 hover:ring-white/50 bg-white/5 backdrop-blur">
                    Announcing our next round of funding. <a href="#" class="font-semibold text-cyan-400"><span
                        class="absolute inset-0" aria-hidden="true"></span>Read more <span
                        aria-hidden="true">&rarr;</span></a>
                </div>
            </div>
            <div class="text-center">
                <h1 class="text-5xl font-semibold tracking-tight text-balance text-white sm:text-7xl">Upgrade Your
                    Tech Empower Your Life</h1>
                <p class="mt-8 text-lg font-medium text-pretty text-white/80 sm:text-xl/8">Explore the latest
                    Samseng smartphones and accessories—designed to keep you connected, productive, and inspired
                    every day.</p>

                <div class="mt-10 flex items-center justify-center gap-x-6">

                    <a href="#about">
                        <button class="hero-animated-button">
                            <svg class="arr-2" fill="#000000" height="200px" width="200px" version="1.1"
                                 id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 330 330"
                                 xml:space="preserve">
                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                <g id="SVGRepo_iconCarrier">
                                    <path id="XMLID_24_"
                                          d="M216.358,271.76c-2.322-5.605-7.792-9.26-13.858-9.26H180V15c0-8.284-6.716-15-15-15 c-8.284,0-15,6.716-15,15v247.5h-22.5c-6.067,0-11.537,3.655-13.858,9.26c-2.321,5.605-1.038,12.057,3.252,16.347l37.5,37.5 C157.322,328.536,161.161,330,165,330s7.678-1.464,10.607-4.394l37.5-37.5C217.396,283.816,218.68,277.365,216.358,271.76z">
                                    </path>
                                </g>
                                </svg>
                            <span class="text">Learn More</span>
                            <span class="circle"></span>
                            <svg class="arr-1" fill="#000000" height="200px" width="200px" version="1.1"
                                 id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 330 330"
                                 xml:space="preserve">
                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                <g id="SVGRepo_iconCarrier">
                                    <path id="XMLID_24_"
                                          d="M216.358,271.76c-2.322-5.605-7.792-9.26-13.858-9.26H180V15c0-8.284-6.716-15-15-15 c-8.284,0-15,6.716-15,15v247.5h-22.5c-6.067,0-11.537,3.655-13.858,9.26c-2.321,5.605-1.038,12.057,3.252,16.347l37.5,37.5 C157.322,328.536,161.161,330,165,330s7.678-1.464,10.607-4.394l37.5-37.5C217.396,283.816,218.68,277.365,216.358,271.76z">
                                    </path>
                                </g>
                                </svg>
                        </button>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="relative z-10 -mt-24 h-52 bg-gradient-to-b from-transparent via-black/80 to-black"></div>
</div>

<div class="h-screen bg-black">
    <div class="relative z-10 flex h-screen justify-center items-center text-center px-6">
        <h2 class="text-3xl md:text-4xl font-bold text-white leading-snug max-w-4xl">
            Empowering lifestyles through cutting-edge innovation — from flagship smartphones and immersive TVs to
            smart accessories that enhance everyday life.
        </h2>
    </div>
</div>


<div class="relative isolate" id="about">
    <div class="relative z-10 -mt-24 h-52 bg-gradient-to-b from-black via-black/80 to-transparent"></div>
    <video autoplay muted loop playsinline class="absolute inset-0 w-full h-full object-cover z-[-1]">
        <source src="<%= request.getContextPath() %>/static/video/background2.mp4" type="video/mp4" />
        Your browser does not support the video tag.
    </video>
    <div class="h-screen flex items-center justify-center bg-cover bg-center bg-no-repeat px-4">
        <div
                class="card flex flex-col sm:flex-row items-center sm:items-start text-center sm:text-left max-w-6xl w-full bg-white/10 backdrop-blur-2xl border border-white/20 rounded-3xl overflow-hidden shadow-2xl text-white p-8 gap-10">
            <figure class="w-full max-w-xs">
                <img src="https://media.istockphoto.com/id/943067460/photo/male-it-specialist-holds-laptop-and-discusses-work-with-female-server-technician-theyre.jpg?s=612x612&w=0&k=20&c=851ArmF2ooz-2yQCRCWkjJLCYwDdpTCYzPinl9WgA_s="
                     alt="Who We Are" class="rounded-2xl w-full h-auto object-cover shadow-md mx-auto">
            </figure>
            <div class="card-body p-0 flex flex-col justify-center items-center sm:items-start">
                <h2 class="text-4xl font-bold mb-4 leading-tight">Who We Are</h2>
                <p class="text-lg text-white/90 leading-relaxed max-w-xl">
                    At Samseng, we are driven by innovation and inspired by real human needs. We design cutting-edge
                    mobile devices,
                    smart TVs, and connected accessories that power everyday life. Trusted by over <strong>12
                    million users</strong> worldwide.
                </p>
            </div>
        </div>
    </div>
    <div class="h-screen flex items-center justify-center bg-cover bg-center bg-no-repeat px-4">
        <div
                class="card flex flex-col sm:flex-row items-center sm:items-start text-center sm:text-left max-w-6xl w-full bg-white/10 backdrop-blur-2xl border border-white/20 rounded-3xl overflow-hidden shadow-2xl text-white p-8 gap-10">
            <div class="card-body p-0 flex flex-col justify-center items-center sm:items-start">
                <h2 class="text-4xl font-bold mb-4 leading-tight">What We Do</h2>
                <p class="text-lg text-white/90 leading-relaxed max-w-xl">
                    From ultra-fast smartphones to immersive displays and smart accessories, we create seamless
                    experiences for work,
                    play, and everything in between. Proudly shipping to <strong>50+ countries</strong> and
                    supporting <strong>200+ retailers</strong>.
                </p>
            </div>
            <figure class="w-full max-w-xs">
                <img src="https://media.istockphoto.com/id/1390456645/photo/metaverse-and-blockchain-technology-concepts-person-with-an-experiences-of-metaverse-virtual.jpg?s=612x612&w=0&k=20&c=eoKihFdi8QF2s2WomQJxpiy-pvM5tKLYAIaWdP_kQwc="
                     alt="What We Do" class="rounded-2xl w-full h-auto object-cover shadow-md mx-auto">
            </figure>

        </div>
    </div>
    <div class="h-screen flex items-center justify-center bg-cover bg-center bg-no-repeat px-4">
        <div
                class="card flex flex-col sm:flex-row items-center sm:items-start text-center sm:text-left max-w-6xl w-full bg-white/10 backdrop-blur-2xl border border-white/20 rounded-3xl overflow-hidden shadow-2xl text-white p-8 gap-10">
            <figure class="w-full max-w-xs">
                <img src="https://media.istockphoto.com/id/1346125184/photo/group-of-successful-multiethnic-business-team.jpg?s=612x612&w=0&k=20&c=5FHgRQZSZed536rHji6w8o5Hco9JVMRe8bpgTa69hE8="
                     alt="Why Choose Us" class="rounded-2xl w-full h-auto object-cover shadow-md mx-auto">
            </figure>
            <div class="card-body p-0 flex flex-col justify-center items-center sm:items-start">
                <h2 class="text-4xl font-bold mb-4 leading-tight">Why Choose Us</h2>
                <p class="text-lg text-white/90 leading-relaxed max-w-xl">
                    Our mission is to redefine modern tech living. With a <strong>99.8% satisfaction rate</strong>
                    and award-winning support,
                    Samseng delivers not just devices—but an entire lifestyle built on excellence and trust.
                </p>
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

<script>
    window.addEventListener("load", () => {
        const loader = document.querySelector(".loader");
        setTimeout(() => {
            loader.classList.add("hidden");

            loader.addEventListener("transitionend", () => {
                loader.remove();
            });
        }, 500); // slight delay for visual effect

        //HTML modal combo box
        const htmlOverlay = HSOverlay.getInstance('#html-modal-combo-box', true)
        const htmlCombobox = HSComboBox.getInstance('#html-modal-combo-box [data-combo-box]', true)

        window.addEventListener('keydown', function (evt) {
            if (evt.code === 'Semicolon' && evt.shiftKey) {
                if (htmlOverlay.element && htmlOverlay.element.el.classList.contains('open')) return false

                htmlOverlay.element.open()
                htmlCombobox.element.setCurrent()
            }
        })


    });

    const searchInput = document.getElementById("searchInput");
    const searchContainer = document.getElementById("searchContainer");

    searchInput.addEventListener("focus", () => {
        searchContainer.classList.replace("w-[20%]", "w-[60%]");
    });

    searchInput.addEventListener("blur", () => {
        searchContainer.classList.replace("w-[60%]", "w-[20%]");
    });

    const heroVideo = document.getElementById('hero-video');

    // Check if video pauses unexpectedly
    heroVideo.addEventListener('pause', () => {
        heroVideo.play().catch(e => console.warn("Autoplay blocked or error:", e));
    });

    // Optional: Retry every few seconds
    setInterval(() => {
        if (heroVideo.paused) {
            heroVideo.play().catch(e => console.warn("Retry autoplay error:", e));
        }
    }, 5000); // retry every 5s
</script>

</body>

</html>