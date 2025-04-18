<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/cart.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
    <link href="<%= request.getContextPath() %> https://cdn.jsdelivr.net/npm/raty-js@4.3.0/src/raty.min.css "
          rel="stylesheet">
</head>

<body class="bg-[#dadada]">
<%@ include file="/general/userHeader.jsp" %>

<!-- Product Detail / Description -->
<div class="bg-base-100 w-[70%] mt-10 mx-auto rounded-lg">
    <div class="flex flex-col lg:flex-row lg:item-stretch">

        <!--Left Panel-->
        <div class="w-full lg:w-2/5 p-10 space-y-4">
            <div class="card h-full bg-base-100 shadow-md p-4 space-y-4">
                <div id="horizontal-thumbnails" data-carousel class="relative w-full">
                    <div class="carousel">
                        <div class="carousel-body opacity-100">
                            <div class="carousel-slide">
                                <div class="flex size-full justify-center">
                                    <img src="https://halleyey.uk/uploads/B-AB2-1.png"
                                         class="object-contain w-auto h-[28rem] mx-auto"
                                         alt="product image"/>
                                </div>
                            </div>
                        </div>
                        <div
                                class="carousel-pagination bg-base-100 absolute bottom-0 end-0 start-0 z-1 h-16 flex justify-center gap-2 overflow-x-auto pt-2">

                            <img src="https://halleyey.uk/uploads/B-AB2-2.png"
                                 class="carousel-pagination-item carousel-active:opacity-100 grow object-cover opacity-30 h-20"
                                 alt="thumb"/>

                        </div>
                        <button type="button" class="carousel-prev">
                                <span class="mb-15" aria-hidden="true">
                                    <span
                                            class="size-9.5 bg-base-100 flex items-center justify-center rounded-full shadow-base-300/20 shadow-sm">
                                        <span
                                                class="icon-[tabler--chevron-left] size-5 cursor-pointer rtl:rotate-180"></span>
                                    </span>
                                </span>
                            <span class="sr-only">Previous</span>
                        </button>
                        <button type="button" class="carousel-next">
                            <span class="sr-only">Next</span>
                            <span class="mb-15" aria-hidden="true">
                                    <span
                                            class="size-9.5 bg-base-100 flex items-center justify-center rounded-full shadow-base-300/20 shadow-sm">
                                        <span
                                                class="icon-[tabler--chevron-right] size-5 cursor-pointer rtl:rotate-180"></span>
                                    </span>
                                </span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!--Right Panel-->
        <div class="w-full lg:w-3/5 p-10">
            <h1 class="text-3xl font-bold mt-3 mb-3">SAMSENG Earbuds or Smth Idk</h1>
            <span id="rating" class="font-bold text-[#4b4c5d]">4.9</span>
            <span>rating</span>
            <span> | </span>
            <span id="amount-sold" class="font-bold text-[#4b4c5d]">4593</span>
            <span>reviews</span>

            <div class="bg-base-200 justify-start py-3 ml-3 mt-5">
                <span id="price" class="text-3xl font-bold m-5">$999.00</span>
            </div>

            <!-- Specifications Selection -->
            <div class="w-full">
                <h2 class="text-2xl mt-3 mb-3">Select specifications: </h2>


                <label>Storage Capacity</label>
                <div class="flex w-[80%] items-start gap-3 mt-1 mb-4 ml-1 flex-wrap sm:flex-nowrap">
                    <label class="custom-option flex sm:w-1/2 flex-row items-start gap-3">
                        <input type="radio" name="capacity" class="radio hidden" checked/>
                        <span class="label-text w-full text-start text-[16px]">
                                256 GB
                            </span>
                    </label>
                    <label class="custom-option flex sm:w-1/2 flex-row items-start gap-3">
                        <input type="radio" name="capacity" class="radio hidden"/>
                        <span class="label-text w-full text-start text-[16px]">
                                512 GB
                            </span>
                    </label>
                    <label class="custom-option flex sm:w-1/2 flex-row items-start gap-3">
                        <input type="radio" name="capacity" class="radio hidden"/>
                        <span class="label-text w-full text-start text-[16px]">
                                1 TB
                            </span>
                    </label>
                </div>

                <label>Color</label>
                <div class="flex w-[80%] items-start gap-3 mt-1 mb-4 ml-1 flex-wrap sm:flex-nowrap">
                    <label class="custom-option flex sm:w-1/2 flex-row items-start gap-3">
                        <input type="radio" name="color" class="radio hidden" checked/>
                        <span class="label-text w-full text-start text-[16px]">
                                Titanium White
                            </span>
                    </label>
                    <label class="custom-option flex sm:w-1/2 flex-row items-start gap-3">
                        <input type="radio" name="color" class="radio hidden"/>
                        <span class="label-text w-full text-start text-[16px]">
                                Midnight Black
                            </span>
                    </label>
                    <label class="custom-option flex sm:w-1/2 flex-row items-start gap-3">
                        <input type="radio" name="color" class="radio hidden"/>
                        <span class="label-text w-full text-start text-[16px]">
                                Platinum Silver
                            </span>
                    </label>
                </div>
            </div>
            <label>Quantity</label>
            <div class="flex items-center px-1 py-2 gap-6">
                <div class="input quantity-button w-[30%] flex items-center">
                    <span id="decrement-button" class="icon-[tabler--minus] border-r-2 border-blue-300"></span>
                    <span id="quantity-number" class="text-[16px] mx-auto">01</span>
                    <span id="increment-button" class="icon-[tabler--plus] border-l-2 border-blue-300"></span>
                </div>

                <div>
                    <button id="add-to-cart" class="btn btn-primary rounded-lg">Add to Cart</button>
                </div>
            </div>

        </div>

    </div>

    <!-- Description -->
    <div class="divider">
        <h2 class="text-3xl mb-3">Description</h2>
    </div>
    <div class="w-full p-10 space-y-4">
        <p class="text-base-content/50 text-[18px]">
            "Design and Display:
            -Models and Sizes: The series includes the Galaxy S25 with a 6.2-inch display, the S25 Ultra with a
            6.7-inch display, and the S25 Ultra featuring a 6.9-inch screen. ​
            -Display Technology: Each model is equipped with a Dynamic AMOLED 2X screen, offering vibrant visuals
            and smooth scrolling experiences. ​

            Performance:
            -Processor: All models are powered by the Snapdragon 8 Elite chipset, delivering a 40% performance boost
            over previous generations. ​
            Battery Life: Optimized battery performance ensures extended usage, with fast and wireless charging
            options available across the series. ​

            Camera System:
            -Milkyway S36: Feature a multi-camera setup, including a 50 MP main camera, a 12 MP ultra-wide lens, and
            a 10 MP telephoto lens, complemented by a 12 MP front-facing camera. ​
            -Milkyway S36: Boasts a 200-megapixel main camera, enhanced ultra-wide and telephoto lenses, and
            advanced AI-driven features like Virtual Aperture for improved depth of field control. ​

            Artificial Intelligence Features:

            -AI Integration: The series introduces Galaxy AI, offering features such as Live Translation for
            real-time language interpretation and Nightography for capturing stunning low-light photos. ​
            -Enhanced User Experience: AI-driven functionalities like Circle to Search with Google and AI Select
            anticipate user needs, providing a more intuitive and personalized experience. ​"

        </p>
    </div>

</div>

<!-- Rating / Review -->
<div id="lower-container" class="bg-base-100 w-[70%] mt-10 mx-auto rounded-lg rounded-b-none">
    <div class="m-5 mb-0">
        <h1 class="text-3xl font-bold mt-3 pt-8 pb-1">Rating & Reviews</h1>
    </div>
    <div class="divider"></div>


    <!-- <div class="mx-10 pb-5">
        <form method="#">
        <textarea class="textarea textarea-xl" placeholder="Write a comment..." aria-label="Textarea"></textarea>
        <button type="submit" class="btn btn-primary rounded-lg mt-2">Submit</button>
        </form>
    </div> -->

    <div id="comment-section" class="mx-10 pb-5">
        <!-- Test comment -->
        <div id="comment" class="flex flex-col items-right gap-2 m-5">
            <div class="flex">
                <div class="w-14">
                    <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" class="rounded-full"
                         alt="avatar 1"/>
                </div>
                <div class="gap-3 mt-1 ml-4">
                    <p class="font-semibold text-[16px]">Guest</p>
                    <div class="flex flex-row user-rating size-5"></div>
                </div>
            </div>
            <p class="w-full text-[18px] ml-3 px-15">Fantastic product yes wow look at me i have so much money i can
                buy your fucking house</p>
            <div class="divider"></div>
        </div>
        <div id="comment" class="flex flex-col items-right gap-2 m-5">
            <div class="flex">
                <div class="w-14">
                    <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" class="rounded-full"
                         alt="avatar 1"/>
                </div>
                <div class="gap-3 mt-1 ml-4">
                    <p class="font-semibold text-[16px]">Guest</p>
                    <div class="flex flex-row user-rating size-5 user-rating2"></div>
                </div>
            </div>
            <p class="w-full text-[18px] ml-3 px-15">Fantastic product yes wow look at me i have so much money i can
                buy your fucking house</p>
            <div class="divider"></div>
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

<!-- Raty Initialize -->
<script src="<%= request.getContextPath() %> https://cdn.jsdelivr.net/npm/raty-js@4.3.0/build/raty.min.js"></script>

<!-- Raty Script -->
<script id="rating-control">
    document.addEventListener('DOMContentLoaded', function () {
        const ratingReadOnly = new Raty(document.querySelector('.user-rating'), {
            path: '../static/img',
            score: 4,
            readOnly: true
        })
        ratingReadOnly.init()
    })

    document.addEventListener('DOMContentLoaded', function () {
        const ratingReadOnly = new Raty(document.querySelector('.user-rating2'), {
            path: '../static/img',
            score: 3,
            readOnly: true
        })
        ratingReadOnly.init()
    })
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

</body>


</html>
