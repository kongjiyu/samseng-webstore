<%@ page contentType="text/html; charset=UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="products" type="java.util.List<com.samseng.web.dto.ProductListingDTO>" scope="request" />

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

<%@ include file="/general/userHeader.jsp" %>


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
<%--        for (var product : products )--%>
        <c:forEach var="product" items="${products}">
        <div class="product-card card sm:max-w-xs">
            <figure><img src="${product.imageUrls()[0]}" alt="Watch" /></figure>
            <div class="card-body">
                <h5 class="card-title mb-2.5">${product.name()}</h5>
                <p class="mb-4">${product.desc().substring(0, 40) + "..."}</p>
                <p>Starting at <span class="text-xl font-bold">
                    <fmt:formatNumber value="${product.startingPrice()}" type="currency" currencySymbol="RM " />
                </span></p>
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
        </c:forEach>
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
