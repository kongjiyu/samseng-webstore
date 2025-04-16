<jsp:useBean id="product" scope="session" class="com.samseng.web.models.Product"/>
<%@page import="com.samseng.web.models.*" %>
<%@page import="java.util.Set" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>
<body data-theme="light">
<!--Header-->

<div class="container mx-auto p-6 py-16">
    <form method="post" action="<%= request.getContextPath() %>/admin/productDetail?action=update">
        <div class="flex flex-col lg:flex-row lg:items-stretch bg-base-100 border rounded-lg shadow divide-y lg:divide-y-0 lg:divide-x divide-base-300">
            <!-- Left Panel: Product Information -->
            <div class="w-full lg:w-1/3 p-10 space-y-4">
                <h2 class="text-2xl font-bold">Product Information</h2>
                <div class="card bg-base-100 shadow-md p-4 space-y-4">
                    <div id="horizontal-thumbnails" data-carousel class="relative w-full">
                        <div class="carousel">
                            <div class="carousel-body h-72 opacity-100">
                                <%
                                    Set<String> imageSet = (Set<String>) request.getAttribute("imageSet");
                                    for (String image : imageSet) {
                                %>
                                <div class="carousel-slide">
                                    <div class="flex size-full justify-center">
                                        <img src="/uploads/<%= image %>" class="object-contain w-64 h-64 mx-auto" alt="product image"/>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <div class="carousel-pagination bg-base-100 absolute bottom-0 end-0 start-0 z-1 h-16 flex justify-center gap-2 overflow-x-auto pt-2">
                                <%
                                    for (String image : imageSet) {
                                %>
                                <img src="/uploads/<%= image %>"
                                     class="carousel-pagination-item carousel-active:opacity-100 grow object-cover opacity-30 w-12 h-12"
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
                    <div>
                        <label class="block font-semibold">Product ID:</label>
                        <input type="text" name="productId" class="input input-bordered w-full"
                               value="<%= ((Product) request.getAttribute("product")).getId() %>" disabled>
                    </div>
                    <div>
                        <label class="block font-semibold">Product Name: </label>
                        <input type="text" name="productName" class="input input-bordered w-full"
                               value="<%= ((Product) request.getAttribute("product")).getName() %>">
                    </div>
                    <div>
                        <label class="block font-semibold">Category:</label>
                        <input type="text" name="productCategory" class="input input-bordered w-full"
                               value="<%= ((Product) request.getAttribute("product")).getCategory() %>">
                    </div>
                    <div>
                        <label class="block font-semibold">Description:</label>
                        <textarea name="productDesc" class="textarea resize-y textarea-bordered w-full"
                                  rows="20"><%= ((Product) request.getAttribute("product")).getDesc() %></textarea>
                    </div>
                </div>
            </div>


        <!-- Right Panel: Product Variants -->
        <div class="w-full lg:w-2/3 p-10 space-y-4">
            <h2 class="text-2xl font-bold">Product Variants</h2>
            <div class="flex justify-end mb-4">
                <button class="btn btn-info btn-sm">
                    <span class="icon-[tabler--plus] mr-1"></span>
                    Add Variant
                </button>
            </div>
            <div class="overflow-x-auto">
                <table class="table table-zebra w-full">
                    <thead>
                    <tr>
                        <th class="w-24">VARIANT ID</th>
                        <th class="w-60">NAME</th>
                        <th>COLOR</th>
                        <th>STORAGE</th>
                        <th>PRICE</th>
                        <th>ACTION</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><input type="text" class="input input-bordered input-sm" value="V001" disabled></td>
                        <td><input type="text" class="input input-bordered input-sm" value="Galaxy Z Flip - Graphite"></td>
                        <td><input type="text" class="input input-bordered input-sm" value="Graphite"></td>
                        <td><input type="text" class="input input-bordered input-sm" value="256GB"></td>
                        <td><input type="text" class="input input-bordered input-sm" value="$999"></td>
                        <td>
                            <button class="btn btn-circle btn-text btn-sm" aria-label="Edit">
                                <span class="icon-[tabler--pencil] size-5"></span>
                            </button>
                            <button class="btn btn-circle btn-text btn-sm" aria-label="Delete">
                                <span class="icon-[tabler--trash] size-5"></span>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="text" class="input input-bordered input-sm" value="V002" disabled></td>
                        <td><input type="text" class="input input-bordered input-sm" value="Galaxy Z Flip - Lavender"></td>
                        <td><input type="text" class="input input-bordered input-sm" value="Lavender"></td>
                        <td><input type="text" class="input input-bordered input-sm" value="512GB"></td>
                        <td><input type="text" class="input input-bordered input-sm" value="$1199"></td>
                        <td>
                            <button class="btn btn-circle btn-text btn-sm" aria-label="Edit">
                                <span class="icon-[tabler--pencil] size-5"></span>
                            </button>
                            <button class="btn btn-circle btn-text btn-sm" aria-label="Delete">
                                <span class="icon-[tabler--trash] size-5"></span>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="flex justify-end mt-6">
                    <button type="submit" class="btn btn-info btn-sm">
                        <span class="icon-[tabler--device-floppy] mr-1"></span>
                        Save
                    </button>
                </div>
            </div>
        </div>
        </div>
    </form>
</div>
</body>
</html>