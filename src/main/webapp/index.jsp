<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tailwind v3 with JSP</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
    <script src="<%= request.getContextPath() %>/static/js/accordion.js"></script>
    <script defer src="https://unpkg.com/tailwindcss-intersect@2.x.x/dist/observer.min.js"></script>

</head>

<body class="bg-base-200">
<div class="loader">
    <span class="loading loading-spinner loading-lg"></span>
</div>
<div class="h-screen">
    <nav class="navbar backdrop-blur-lg bg-white/10 text-white shadow-lg gap-4 fixed top-0 left-0 w-full z-50">
        <div class="navbar-start items-center justify-between max-md:w-full">
            <a class="link text-white link-neutral text-xl font-bold no-underline" href="#">
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
                        <li><a class="dropdown-item" href="#">Templates</a></li>
                        <li><a class="dropdown-item" href="#">UI kits</a></li>
                        <li class="dropdown relative [--auto-close:inside] [--offset:10] [--placement:right-start]">
                            <button id="nested-dropdown-2"
                                    class="dropdown-toggle dropdown-item dropdown-open:bg-base-content/10 dropdown-open:text-base-content justify-between"
                                    aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
                                Components
                                <span class="icon-[tabler--chevron-right] size-4 rtl:rotate-180"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-open:opacity-100 hidden w-48" role="menu"
                                aria-orientation="vertical" aria-labelledby="nested-dropdown-2">
                                <li><a class="dropdown-item" href="#">Basic</a></li>
                                <li>
                                    <a class="dropdown-item" href="#">
                                        Advanced
                                        <span
                                                class="badge badge-sm badge-soft badge-primary rounded-full">Pro</span>
                                    </a>
                                </li>
                                <li
                                        class="dropdown relative [--auto-close:inside] [--offset:10] rtl:[--placement:left-start] [--placement:right-start]">
                                    <button id="nested-dropdown-2"
                                            class="dropdown-toggle dropdown-item dropdown-open:bg-base-content/10 dropdown-open:text-base-content justify-between"
                                            aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
                                        Vendor
                                        <span class="icon-[tabler--chevron-right] size-4 rtl:rotate-180"></span>
                                    </button>
                                    <ul class="dropdown-menu dropdown-open:opacity-100 hidden w-48" role="menu"
                                        aria-orientation="vertical" aria-labelledby="nested-dropdown-2">
                                        <li>
                                            <a class="dropdown-item" href="#">
                                                Data tables
                                                <span
                                                        class="badge badge-sm badge-soft badge-primary rounded-full">Pro</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="#">
                                                Apex charts
                                                <span
                                                        class="badge badge-sm badge-soft badge-primary rounded-full">Pro</span>
                                            </a>
                                        </li>
                                        <li><a class="dropdown-item" href="#">Clipboard</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><a href="#" class="!bg-transparent !text-white">About</a></li>
                <li><a href="#" class="!bg-transparent !text-white">Careers</a></li>
            </ul>
        </div>

        <div class="navbar-end flex items-center gap-4">
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
            <button class="btn btn-gradient btn-secondary rounded-full">Log In -></button>
        </div>
    </nav>


    <!-- <div data-carousel='{
    "loadingClasses": "opacity-0",
    "dotsItemClasses": "carousel-box",
    "isAutoPlay": true,
    "speed": 3000

  }' class="relative w-full h-screen">
        <div class="carousel h-full">
            <div class="carousel-body h-full opacity-0">
                <div class="carousel-slide">
                    <div class="bg-base-300/60 flex h-full justify-center p-6 bg-cover" style="background-image:url(https://images.samsung.com/my/smartphones/galaxy-s25-ultra/images/galaxy-s25-ultra-features-kv.jpg?imbypass=true)">
                        <span class="self-center text-2xl sm:text-4xl">First slide</span>
                    </div>
                </div>
                <div class="carousel-slide">
                    <div class="bg-base-300/80 flex h-full justify-center p-6 bg-cover" style="background-image: url(https://images.samsung.com/my/smartphones/galaxy-s25/images/galaxy-s25-features-kv.jpg?imbypass=true);">
                        <span class="self-center text-2xl sm:text-4xl">Second slide</span>
                    </div>
                </div>
                <div class="carousel-slide">
                    <div class="bg-base-300 flex h-full justify-center p-6 bg-cover bg-cover" style="background-image: url(https://images.samsung.com/my/smartphones/galaxy-z-fold6/images/galaxy-z-fold6-features-kv.jpg?imbypass=true);">
                        <span class="self-center text-2xl sm:text-4xl">Third slide</span>
                    </div>
                </div>
            </div>
        </div>

        <button type="button" class="carousel-prev">
            <span class="size-9.5 bg-base-100 flex items-center justify-center rounded-full shadow">
                <span class="icon-[tabler--chevron-left] size-5 cursor-pointer rtl:rotate-180"></span>
            </span>
            <span class="sr-only">Previous</span>
        </button>
        <button type="button" class="carousel-next">
            <span class="sr-only">Next</span>
            <span class="size-9.5 bg-base-100 flex items-center justify-center rounded-full shadow">
                <span class="icon-[tabler--chevron-right] size-5 cursor-pointer rtl:rotate-180"></span>
            </span>
        </button>

        <div class="carousel-pagination absolute bottom-3 end-0 start-0 flex justify-center gap-3"></div>
    </div> -->

    <div class="relative isolate px-6 pt-14 lg:px-8">
        <div class="absolute inset-0 z-[-10]">
            <video autoplay muted loop playsinline class="w-full h-full object-cover">
                <source src="<%= request.getContextPath() %>/static/video/background.mp4" type="video/mp4" />
                Your browser does not support the video tag.
            </video>
            <div class="absolute inset-x-0 bottom-0 h-96 bg-gradient-to-b from-transparent via-black/80 to-black z-[-1] pointer-events-none"></div>            </div>
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

                    <a href="#">
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
        <div class="absolute inset-x-0 top-[calc(100%-13rem)] -z-10 transform-gpu overflow-hidden blur-3xl sm:top-[calc(100%-30rem)]"
             aria-hidden="true">
            <div class="relative left-[calc(50%+3rem)] aspect-1155/678 w-[36.125rem] -translate-x-1/2 bg-linear-to-tr from-[#ff80b5] to-[#9089fc] opacity-30 sm:left-[calc(50%+36rem)] sm:w-[72.1875rem]"
                 style="clip-path: polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)">
            </div>
        </div>

    </div>
    <div class="relative z-10 -mt-24 h-52 bg-gradient-to-b from-transparent via-black/80 to-black"></div>
</div>

<div class="h-screen bg-black">

</div>


<div class="relative isolate">
    <div class="relative z-10 -mt-24 h-52 bg-gradient-to-b from-black via-black/80 to-transparent"></div>
    <video autoplay muted loop playsinline class="absolute inset-0 w-full h-full object-cover z-[-1]">
        <source src="<%= request.getContextPath() %>/static/video/background2.mp4" type="video/mp4" />
        Your browser does not support the video tag.
    </video>
    <div class="absolute inset-x-0 bottom-0 h-40 bg-gradient-to-b from-transparent to-black z-[-1]"></div>
    <div class="h-screen flex items-center justify-center bg-cover bg-center bg-no-repeat px-4">
        <div
                class="card flex flex-col sm:flex-row items-center sm:items-start text-center sm:text-left max-w-6xl w-full bg-white/10 backdrop-blur-2xl border border-white/20 rounded-3xl overflow-hidden shadow-2xl text-white p-8 gap-10">
            <figure class="w-full max-w-xs">
                <img src="https://cdn.flyonui.com/fy-assets/components/card/image-7.png" alt="Airpods Max"
                     class="rounded-2xl w-full h-auto object-cover shadow-md mx-auto">
            </figure>
            <div class="card-body p-0 flex flex-col justify-center items-center sm:items-start">
                <h2 class="text-4xl font-bold mb-4 leading-tight">Galaxy Series Smartphones</h2>
                <p class="text-lg text-white/90 leading-relaxed max-w-xl">
                    Discover the cutting-edge innovation behind Samsung Galaxy phones. Experience power, style, and
                    performance in one sleek device.
                </p>
            </div>
        </div>
    </div>
    <div class="h-screen flex items-center justify-center bg-cover bg-center bg-no-repeat px-4">
        <div
                class="card flex flex-col sm:flex-row items-center sm:items-start text-center sm:text-left max-w-6xl w-full bg-white/10 backdrop-blur-2xl border border-white/20 rounded-3xl overflow-hidden shadow-2xl text-white p-8 gap-10">
            <figure class="w-full max-w-xs">
                <img src="https://cdn.flyonui.com/fy-assets/components/card/image-7.png" alt="Airpods Max"
                     class="rounded-2xl w-full h-auto object-cover shadow-md mx-auto">
            </figure>
            <div class="card-body p-0 flex flex-col justify-center items-center sm:items-start">
                <h2 class="text-4xl font-bold mb-4 leading-tight">Galaxy Series Smartphones</h2>
                <p class="text-lg text-white/90 leading-relaxed max-w-xl">
                    Discover the cutting-edge innovation behind Samsung Galaxy phones. Experience power, style, and
                    performance in one sleek device.
                </p>
            </div>
        </div>
    </div>
    <div class="h-screen flex items-center justify-center bg-cover bg-center bg-no-repeat px-4">
        <div
                class="card flex flex-col sm:flex-row items-center sm:items-start text-center sm:text-left max-w-6xl w-full bg-white/10 backdrop-blur-2xl border border-white/20 rounded-3xl overflow-hidden shadow-2xl text-white p-8 gap-10">
            <figure class="w-full max-w-xs">
                <img src="https://cdn.flyonui.com/fy-assets/components/card/image-7.png" alt="Airpods Max"
                     class="rounded-2xl w-full h-auto object-cover shadow-md mx-auto">
            </figure>
            <div class="card-body p-0 flex flex-col justify-center items-center sm:items-start">
                <h2 class="text-4xl font-bold mb-4 leading-tight">Galaxy Series Smartphones</h2>
                <p class="text-lg text-white/90 leading-relaxed max-w-xl">
                    Discover the cutting-edge innovation behind Samsung Galaxy phones. Experience power, style, and
                    performance in one sleek device.
                </p>
            </div>
        </div>
    </div>
</div>


<footer class="footer bg-base-200/60 flex flex-col items-center gap-4 p-6">
    <div class="flex items-center gap-2 text-xl font-bold">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" clip-rule="evenodd"
                  d="M17.6745 16.9224L12.6233 10.378C12.2167 9.85117 11.4185 9.8611 11.0251 10.3979L6.45728 16.631C6.26893 16.888 5.96935 17.0398 5.65069 17.0398H3.79114C2.9635 17.0398 2.49412 16.0919 2.99583 15.4336L11.0224 4.90319C11.4206 4.38084 12.2056 4.37762 12.608 4.89668L20.9829 15.6987C21.4923 16.3558 21.024 17.3114 20.1926 17.3114H18.4661C18.1562 17.3114 17.8638 17.1677 17.6745 16.9224ZM12.5866 15.5924L14.8956 18.3593C15.439 19.0105 14.976 20 14.1278 20H9.74075C8.9164 20 8.4461 19.0586 8.94116 18.3994L11.0192 15.6325C11.4065 15.1169 12.1734 15.0972 12.5866 15.5924Z"
                  fill="var(--color-primary)" />
        </svg>
        <span>FlyonUI</span>
    </div>
    <aside>
        <p>©2024FlyonUI</p>
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
        loader.classList.add("hidden");

        loader.addEventListener("transitionend", () => {
            loader.remove();
        });
    });

    const searchInput = document.getElementById("searchInput");
    const searchContainer = document.getElementById("searchContainer");

    searchInput.addEventListener("focus", () => {
        searchContainer.classList.replace("w-[20%]", "w-[60%]");
    });

    searchInput.addEventListener("blur", () => {
        searchContainer.classList.replace("w-[60%]", "w-[20%]");
    });

</script>
</body>


</html>