<%@ page import="com.samseng.web.models.Product" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.samseng.web.models.Variant" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<%
    Product productObj = (Product) request.getAttribute("product");
%>

<head>
    <title>Product </title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=productObj.getName()%>
    </title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
    <link href="<%= request.getContextPath() %> https://cdn.jsdelivr.net/npm/raty-js@4.3.0/src/raty.min.css "
          rel="stylesheet">
</head>

<% List<Comment> commentList = (List<Comment>) request.getAttribute("commentList"); %>
<body data-theme="light" class="bg-[#dadada]">
<%@ include file="/general/userHeader.jsp" %>

<!-- Product Detail / Description -->
<div data-theme="light" class="bg-base-100 w-[70%] mt-10 mx-auto rounded-lg">
    <div class="flex flex-col lg:flex-row lg:item-stretch">

        <!--Left Panel-->
        <div class="w-full lg:w-2/5 p-10 space-y-4">
            <div class="card bg-base-100 shadow-md p-4 space-y-4">
                <div id="horizontal-thumbnails" data-carousel class="relative w-full">
                    <div class="carousel">
                        <div class="carousel-body opacity-100">
                            <%
                                Set<String> imageSet = (Set<String>) request.getAttribute("imageSet");
                                for (String image : imageSet) {
                            %>
                            <div class="carousel-slide">
                                <div class="flex size-full justify-center">
                                    <img src="/uploads/<%= image %>"
                                         class="object-contain w-auto h-[28rem] mx-auto"
                                         alt="product image"/>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <div class="my-4 flex flex-col items-start gap-2">
                            <div class="carousel-pagination bg-base-100 absolute bottom-0 end-0 start-0 z-1 h-16 flex justify-center gap-2 overflow-x-auto pt-2">
                                <%
                                    for (String image : imageSet) {
                                %>
                                <img src="/uploads/<%= image %>"
                                     class="carousel-pagination-item carousel-active:opacity-100 grow object-cover opacity-30 h-20"
                                     alt="thumb"/>
                                <%
                                    }
                                %>
                            </div>
                            <button type="button" class="carousel-prev">
                          <span class="mb-15" aria-hidden="true">
                            <span class="size-9.5 bg-base-100 flex items-center justify-center rounded-full shadow-base-300/20 shadow-sm">
                              <span class="icon-[tabler--chevron-left] size-5 cursor-pointer rtl:rotate-180"></span>
                            </span>
                          </span>
                                <span class="sr-only">Previous</span>
                            </button>
                            <button type="button" class="carousel-next">
                                <span class="sr-only">Next</span>
                                <span class="mb-15" aria-hidden="true">
                            <span class="size-9.5 bg-base-100 flex items-center justify-center rounded-full shadow-base-300/20 shadow-sm">
                              <span class="icon-[tabler--chevron-right] size-5 cursor-pointer rtl:rotate-180"></span>
                            </span>
                          </span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Right Panel-->

        <div class="w-full lg:w-3/5 p-10">
            <%
                int totalRating = 0;
                int commentCount = 0;
                if (commentList != null) {
                    for (Comment c : commentList) {
                        totalRating += c.getRating();
                        commentCount++;
                    }
                }
                double averageRating = commentCount > 0 ? (double) totalRating / commentCount : 0.0;
            %>
            <h1 class="text-3xl font-bold mt-3 mb-3"><%=productObj.getName()%>
            </h1>
            <span id="rating" class="font-bold text-[#4b4c5d]"><%= String.format("%.1f", averageRating) %></span>
            <span>rating</span>
            <span> | </span>
            <span id="amount-sold" class="font-bold text-[#4b4c5d]"><%= commentCount%></span>
            <span>reviews</span>

            <%
                List<Variant> variantList = (List<Variant>) request.getAttribute("variantList");
                Variant firstVariant = (variantList != null && !variantList.isEmpty()) ? variantList.get(0) : null;
            %>

            <div class="bg-base-200 justify-start py-3 ml-3 mt-5">
                <span id="price"
                      class="text-3xl font-bold m-5"> RM<%= firstVariant != null ? String.format("%.2f", firstVariant.getPrice()) : "N/A" %></span>
            </div>

            <!-- Specifications Selection -->
            <div class="w-full">
                <h2 class="text-2xl mt-3 mb-3">Select specifications: </h2>
                <%
                    Map<String, Set<String>> attributeValuesMap = (Map<String, Set<String>>) request.getAttribute("attributeValuesMap");
                    for (Map.Entry<String, Set<String>> entry : attributeValuesMap.entrySet()) {
                        String attrName = entry.getKey();
                        Set<String> values = entry.getValue();
                %>
                <label class="block font-semibold mb-2"><%= attrName %>
                </label>
                <div class="flex w-[80%] items-start gap-3 mt-1 mb-4 ml-1 flex-wrap sm:flex-nowrap">
                    <%
                        int index = 0;
                        for (String value : values) {
                            index++;
                    %>
                    <label class="custom-option flex sm:w-1/2 flex-row items-start gap-3">
                        <input type="radio" name="<%= attrName %>" value="<%= value %>"
                               class="radio hidden" <%= index == 1 ? "checked" : "" %>/>
                        <span class="label-text w-full text-start text-[16px]"><%= value %></span>
                    </label>
                    <% } %>
                </div>
                <% } %>
            </div>
            <label>Quantity</label>
            <div class="flex items-center px-1 py-2 gap-6">
                <div class="input quantity-button w-[30%] flex items-center">
                    <span id="decrement-button" class="icon-[tabler--minus] border-r-2 border-blue-300"></span>
                    <span id="quantity-number" class="text-[16px] mx-auto">01</span>
                    <span id="increment-button" class="icon-[tabler--plus] border-l-2 border-blue-300"></span>
                </div>
                <form action="<%= request.getContextPath() %>/cart" method="post" class="flex items-center gap-6">
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="variantId" id="selected-variant-id"/>
                    <input type="hidden" name="qty" id="quantity-input" value="1"/>
                    <button type="submit" class="btn btn-primary rounded-lg">Add to Cart</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Description -->
    <div class="divider">
        <h2 class="text-3xl mb-3">Description</h2>
    </div>
    <div class="w-full p-10 space-y-4">
        <p class="text-base-content/50 text-[18px]">
            <%= productObj.getDesc() != null ? productObj.getDesc().replaceAll("\\n", "<br>") : "" %>
        </p>
    </div>

</div>

<!-- Rating / Review -->
<div data-theme="light" id="lower-container" class="bg-base-100 w-[70%] mt-10 mx-auto rounded-lg rounded-b-none">
    <div class="m-5 mb-0">
        <h1 class="text-3xl font-bold mt-3 pt-8 pb-1">Rating & Reviews</h1>
    </div>
    <div class="divider"></div>

    <!-- Comment Writing Section -->
    <%--    <div class="mx-10 pb-5">--%>
    <%--        <form method="#">--%>
    <%--            <textarea class="textarea textarea-xl" placeholder="Write a comment..." aria-label="Textarea"></textarea>--%>
    <%--            <div class="flex flex-row gap-10 w-[50%] justify-end">--%>
    <%--                <div id="rating-input" class="flex flex-col items-start justify-start">--%>
    <%--                    <div class="flex mt-2" id="raty-with-hints" data-score="5"></div>--%>
    <%--                    <div class="h-6" data-hint></div>--%>
    <%--                </div>--%>
    <%--                <button type="submit" class="w-auto btn btn-primary rounded-lg mt-2 flex justify-end">Submit--%>
    <%--                </button>--%>
    <%--            </div>--%>
    <%--        </form>--%>
    <%--    </div>--%>


    <div id="comment-section" class="mx-10 pb-5">
        <!-- Test comment -->

        <% if (commentList != null) {
            for (Comment c : commentList) {
        %>
        <div id="comment" class="flex flex-col items-right gap-2 m-5">
            <div class="flex">
                <div class="w-14">
                    <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" class="rounded-full"
                         alt="avatar 1"/>
                </div>
                <div class="gap-3 mt-1 ml-4">
                    <p class="font-semibold text-[18px]"><%=c.getUser().getUsername()%>
                    </p>
                    <div class="user-rating flex" data-score="<%= c.getRating() %>"></div>
                    <p class="w-full text-[18px] mt-3"><%= c.getMessage()%>
                    </p>
                    <% if (c.getReply() != null) { %>
                    <div id="reply" class="mt-5 ml-5">
                        <p class="font-bold text-lg py-2">Reply By Staff Personnel</p>
                        <p class="text-lg"><%= c.getReply().getMessage()%>
                        </p>
                    </div>
                    <% } %>
                </div>
            </div>

            <div class="divider"></div>
        </div>
        <% }
        } %>
    </div>
</div>

<%@include file="/general/userFooter.jsp" %>

<!-- Raty Initialize -->
<script src="<%= request.getContextPath() %> https://cdn.jsdelivr.net/npm/raty-js@4.3.0/build/raty.min.js"></script>


<!-- Comment Raty -->
<script id="rating-control">
    document.addEventListener('DOMContentLoaded', function () {
        const hintTarget = document.querySelector('#raty-with-hints');
        if (hintTarget) {
            new Raty(hintTarget, {
                path: '../static/img',
                hints: ['Terrible 😔', 'Unsatisfactory 😑', 'Average 😊', 'Nice 😁', 'Splendid 😍'],
                target: '[data-hint]',
                targetFormat: 'Your experience was: {score}'
            }).init();
        }

        document.querySelectorAll('.user-rating').forEach(function (el) {
            const score = parseInt(el.dataset.score);
            if (!isNaN(score)) {
                new Raty(el, {
                    path: '../static/img',
                    score: score,
                    readOnly: true
                }).init();
            }
        });
    });
</script>


<!-- Quantity Button -->
<script>
    const plus = document.querySelector("#increment-button"),
        minus = document.querySelector("#decrement-button"),
        quantity = document.querySelector("#quantity-number");


    let count = 1;
    plus.addEventListener("click", () => {
        count++;
        count = (count < 10) ? "0" + count : count;
        quantity.innerHTML = count;
    });

    minus.addEventListener("click", () => {
        if (count <= 1) return;
        count--;
        count = (count < 10) ? "0" + count : count;
        quantity.innerHTML = count;
    });
</script>

<script>
    const variants = [
        <%
            Map<String, Map<String, String>> variantAttrMap = (Map<String, Map<String, String>>) request.getAttribute("variantAttrMap");
            for (Variant v : variantList) {
                Map<String, String> attrMap = variantAttrMap.get(v.getVariantId());
        %>
        {
            id: "<%= v.getVariantId() %>",
            name: "<%= v.getVariantName() %>",
            price: <%= String.format("%.2f", v.getPrice()) %>,
            attributes: {
                <%
                    for (Map.Entry<String, String> entry : attrMap.entrySet()) {
                %>
                "<%= entry.getKey() %>": "<%= entry.getValue() %>",
                <%
                    }
                %>
            },
            availability: <%= v.isAvailability() %>
        },
        <% } %>
    ];
</script>

<script>
    function updatePriceDisplay(matchingVariant) {
        document.getElementById('price').innerText = "RM" + matchingVariant.price.toFixed(2);

    }

    function getSelectedAttributes() {
        const selected = {};
        document.querySelectorAll('input[type="radio"]:checked').forEach(input => {
            selected[input.name] = input.value;
        });
        return selected;
    }

    function findMatchingVariant(selectedAttrs) {
        return variants.find(v => {
            return Object.keys(selectedAttrs).every(attr =>
                v.attributes[attr] === selectedAttrs[attr]
            );
        });
    }

    document.querySelectorAll('input[type="radio"]').forEach(radio => {
        radio.addEventListener('change', () => {
            const selectedAttrs = getSelectedAttributes();
            const matched = findMatchingVariant(selectedAttrs);
            if (matched) updatePriceDisplay(matched);
        });
    });
</script>

<script>
    function updateSelectedVariantId() {
        const selectedAttrs = getSelectedAttributes();
        const matched = findMatchingVariant(selectedAttrs);
        const addToCartBtn = document.querySelector('button[type="submit"]');
        let warning = document.getElementById('variant-warning');

        if (!warning) {
            warning = document.createElement('p');
            warning.id = 'variant-warning';
            warning.className = 'text-red-500 text-sm mt-2';
            addToCartBtn.parentNode.appendChild(warning);
        }

        if (matched) {
            document.getElementById('selected-variant-id').value = matched.id;

            if (!matched.availability) {
                addToCartBtn.disabled = true;
                warning.textContent = "This variant is not available.";
            } else {
                addToCartBtn.disabled = false;
                warning.textContent = "";
            }
        } else {
            addToCartBtn.disabled = true;
            warning.textContent = "This variant does not exist.";
        }
    }

    document.querySelectorAll('input[type="radio"]').forEach(radio => {
        radio.addEventListener('change', () => {
            updateSelectedVariantId();
            const selectedAttrs = getSelectedAttributes();
            const matched = findMatchingVariant(selectedAttrs);
            if (matched) updatePriceDisplay(matched);
        });
    });

    // Update quantity field on quantity button click
    document.getElementById('increment-button').addEventListener('click', () => {
        const q = parseInt(document.getElementById('quantity-number').textContent, 10);
        document.getElementById('quantity-input').value = q;
    });
    document.getElementById('decrement-button').addEventListener('click', () => {
        const q = parseInt(document.getElementById('quantity-number').textContent, 10);
        document.getElementById('quantity-input').value = q;
    });

    // Initial check on page load
    updateSelectedVariantId();
</script>
</body>


</html>

