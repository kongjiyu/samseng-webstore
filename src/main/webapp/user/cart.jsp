<jsp:useBean id="cart" scope="session" type="java.util.List<CartItemDTO>" />
<%@ page import="java.util.Map" %>
<%@ page import="com.samseng.web.dto.CartItemDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/cart.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>

    <title>Cart</title>
</head>

<body onload="getRowCount()">

<%@ include file="/general/userHeader.jsp" %>

<!--Banner-->
<div class="h-[40%] flex">
    <img class="hero-image" src="../static/img/cart-background.jpg" alt="cartBanner"/>
    <!--
    <image class="hero-image" style="background-image: url('<%-- request.getContextPath() --%>/static/img/phone-store-banner.jpg');"></image>
    -->
    <div class="hero-text">
        <h1>My Cart</h1>
    </div>
</div>

<!--Don't collapse this if you value your sanity-->
<div id="container">


    <div id="cart-section" class="card w-[70%] h-[90%] border-base-content/25 border">

        <h1 class="text-3xl mt-5 mb-5 ml-5 font-bold">Item List</h1>
        <div class="overflow-x-auto">
            <table id="item-list" class="table">
                <!-- head -->
                <thead>
                <tr class="mt-5 border-0 bg-base-300/20">
                    <th>No.</th>
                    <th>Product</th>
                    <th>Variant</th>
                    <th>Category</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<CartItemDTO> cartItems = (List<CartItemDTO>) cart;
                    if (cartItems != null && !cartItems.isEmpty()) {
                        int index = 1;
                        for (CartItemDTO item : cartItems) {
                %>
                            <tr>
                                <td><%= index %></td>
                                <td>
                                    <div class="flex items-center gap-3">
                                        <div class="avatar">
                                            <div class="bg-base-content/10 h-10 w-10 rounded-md">
                                                <img src="/uploads/<%= item.imageUrl() %>" alt="product image"/>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="text-sm opacity-50"><%= item.variant().getProduct().getId() %></div>
                                            <div class="font-medium"><%= item.variant().getProduct().getName() %></div>
                                        </div>
                                    </div>
                                </td>
                                <td class="whitespace-normal break-words max-w-[200px]">
                                    <%= item.variant().getVariantName() %>
                                </td>
                                <td><%= item.variant().getProduct().getCategory() %></td>
                                <td><%= item.quantity() %></td>
                                <td>RM<%= item.variant().getPrice() %></td>
                                <td>
                                    <form action="<%= request.getContextPath() %>/cart/update" method="post" style="display:inline;">
                                        <input type="hidden" name="variantId" value="<%= item.variant().getVariantId() %>" />
                                        <input type="hidden" name="action" value="increase" />
                                        <button type="submit" class="btn btn-circle btn-text btn-sm">
                                            <span class="icon-[tabler--plus] size-5"></span>
                                        </button>
                                    </form>

                                    <form action="<%= request.getContextPath() %>/cart/update" method="post" style="display:inline;">
                                        <input type="hidden" name="variantId" value="<%= item.variant().getVariantId() %>" />
                                        <input type="hidden" name="action" value="decrease" />
                                        <button type="submit" class="btn btn-circle btn-text btn-sm">
                                            <span class="icon-[tabler--minus] size-5"></span>
                                        </button>
                                    </form>

                                    <form action="<%= request.getContextPath() %>/cart/update" method="post" style="display:inline;">
                                        <input type="hidden" name="variantId" value="<%= item.variant().getVariantId() %>" />
                                        <input type="hidden" name="action" value="delete" />
                                        <button type="submit" class="btn btn-circle btn-text btn-sm">
                                            <span class="icon-[tabler--trash] size-5"></span>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                <%
                            index++;
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="7" class="text-center text-base-content/60 py-4">No product in cart.</td>
                        </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <div class="flex flex-wrap items-center justify-between gap-2 pl-2 py-4 pt-4">
            <div class="me-2 block max-w-sm text-sm text-base-content/80 sm:mb-0">
                Showing
                <span id="row-count" class="font-semibold text-base-content/80"></span>
                products
            </div>
        </div>
    </div>


    <div id="cart-summary" class="card w-[30%] mt-10 border-base-content/25 border">
        <div>
            <h1 class="text-3xl ml-1 mt-3 mb-5 font-bold">Summary</h1>
        </div>

        <div>
            <h2 class="ml-2 text-2xl">Enter Voucher Code</h2>
            <div class="join form-control max-w-sm m-3 w-full">
                <input type="text" style="text-transform:uppercase" class="input join-item" placeholder="Voucher Code"/>
                <input type="submit" value="Submit" class="btn btn-primary join-item"/>
            </div>
        </div>

        <div class="overflow-x-auto mt-5">
            <table id="price-calc" class="table">
                <tbody>
                <tr class="border-0">
                    <td>Shipping Cost</td>
                    <td>$10</td>
                </tr>

                <tr class="border-0">
                    <td>Discount</td>
                    <td>0%</td>
                </tr>

                <tr class="border-0">
                    <td>Tax</td>
                    <td>$60 (6%)</td>
                </tr>

                <tr class="border-0 bg-base-300/20">
                    <td class="text-2xl">Estimated Total</td>
                    <td class="text-2xl">$3999.00</td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="mt-5">
            <button type="button" class="btn btn-primary w-full mt-5 mb-5" aria-haspopup="dialog" aria-expanded="false"
                    aria-controls="middle-center-modal" data-overlay="#middle-center-modal">Checkout
            </button>

        </div>

    </div>
</div>

<div id="payment-form">

    <div id="middle-center-modal"
         class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden" role="dialog"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-lg overlay-open:opacity-100 overlay-open:duration-300">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title text-3xl font-bold">Great! That'll be $3999.00.</h3>
                    <button type="button" class="btn btn-text btn-circle btn-lg absolute end-3 top-3" aria-label="Close"
                            data-overlay="#middle-center-modal"
                            data-overlay-options='{ "backdropClasses": "transition duration-300 fixed inset-0 bg-black/40 overlay-backdrop" }'>
                        <span class="icon-[tabler--x] size-10"></span>
                    </button>
                </div>

                <!--CONTENTS OF THE FORM-->
                <div class="modal-body">
                    <!-- Start Stepper -->
                    <div data-stepper="" class="bg-base-100 w-full rounded-lg p-4 shadow-base-300/20 shadow-sm"
                         id="wizard-validation-horizontal">

                        <!-- Stepper Nav -->
                        <ul class="relative flex flex-col gap-2 md:flex-row">
                            <li class="group flex flex-1 flex-col items-center gap-2 md:flex-row"
                                data-stepper-nav-item='{ "index": 1 }'>
                  <span
                          class="min-h-7.5 min-w-7.5 inline-flex flex-col items-center gap-2 align-middle text-sm md:flex-row">
                    <span
                            class="stepper-active:text-bg-primary stepper-active:shadow-sm shadow-base-300/20 stepper-success:text-bg-primary stepper-success:shadow-sm stepper-completed:text-bg-success stepper-error:text-bg-error text-bg-soft-neutral flex size-7.5 shrink-0 items-center justify-center rounded-full font-medium">
                      <span
                              class="stepper-success:hidden stepper-error:hidden stepper-completed:hidden text-sm">1</span>
                      <span class="icon-[tabler--check] stepper-success:block hidden size-4 shrink-0"></span>
                      <span class="icon-[tabler--x] stepper-error:block hidden size-4 shrink-0"></span>
                    </span>
                    <span class="text-base-content text-nowrap font-medium">Shipping Address</span>
                  </span>
                                <div
                                        class="stepper-success:bg-primary stepper-completed:bg-success bg-base-content/20 h-px w-full group-last:hidden max-md:mt-2 max-md:h-8 max-md:w-px md:flex-1">
                                </div>
                            </li>
                            <li class="group flex flex-1 flex-col items-center gap-2 md:flex-row"
                                data-stepper-nav-item='{ "index": 2 }'>
                  <span
                          class="min-h-7.5 min-w-7.5 inline-flex flex-col items-center gap-2 align-middle text-sm md:flex-row">
                    <span
                            class="stepper-active:text-bg-primary stepper-active:shadow-sm shadow-base-300/20 stepper-success:text-bg-primary stepper-success:shadow-sm stepper-completed:text-bg-success stepper-error:text-bg-error text-bg-soft-neutral flex size-7.5 shrink-0 items-center justify-center rounded-full font-medium">
                      <span
                              class="stepper-success:hidden stepper-error:hidden stepper-completed:hidden text-sm">2</span>
                      <span class="icon-[tabler--check] stepper-success:block hidden size-4 shrink-0"></span>
                      <span class="icon-[tabler--x] stepper-error:block hidden size-4 shrink-0"></span>
                    </span>
                    <span class="text-base-content text-nowrap font-medium">Payment Method</span>
                  </span>
                                <div
                                        class="stepper-success:bg-primary stepper-completed:bg-success bg-base-content/20 h-px w-full group-last:hidden max-md:mt-2 max-md:h-8 max-md:w-px md:flex-1">
                                </div>
                            </li>
                            <li class="group flex flex-1 flex-col items-center gap-2 md:flex-row"
                                data-stepper-nav-item='{ "index": 3 }'>
                  <span
                          class="min-h-7.5 min-w-7.5 inline-flex flex-col items-center gap-2 align-middle text-sm md:flex-row">
                    <span
                            class="stepper-active:text-bg-primary stepper-active:shadow-sm shadow-base-300/20 stepper-success:text-bg-primary stepper-success:shadow-sm stepper-completed:text-bg-success stepper-error:text-bg-error text-bg-soft-neutral flex size-7.5 shrink-0 items-center justify-center rounded-full font-medium">
                      <span
                              class="stepper-success:hidden stepper-error:hidden stepper-completed:hidden text-sm">3</span>
                      <span class="icon-[tabler--check] stepper-success:block hidden size-4 shrink-0"></span>
                      <span class="icon-[tabler--x] stepper-error:block hidden size-4 shrink-0"></span>
                    </span>
                    <span class="text-base-content text-nowrap font-medium">Confirmation</span>
                  </span>
                                <div
                                        class="stepper-success:bg-primary stepper-completed:bg-success bg-base-content/20 h-px w-full group-last:hidden max-md:mt-2 max-md:h-8 max-md:w-px md:flex-1">
                                </div>
                            </li>
                            <!-- End Item -->
                        </ul>
                        <!-- End Stepper Nav -->


                        <!-- Stepper Content -->
                        <form id="wizard-validation-form-horizontal" class="needs-validation mt-5 sm:mt-8">

                            <!-- Addressing Details -->
                            <div id="address-validation" data-stepper-content-item='{ "index": 1 }'
                                 style="display: none">
                                <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                                    <label class="custom-option gap-3">
                                        <input type="radio" name="radio-17" class="radio hidden" checked/>
                                        <span class="label-text w-full text-start">
                        <span class="flex justify-between mb-1">
                          <span class="text-base">Home Address</span>
                          <span class="text-base-content/50 text-base">DEFAULT</span>
                        </span>
                        <span>
                          <p>123 Main Street, Springfield</p>
                          <p>+1 234 567 890</p>
                          <p>USA</p>
                        </span>
                      </span>
                                    </label>


                                    <label class="custom-option gap-3">
                                        <input type="radio" name="radio-17" class="radio hidden"/>
                                        <span class="label-text w-full text-start">
                        <span class="flex justify-between mb-1">
                          <span class="text-base">Workplace</span>
                        </span>
                        <span>
                          <p>456 Side Road, Shelbyville</p>
                          <p>+1 987 654 321</p>
                          <p>USA</p>
                        </span>
                      </span>
                                    </label>


                                    <label class="custom-option gap-3">
                                        <input type="radio" name="radio-17" class="radio hidden"/>
                                        <span class="label-text w-full text-start">
                        <span class="flex justify-between mb-1">
                          <span class="text-base">Workplace</span>
                        </span>
                        <span>
                          <p>456 Side Road, Shelbyville</p>
                          <p>+1 987 654 321</p>
                          <p>USA</p>
                        </span>
                      </span>
                                    </label>
                                </div>

                                <div class="mt-3">
                                    <p>Your address isn't listed? <a
                                            href="<%= request.getContextPath() %>userProfile.jsp" id="link-to-profile">Register
                                        it here!</a></p>
                                </div>
                            </div>

                            <!-- End Addressing Details -->


                            <!-- Payment -->
                            <div id="payment-validation" class="space-y-5" data-stepper-content-item='{ "index": 2 }'
                                 style="display: none" onchange="emptyFieldCatcher()">
                                <div class="w-full items-start gap-4 grid grid-cols-1 md:grid-cols-3">

                                    <!--Cards-->
                                    <label class="custom-option flex flex-col items-center gap-3">
                                        <span class="icon-[tabler--credit-card] size-10"></span>
                                        <span class="label-text p-0">
                        <p class="text-base">Credit/Debit</p>
                      </span>
                                        <input id="card-radio" onclick="showCardForm()" type="radio" name="radio-19"
                                               class="radio radio-primary"/>
                                    </label>


                                    <!--E Wallet-->
                                    <label class="custom-option flex flex-col items-center gap-3">
                                        <span class="icon-[tabler--wallet] size-10"></span>
                                        <span class="label-text p-0">
                        <p class="text-base">E-Wallet</p>
                      </span>
                                        <input id="wallet-radio" onclick="showWalletForm()" type="radio" name="radio-19"
                                               class="radio radio-primary"/>
                                    </label>

                                    <!--Cash-->
                                    <label class="custom-option flex flex-col items-center gap-3">
                                        <span class="icon-[tabler--cash] size-10"></span>
                                        <span class="label-text p-0">
                        <p class="text-base">Cash on Delivery</p>
                      </span>
                                        <input id="cash-radio" onclick="showCashForm()" type="radio" name="radio-19"
                                               class="radio radio-primary"/>
                                    </label>
                                </div>

                                <div id="hidden-forms">
                                    <div id="card-form" hidden="true">
                                        <div>
                                            <label class="label-text">Card Number</label>
                                            <input type="text" id="card-number"
                                                   pattern="[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}" class="input"
                                                   placeholder="1234 5678 9012 3456"/>
                                        </div>

                                        <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                                            <div>
                                                <label class="label-text">Expiry Date</label>
                                                <input type="text" id="expiry-date" class="input" placeholder="MM/YY"/>
                                            </div>
                                            <div>
                                                <label class="label-text">CVC</label>
                                                <input type="password" id="cvc" class="input" placeholder="123"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="wallet-form" hidden="true">
                                        <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                                            <div>
                                                <label class="label-text">Phone Number</label>
                                                <input type="tel" id="wallet-phone-number" class="input"
                                                       placeholder="+60122339810"/>
                                            </div>
                                            <div>
                                                <label class="label-text">PIN</label>
                                                <div class="flex space-x-2 ml-2" id="grouped-pin-input" data-pin-input>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item/>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item/>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item/>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item/>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item/>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item/>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <div id="cash-form" hidden="true">
                                        <label class="label-text">Phone Number</label>
                                        <input type="tel" id="cash-phone-number" class="input"
                                               placeholder="+60122339810"/>
                                    </div>

                                </div>
                            </div>
                            <!-- End Payment Method -->


                            <!-- Confirmation -->
                            <div id="social-links-validation" class="space-y-5"
                                 data-stepper-content-item='{ "index": 3}'
                                 style="display: none">
                                <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                                    <div class="card sm:max-w-sm">
                                        <div class="card-header">
                                            <h5 class="card-title">Shipping Address</h5>
                                        </div>
                                        <div class="card-body">
                                            <p>Hihi testing testing</p>
                                            <p>Get these three lines</p>
                                            <p>From the selected address</p>
                                        </div>
                                    </div>

                                    <div class="card sm:max-w-sm">
                                        <div class="card-header">
                                            <h5 class="card-title">Payment Method</h5>
                                        </div>
                                        <div class="card-body">
                                            <p>Hihi testing testing, yes get this from the selected method too</p>
                                        </div>
                                    </div>
                                </div>
                                <h1 class="text-2xl text-bold">Please confirm Payment Details before Checkout...</h1>
                            </div>


                            <!-- Final Content -->
                            <div data-stepper-content-item='{ "isFinal": true }' style="display: none">
                                <div
                                        class="border-base-content/40 bg-base-200/50 flex h-48 items-center justify-center rounded-xl border border-dashed p-4">
                                    <h3 class="text-base-content/50 text-3xl">Your Payment is Successful!</h3>
                                </div>
                            </div>
                            <!-- End Final Content -->


                            <!-- Button Group -->
                            <div class="mt-5 flex items-center justify-between gap-y-2">
                                <button type="button" class="btn btn-primary btn-prev max-sm:btn-square"
                                        data-stepper-back-btn="">
                                    <span class="icon-[tabler--chevron-left] text-primary-content size-5 rtl:rotate-180"></span>
                                    <span class="max-sm:hidden">Back</span>
                                </button>

                                <!-- Disable this on empty input -->
                                <button id="next-button" type="button"
                                        class="btn btn-primary btn-next max-sm:btn-square" data-stepper-next-btn="">
                                    <span class="max-sm:hidden">Next</span>
                                    <span class="icon-[tabler--chevron-right] text-primary-content size-5 rtl:rotate-180"></span>
                                </button>

                                <button type="submit" input="submit" onsubmit="" class="btn btn-primary"
                                        data-stepper-finish-btn=""
                                        style="display: none">Finish
                                </button>
                            </div>
                            <!-- End Button Group -->
                        </form>
                        <!-- End Stepper Content -->
                    </div>
                    <!-- End Stepper -->

                </div>
                <!--END OF FORM CONTENT-->

            </div>
        </div>
    </div>
</div>

<!-- Dynamic Form Display -->
<script>
    function showCardForm() {
        document.getElementById("card-form").removeAttribute("hidden");
        document.getElementById("wallet-form").setAttribute("hidden", "true");
        document.getElementById("cash-form").setAttribute("hidden", "true");
    }

    function showWalletForm() {
        document.getElementById("card-form").setAttribute("hidden", "true");
        document.getElementById("wallet-form").removeAttribute("hidden");
        document.getElementById("cash-form").setAttribute("hidden", "true");
    }

    function showCashForm() {
        document.getElementById("card-form").setAttribute("hidden", "true");
        document.getElementById("wallet-form").setAttribute("hidden", "true");
        document.getElementById("cash-form").removeAttribute("hidden");
    }
</script>

<!-- Form Validation (Disables/Enables button) -->
<script>
    var nextButton = document.getElementById("next-button");
    const cardPattern = /^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}$/;
    const expiryPattern = /^(0[1-9]|1[0-2])\/?([0-9]{2})$/;
    const cvcPattern = /^[0-9]{3}$/;
    const phonePattern = /^\+?[0-9]{10,15}$/;

    function emptyFieldCatcher() {
        if (cardPattern.test(getElementById("card-number").value) === true ||
            expiryPattern.test(getElementById("expiry-date").value) === true ||
            cvcPattern.test(getElementById("cvc").value) === true) {
            nextButton.classList.remove("btn-disabled");
        } else if (phonePattern.test(getElementById("wallet-phone-number").value) ||
            getElementById("grouped-pin-input").value.length === 6) {
            nextButton.classList.remove("btn-disabled");
        } else if (phonePattern.test(getElementById("cash-phone-number").value) === true) {
            nextButton.classList.remove("btn-disabled");
        } else {
            nextButton.classList.add("btn-disabled");
        }
    }

    document.getElementById("next-button").addEventListener("onchange", emptyFieldCatcher);
</script>


<!-- Row Counter -->
<script>
    window.addEventListener('load', function () {
        // Initialize flatpickr
        flatpickr('.jsPickr', {
            allowInput: true,
            monthSelectorType: 'static'
        })
    })
</script>
<script>
    function getRowCount() {
        var oRows = document.getElementById('item-list').getElementsByTagName('tr');
        var iRowCount = oRows.length - 1; // Subtract 1 for the header row

        document.getElementById("row-count").innerText = iRowCount; // Display the result
    }
</script>

<%@ include file="/general/userFooter.jsp" %>

</body>

</html>