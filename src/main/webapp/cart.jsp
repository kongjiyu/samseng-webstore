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

<body data-theme="light">

<%@ include file="/general/userHeader.jsp" %>

<!--Banner-->
<div class="h-[40%] flex">
    <img class="hero-image" src="static/img/cart-background.jpg" alt="cartBanner"/>
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
                    <th class="text-center">No.</th>
                    <th class="text-center">Product</th>
                    <th class="text-center">Category</th>
                    <th class="text-center">Quantity</th>
                    <th class="text-center">Price</th>
                    <th class="text-center">Action</th>
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
                    <td class="text-center"><%= index %>
                    </td>
                    <td>
                        <div class="flex items-center gap-3">
                            <div class="avatar">
                                <div class="bg-base-content/10 h-10 w-10 rounded-md">
                                    <img src="/uploads/<%= item.imageUrl() %>" alt="product image"/>
                                </div>
                            </div>
                            <div>
                                <div class="text-sm opacity-50"><%= item.variant().getProduct().getId() %>
                                </div>
                                <div class="font-medium"><%= item.variant().getVariantName() %>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td class="text-center"><%= item.variant().getProduct().getCategory() %>
                    </td>
                    <td class="text-center"><%= item.quantity() %>
                    </td>
                    <td class="text-center">RM<%= item.variant().getPrice() %>
                    </td>
                    <td>
                        <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline;">
                            <input type="hidden" name="variantId" value="<%= item.variant().getVariantId() %>"/>
                            <input type="hidden" name="action" value="increase"/>
                            <button type="submit" class="btn btn-circle btn-text btn-sm">
                                <span class="icon-[tabler--plus] size-5"></span>
                            </button>
                        </form>

                        <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline;">
                            <input type="hidden" name="variantId" value="<%= item.variant().getVariantId() %>"/>
                            <input type="hidden" name="action" value="decrease"/>
                            <button type="submit" class="btn btn-circle btn-text btn-sm">
                                <span class="icon-[tabler--minus] size-5"></span>
                            </button>
                        </form>

                        <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline;">
                            <input type="hidden" name="variantId" value="<%= item.variant().getVariantId() %>"/>
                            <input type="hidden" name="action" value="remove"/>
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
                <span class="font-semibold text-base-content/80"> <%=cartItems.isEmpty() ? "0" : cartItems.size() %> </span>
                products
            </div>
        </div>
    </div>


    <div id="cart-summary" class="card w-[30%] mt-10 border-base-content/25 border">
        <div>
            <h1 class="text-3xl ml-1 mt-3 mb-5 font-bold">Summary</h1>
        </div>

        <div>
            <h2 class="ml-2 text-xl">Enter Promo Code</h2>
            <form action="<%= request.getContextPath() %>/promo-code" method="post"
                  class="join form-control max-w-sm m-3 w-[90%]">
                <input id="promo-code" name="promo-code" type="text" style="text-transform:uppercase"
                       class="input join-item" placeholder="Promo Code"/>
                <button type="submit" class="btn btn-primary join-item">Submit</button>
            </form>
            <% Boolean promoError = (Boolean) request.getAttribute("promoError");
                if (promoError != null && promoError) { %>
            <p class="text-red-500 text-sm ml-4">Invalid promo code.</p>
            <% } %>
        </div>

        <%
            double grossPrice = 0.0;
            for (CartItemDTO item : cartItems) {
                grossPrice += item.variant().getPrice() * item.quantity();
            }

            double taxRate = 0.06;
            double taxCharge = grossPrice * taxRate;

            double deliveryCharge = 0.0;
            if (grossPrice < 1000) {
                deliveryCharge = 35.0;
            }

            Promo_Code promoCode = (Promo_Code) request.getAttribute("promoCode");
            double discountRate = 0.0;
            if (promoCode != null) {
                discountRate = promoCode.getDiscount();
            }
            double discountAmount = grossPrice * discountRate;
            double netPrice = grossPrice + taxCharge + deliveryCharge - discountAmount;
        %>

        <div class="overflow-x-auto mt-5">
            <table id="price-calc" class="table">
                <tbody>
                <tr class="border-0">
                    <td>Gross Price</td>
                    <td>RM<%= String.format("%.2f", grossPrice) %>
                    </td>
                </tr>
                <tr class="border-0">
                    <td>Tax (6%)</td>
                    <td>RM<%= String.format("%.2f", taxCharge) %>
                    </td>
                </tr>
                <tr class="border-0">
                    <td>Delivery Charge</td>
                    <td>RM<%= String.format("%.2f", deliveryCharge) %>
                    </td>
                </tr>
                <tr class="border-0 text-green">
                    <td>Discount(<%=(int) (discountRate * 100)%>%)</td>
                    <td>RM<%= String.format("%.2f", discountAmount) %>
                    </td>
                </tr>
                <tr class="border-0 bg-base-300/20">
                    <td class="text-xl font-bold">Net Price</td>
                    <td class="text-xl font-bold">RM<%= String.format("%.2f", netPrice) %>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="mt-5">
            <%
                boolean isLoggedIn = session.getAttribute("profile") != null;
                boolean isCartEmpty = cartItems == null || cartItems.isEmpty();
            %>
            <% if (!isLoggedIn) { %>
                <a href="<%= request.getContextPath() %>/login-flow" class="btn btn-primary w-full mt-5 mb-5">
                    Login to Checkout
                </a>
            <% } else { %>
                <button type="button"
                        class="btn btn-primary w-full mt-5 mb-5 <%= isCartEmpty ? "btn-disabled" : "" %>"
                        aria-haspopup="dialog"
                        aria-expanded="false"
                        aria-controls="middle-center-modal"
                        data-overlay="#middle-center-modal"
                        <%= isCartEmpty ? "disabled" : "" %>>
                    Checkout
                </button>
            <% } %>
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
                    <h3 class="modal-title text-3xl font-bold">Great! That'll be RM<%=String.format("%.2f", netPrice)%></h3>
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
                        <form id="wizard-validation-form-horizontal" class="needs-validation mt-5 sm:mt-8" method="post" action="<%= request.getContextPath() %>/user/sales-order">                            <input type="hidden" name="grossPrice" value="<%= String.format("%.2f", grossPrice) %>"/>
                            <input type="hidden" name="promo-code" value="<%= promoCode != null ? promoCode.getId() : null  %>"/>
                            <input type="hidden" name="taxCharge" value="<%= String.format("%.2f", taxCharge) %>"/>
                            <input type="hidden" name="deliveryCharge" value="<%= String.format("%.2f", deliveryCharge) %>"/>
                            <input type="hidden" name="discountAmount" value="<%= String.format("%.2f", discountAmount) %>"/>
                            <input type="hidden" name="netPrice" value="<%= String.format("%.2f", netPrice) %>"/>

                            <!-- Addressing Details -->
                            <div id="address-validation" data-stepper-content-item='{ "index": 1 }'
                                 style="display: none">
                                <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
<%
    List<Address> addresses = (List<Address>) request.getAttribute("addresses");
    for (Address address : addresses) {
%>
    <label class="custom-option gap-3">
        <input type="radio" name="radio-17" class="radio hidden" value="<%=address.getId()%>" <%= address.getIsdefault() ? "checked" : "" %>/>
        <span class="label-text w-full text-start">
            <span class="flex justify-between mb-1">
                <span class="text-base"><%= address.getName() %></span>
                <% if (address.getIsdefault()) { %>
                    <span class="text-base-content/50 text-base">DEFAULT</span>
                <% } %>
            </span>
            <span>
                <p class="text-sm"><%= address.getAddress_1() %></p>
                <p class="text-sm"><%= address.getAddress_2() %></p>
                <% if (address.getAddress_3() != null && !address.getAddress_3().isEmpty()) { %>
                    <p class="text-sm"><%= address.getAddress_3() %></p>
                <% } %>
                <p class="text-sm"><%= address.getPostcode() %></p>
                <p class="text-sm"><%= address.getCountry() %></p>
                <p class="text-sm"><%= address.getContact_no() %></p>
            </span>
        </span>
    </label>
<% } %>
                                </div>
                                <div class="mt-3">
                                    <p>Your address isn't listed? <a
                                            href="<%= request.getContextPath() %>/user/profile" id="link-to-profile">Register
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
                                               class="radio radio-primary" value="Card"/>
                                    </label>


                                    <!--E Wallet-->
                                    <label class="custom-option flex flex-col items-center gap-3">
                                        <span class="icon-[tabler--wallet] size-10"></span>
                                        <span class="label-text p-0">
                        <p class="text-base">E-Wallet</p>
                      </span>
                                        <input id="wallet-radio" onclick="showWalletForm()" type="radio" name="radio-19"
                                               class="radio radio-primary" value="TNG"/>
                                    </label>

                                    <!--Cash-->
                                    <label class="custom-option flex flex-col items-center gap-3">
                                        <span class="icon-[tabler--cash] size-10"></span>
                                        <span class="label-text p-0">
                        <p class="text-base">Cash on Delivery</p>
                      </span>
                                        <input id="cash-radio" onclick="showCashForm()" type="radio" name="radio-19"
                                               class="radio radio-primary" value="Cash"/>
                                    </label>
                                </div>

                                <div id="hidden-forms">
                                    <div id="card-form" hidden="true">
                                        <div>
                                            <label class="label-text">Card Number</label>
                                            <input type="text" id="card-number" maxlength="19"
                                                   oninput="formatCardNumber(this)" pattern="[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}"
                                                   class="input" placeholder="1234 5678 9012 3456" required/>
                                        </div>

                                        <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                                            <div>
                                                <label class="label-text">Expiry Date</label>
                                                <input type="text" id="expiry-date" maxlength="5"
                                                       oninput="formatExpiryDate(this)" class="input" placeholder="MM/YY" required/>
                                            </div>
                                            <div>
                                                <label class="label-text">CCV</label>
                                                <input type="password" id="ccv" maxlength="3" pattern="[0-9]{3}" class="input" placeholder="123" required/>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="wallet-form" hidden="true">
                                        <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                                            <div>
                                                <label class="label-text">Phone Number</label>
                                                <input type="tel" id="wallet-phone-number" class="input"
                                                       placeholder="+60122339810" required/>
                                            </div>
                                            <div>
                                                <label class="label-text">PIN</label>
                                                <div class="flex space-x-2 ml-2" id="grouped-pin-input" data-pin-input>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item required/>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item required/>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item required/>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item required/>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item required/>
                                                    <input type="password" class="pin-input" placeholder="○"
                                                           data-pin-input-item required/>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <div id="cash-form" hidden="true">
                                        <label class="label-text">Phone Number</label>
                                        <input type="tel" id="cash-phone-number" class="input"
                                               placeholder="+60122339810" required/>
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
                                            <p id="confirmation-address"></p>
                                        </div>
                                    </div>

                                    <div class="card sm:max-w-sm">
                                        <div class="card-header">
                                            <h5 class="card-title">Payment Method</h5>
                                        </div>
                                        <div class="card-body">
                                            <p id="confirmation-payment"></p>
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

                                <button type="button" class="btn btn-primary"
                                        data-stepper-finish-btn=""
                                        onclick="document.getElementById('wizard-validation-form-horizontal').submit();"
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

<!-- Form Validation (Disables/Enables button) and Confirmation Population -->
<script>
    var nextButton = document.getElementById("next-button");
    const cardPattern = /^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}$/;
    const expiryPattern = /^(0[1-9]|1[0-2])\/?([0-9]{2})$/;
    const cvcPattern = /^[0-9]{3}$/;
    const phonePattern = /^\+?[0-9]{10,15}$/;
    let currentStepIndex = 1; // starting from address

    function emptyFieldCatcher() {
        // Determine which payment method is selected
        const cardRadio = document.getElementById("card-radio");
        const walletRadio = document.getElementById("wallet-radio");
        const cashRadio = document.getElementById("cash-radio");
        let valid = false;
        if (cardRadio && cardRadio.checked) {
            const cardNumber = document.getElementById("card-number");
            const expiryDate = document.getElementById("expiry-date");
            const ccv = document.getElementById("ccv");
            valid = cardNumber && expiryDate && ccv &&
                cardNumber.value.trim().length > 0 &&
                expiryDate.value.trim().length > 0 &&
                ccv.value.trim().length > 0 &&
                cardPattern.test(cardNumber.value) &&
                expiryPattern.test(expiryDate.value) &&
                cvcPattern.test(ccv.value);
        } else if (walletRadio && walletRadio.checked) {
            const walletPhone = document.getElementById("wallet-phone-number");
            const pinInputs = Array.from(document.querySelectorAll('#grouped-pin-input input.pin-input'));
            valid = walletPhone && walletPhone.value.trim().length > 0 &&
                phonePattern.test(walletPhone.value) &&
                pinInputs.length === 6 &&
                pinInputs.every(input => input.value.trim().length === 1);
        } else if (cashRadio && cashRadio.checked) {
            const cashPhone = document.getElementById("cash-phone-number");
            valid = cashPhone && cashPhone.value.trim().length > 0 &&
                phonePattern.test(cashPhone.value);
        }
        if (valid) {
            nextButton.classList.remove("btn-disabled");
        } else {
            nextButton.classList.add("btn-disabled");
        }
    }

    const paymentInputs = document.querySelectorAll('#payment-validation input');
    function addPaymentListeners() {
        paymentInputs.forEach(input => {
            input.addEventListener("input", emptyFieldCatcher);
        });
    }
    function removePaymentListeners() {
        paymentInputs.forEach(input => {
            input.removeEventListener("input", emptyFieldCatcher);
        });
    }
    addPaymentListeners(); // call this once on load

    function clearPaymentInputs() {
        document.querySelectorAll('input[name="radio-19"]').forEach(input => input.checked = false);
        document.getElementById("card-number").value = "";
        document.getElementById("expiry-date").value = "";
        document.getElementById("ccv").value = "";
        document.getElementById("wallet-phone-number").value = "";
        document.getElementById("cash-phone-number").value = "";
        document.querySelectorAll('.pin-input').forEach(pin => pin.value = "");
    }

    document.querySelector('[data-stepper-back-btn]').addEventListener("click", function () {
        if (currentStepIndex === 2) {
            removePaymentListeners();
            clearPaymentInputs();
            nextButton.classList.remove("btn-disabled");

        }
        currentStepIndex -= 1;
    });
    // Stepper navigation: Populate confirmation step with selected values
    // This assumes a stepper library that triggers data-stepper-next-btn and data-stepper-content-item
    // We'll hook into the "Next" button click to populate confirmation
    document.getElementById("next-button").addEventListener("click", function () {
        // Find which step is currently visible
        const stepperForm = document.getElementById("wizard-validation-form-horizontal");
        if (!stepperForm) return;
        // Find all step content items
        const stepItems = stepperForm.querySelectorAll('[data-stepper-content-item]');
        let currentStep = -1;
        stepItems.forEach((item, idx) => {
            if (item.style.display !== "none") {
                currentStep = idx + 1;
            }
        });
        // If going to step 3 (confirmation), populate the confirmation fields
        if (currentStep === 2) {
            // Address summary
            let selectedAddressSummary = "";
            const addressRadio = stepperForm.querySelector('input[name="radio-17"]:checked');
            if (addressRadio) {
                // Get the label text for the selected address
                const label = addressRadio.closest("label");
                if (label) {
                    // Get the text content of the address details (excluding the radio)
                    const summary = label.querySelector(".label-text");
                    if (summary) {
                        // Remove "DEFAULT" and flatten to a string
                        let temp = summary.cloneNode(true);
                        // Remove DEFAULT span if present
                        const def = temp.querySelector('span.text-base-content\\/50');
                        if (def) def.remove();
                        selectedAddressSummary = temp.innerText.trim().replace(/\s*\n\s*/g, "\n");
                    }
                }
            }
            // Payment summary
            let selectedPaymentSummary = "";
            if (document.getElementById("card-radio").checked) {
                const cardNum = document.getElementById("card-number").value;
                const expiry = document.getElementById("expiry-date").value;
                selectedPaymentSummary = "Credit/Debit Card\nCard Number: **** **** **** " + (cardNum ? cardNum.slice(-4) : "") + "\nExpiry: " + expiry;
            } else if (document.getElementById("wallet-radio").checked) {
                const walletPhone = document.getElementById("wallet-phone-number").value;
                selectedPaymentSummary = "E-Wallet\nPhone: " + walletPhone + "\nPIN: ******";
            } else if (document.getElementById("cash-radio").checked) {
                const cashPhone = document.getElementById("cash-phone-number").value;
                selectedPaymentSummary = "Cash on Delivery\nPhone: " + cashPhone;
            }
            // Populate the confirmation fields
            const addrElem = document.getElementById("confirmation-address");
            if (addrElem) addrElem.innerText = selectedAddressSummary;
            const payElem = document.getElementById("confirmation-payment");
            if (payElem) payElem.innerText = selectedPaymentSummary;
        }
        if (currentStep === 2) {
            currentStepIndex = 3; // confirmation step
        } else if (currentStep === 1) {
            nextButton.classList.add("btn-disabled");
            currentStepIndex = 2; // payment step
        }
    });
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
    function formatCardNumber(input) {
        input.value = input.value.replace(/\D/g, '').substring(0,16)
            .replace(/(.{4})/g, '$1 ').trim();
    }

    function formatExpiryDate(input) {
        let value = input.value.replace(/\D/g, '').substring(0,4);
        if (value.length >= 3) {
            value = value.substring(0,2) + '/' + value.substring(2);
        }
        input.value = value;
    }
</script>

<%@ include file="/general/userFooter.jsp" %>
</body>

</html>