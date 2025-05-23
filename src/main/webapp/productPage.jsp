<%@ page contentType="text/html; charset=UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="products" type="java.util.List<com.samseng.web.dto.ProductListingDTO>" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Products</title>
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
    <img class="hero-image" src="static/img/phone-store-banner.jpg" alt="phoneBanner" />
    <!--
    <image class="hero-image" style="background-image: url('<%-- request.getContextPath() --%>/static/img/phone-store-banner.jpg');"></image>
    -->
    <div class="hero-text">
        <h1>Products</h1>
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
         class="min-h-screen overflow-auto overlay overlay-open:translate-x-0 drawer drawer-start hidden [--body-scroll:true]" role="dialog"
         tabindex="-1">
        <div class="drawer-header">
            <h3 class="drawer-title">Filter Categories</h3>
            <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close"
                    data-overlay="#overlay-body-scrolling-with-backdrop">
                <span class="icon-[tabler--x] size-5"></span>
            </button>
        </div>
        <form action="${pageContext.request.contextPath}/products" method="get">
            <div class="drawer-body justify-start">

                <!--Product Name-->
                <div id="nameField" class="mb-4">
                    <label class="label-text font-medium" for="nameFilterInput"> Product Name </label>
                    <input type="text" placeholder="Samseng Galaxy S22" class="input" id="nameFilterInput" name="name"/>
                </div>

                <!--Price Range-->
                <div id="priceField" class="mb-4 flex flex-row space-x-4 rtl:flex-row-reverse">
                    <div class="basis-1/2">
                        <label for="minPriceFilterInput" class="mb-2 block text-sm font-medium">Min price:</label>
                        <input id="minPriceFilterInput" min="1" max="9999"  name="minPrice" class="input" type="number" step="0.01" placeholder="3000" />
                    </div>
                    <div class="basis-1/2">
                        <label for="maxPriceFilterInput" class="mb-2 block text-sm font-medium">Max price:</label>
                        <input id="maxPriceFilterInput" min="2" max="10000" name="maxPrice" class="input" type="number" step="0.01" placeholder="6000" />
                    </div>
                </div>

                <!--Product Category-->
                <div id="categoryField" class="max-w-sm mb-4">
                    <label class="label-text font-medium" for="categoryFilterInput">Category</label>
                    <select name="category" id="categoryFilterInput" multiple="" data-select='{
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
                        <option value="Mobile Phone">Smart Phone</option>
                        <option>Tab</option>
                        <option>Monitor</option>
                        <option>Powerbank</option>
                        <option>Smart Watch</option>
                        <option>Smart Pen</option>
                        <option>Earbuds</option>
                    </select>
                </div>

                <!--Color Options-->
                <div id="colorField" class="max-w-sm mb-4">
                    <label class="label-text font-medium" for="colorFilterInput">Color Options</label>
                    <select name="Color" id="colorFilterInput" multiple="" data-select='{
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
                        <option>White</option>
                        <option>Black</option>
                        <option>Yellow</option>
                        <option>Pink</option>
                        <option>Lavender</option>
                        <option>Green</option>

                    </select>
                </div>

                <!--Length Options-->
                <div id="lengthField" class="max-w-sm mb-4">
                    <label class="label-text font-medium" for="lengthFilterInput">Length Options</label>
                    <select name="Length" id="lengthFilterInput" multiple="" data-select='{
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
                        <option>40mm</option>
                        <option>43mm</option>
                        <option>44mm</option>
                        <option>47mm</option>
                    </select>
                </div>

                <!--Capacity Options-->
                <div id="capacityField" class="max-w-sm mb-4">
                    <label class="label-text font-medium" for="capacityFilterInput">Capacity Options</label>
                    <select name="Capacity" id="capacityFilterInput" multiple="" data-select='{
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
                        <option>10,000mAh</option>
                    </select>
                </div>

                <!--Size Option-->
                <div id="sizeField" class="max-w-sm mb-4">
                    <label class="label-text font-medium" for="sizeFilterInput">Size Options</label>
                    <select name="Size" id="sizeFilterInput" multiple="" data-select='{
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
                        <option>49'</option>
                        <option>32'</option>
                        <option>27'</option>
                    </select>
                </div>

                <!--Storage Options-->
                <div id="storageField" class="max-w-sm mb-4">
                    <label class="label-text font-medium" for="storageFilterInput">Storage Options</label>
                    <select name="Storage" id="storageFilterInput" multiple="" data-select='{
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
                        <option value="256GB">256 GB</option>
                        <option value="512GB">512 GB</option>
                        <option value="1TB">1 TB</option>
                    </select>
                    <!-- End Select -->
                </div>

            </div>

            <div class="drawer-footer">
                <button type="button" class="btn btn-soft btn-secondary" data-overlay="#overlay-form-example">Close</button>
                <button type="submit" class="btn btn-primary">Filter</button>
            </div>
        </form>
    </div>

    <div class="product-section">
        <c:choose>
            <c:when test="${not empty products}">
                <c:forEach var="product" items="${products}">
                    <div class="product-card card w-[320px] h-[550px] flex flex-col justify-between items-start p-4 mb-8 mx-auto">
                        <div class="w-full flex flex-col items-start flex-1">
                            <img src="/uploads/${product.imageUrls()[0]}" alt="product-image"
                                 class="object-cover rounded-lg w-[250px] h-[250px] mb-4"/>
                            <div class="w-full text-left">
                                <a href="<%=request.getContextPath()%>/product?productId=${product.id()}"><h5 class="text-xl font-bold mb-2">${product.name()}</h5></a>
                                <p class="text-gray-600 mb-2">${product.desc().length() > 45 ? product.desc().substring(0, 45).concat("...") : product.desc()}</p>
                                <p class="text-lg mb-2">
                                    <span class="font-bold"><fmt:formatNumber value="${product.startingPrice()}" type="currency"
                                                                              currencySymbol="RM "/></span>
                                    <c:if test="${product.startingPrice() != product.endingPrice()}">
                                        ~ <span class="font-bold"><fmt:formatNumber value="${product.endingPrice()}"
                                                                                    type="currency"
                                                                                    currencySymbol="RM "/></span>
                                    </c:if>
                                </p>
                                <c:if test="${product.ratingSummary().avgRating() != null}">
                                    <div class="flex items-center mb-2">
                                        <span class="icon-[tabler--star-filled] size-5 text-yellow-400"></span>
                                        <span class="text-lg font-semibold ml-1">
                                            <fmt:formatNumber value="${product.ratingSummary().avgRating()}" maxFractionDigits="2"
                                                              minFractionDigits="2"/>
                                        </span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <a class="btn rounded-full btn-primary mt-4 w-full"
                           href="<%=request.getContextPath()%>/product?productId=${product.id()}">Learn more</a>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="text-center text-gray-500 text-3xl my-10">
                    No products found.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>


<%@include file="/general/userFooter.jsp"%>

</body>
</html>
