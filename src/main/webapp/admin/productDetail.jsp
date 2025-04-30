<jsp:useBean id="product" scope="session" class="com.samseng.web.models.Product"/>
<%@page import="com.samseng.web.models.*" %>
<%@page import="java.util.Set" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
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
<%@ include file="/general/adminHeader.jsp" %>

<div class="container mx-auto p-6 py-16">
    <div class="mb-5 flex flex-col lg:flex-row lg:items-stretch bg-base-100 border rounded-lg shadow divide-y lg:divide-y-0 lg:divide-x divide-base-300">
        <!-- Left Panel: Product Information -->
        <div class="w-full lg:w-1/3 p-10 space-y-4">
            <%
                Product productObj = (Product) request.getAttribute("product");
            %>
            <%
                Account profile = (Account) session.getAttribute("profile");
            %>
            <h2 class="text-2xl font-bold">Product Information</h2>
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
                                <img src="<%= request.getContextPath() %>/uploads/<%= image %>"
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
                    <% if (productObj.getId() != null) { %>
                    <form method="post" action="${pageContext.request.contextPath}/admin/product"
                          enctype="multipart/form-data">
                        <input type="hidden" name="action" value="uploadImage">
                        <input type="hidden" name="productId" value="${product.id}"/>
                        <div class="my-5">
                            <label class="label-text" for="fileInputHelperText"> Pick a file </label>
                            <input type="file" class="input" id="fileInputHelperText" name="imageFile"
                                   accept="image/png"/>
                            <span class="helper-text">Only PNG file support</span>
                        </div>
                        <button type="submit" class="btn btn-outline btn-info w-full max-w-xs">
                            Upload Product Image
                        </button>
                    </form>
                    <% } else { %>
                    <p class="text-sm text-warning">Please save the product before uploading images.</p>
                    <% } %>
                </div>
                <form method="post" action="<%= request.getContextPath() %>/admin/product" id="productForm">
                    <div>
                        <label class="block font-semibold">Product ID:</label>
                        <input type="text" name="productId" class="input input-bordered w-full"
                               value="<%= productObj.getId() != null ? productObj.getId() : "" %>" <%= productObj.getId() != null ? "disabled" : ""%> >
                        <input type="hidden" name="productId"
                               value="<%= productObj.getId() != null ? productObj.getId() : "" %>" <%= productObj.getId() != null ? "" : "disabled"%> />
                    </div>
                    <div>
                        <label class="block font-semibold">Product Name: </label>
                        <input type="text" name="productName" class="input input-bordered w-full product-field"
                               value="<%= productObj.getName() != null ? productObj.getName() : "" %>">
                    </div>
                    <div>
                        <label class="block font-semibold">Category:</label>
                        <input type="text" name="productCategory" class="input input-bordered w-full product-field"
                               value="<%= productObj.getCategory() != null ? productObj.getCategory() : "" %>">
                    </div>
                    <div>
                        <label class="block font-semibold">Description:</label>
                        <textarea name="productDesc" class="textarea resize-y textarea-bordered w-full product-field"
                                  rows="20"><%= productObj.getDesc() != null ? productObj.getDesc() : "" %></textarea>
                    </div>

                    <div class="flex justify-end mt-4 gap-3">
                        <% if (profile.getRole()== Account.Role.ADMIN){%>
                        <button class="btn btn-error btn-sm"
                                type="button"
                                name="action"
                                id="deleteProductBtn"
                                <%= (productObj.getId() == null) ? "disabled" : "" %>
                                data-overlay="#delete-confirm-modal">
                            <span class="icon-[tabler--trash] mr-1"></span>
                            Delete
                        </button>
                      <% } %>
                        <button class="btn btn-info btn-sm" type="submit" name="action" id="saveProductBtn" disabled
                                value="<%= productObj.getId() != null ? "update" : "save" %>">
                            <span class="icon-[tabler--device-floppy] mr-1"></span>
                            Save
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Right Panel: Product Variants -->
        <div class="w-full lg:w-2/3 p-10 space-y-4">
            <form method="post" action="<%= request.getContextPath() %>/admin/product" id="attributeForm">
                <input type="hidden" name="action" value="saveAttributeValues">
                <input type="hidden" name="productId" value="<%= productObj.getId() %>">
                <h2 class="text-2xl font-bold mb-2">Attribute</h2>
                <div class="flex justify-end">
                    <button type="button"
                            class="btn btn-info btn-sm"
                            aria-haspopup="dialog"
                            aria-expanded="false"
                            aria-controls="add-attribute-modal"
                            data-overlay="#add-attribute-modal"
                            <%= productObj.getId() == null ? "disabled" : "" %>
                    >
                        <span class="icon-[tabler--plus] mr-1"></span>
                        Add Attribute
                    </button>
                </div>
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <%
                        Map<String, Set<String>> attributeValuesMap = (Map<String, Set<String>>) request.getAttribute("attributeValuesMap");
                        for (Map.Entry<String, Set<String>> entry : attributeValuesMap.entrySet()) {
                            String attrName = entry.getKey();
                            Set<String> values = entry.getValue();
                    %>
                    <div>
                        <label class="font-semibold block mb-2"><%= attrName %>
                        </label>
                        <input type="hidden" name="attributeList" value="<%= attrName %>"/>
                        <div class="flex flex-wrap gap-2">
                            <%
                                for (String value : values) {
                            %>
                            <input type="text" class="input input-bordered input-sm attribute-field"
                                   name="attr-<%= attrName %>" value="<%= value %>" disabled/>
                            <input type="hidden" name="attr-<%= attrName %>" value="<%= value %>"/>
                            <%
                                }
                            %>
                            <button type="button" class="btn btn-outline btn-sm mt-2"
                                    onclick="addValue(this, '<%=attrName%>')">Add Value
                            </button>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <div class="flex justify-end mt-4">
                    <button class="btn btn-info btn-sm" type="submit" id="saveAttributeValueBtn" disabled>
                        <span class="icon-[tabler--device-floppy] mr-1"></span>
                        Save attributes
                    </button>
                </div>
            </form>
            <form method="post" action="<%= request.getContextPath() %>/admin/product" id="variantForm">
                <input type="hidden" name="action" value="saveVariant">
                <input type="hidden" name="productId" value="<%= productObj.getId() %>">
                <h2 class="text-2xl font-bold mb-2">Variant</h2>
                <div class="overflow-x-auto">
                    <table class="table table-zebra w-full">
                        <thead>
                        <tr>
                            <th class="w-48">NAME</th>
                            <%
                                List<Attribute> attributeList = ((List<Attribute>) request.getAttribute("attributeList"));
                                for (Attribute attribute : attributeList) {
                            %>
                            <th><%=attribute.getName()%>
                            </th>
                            <%
                                }
                            %>
                            <th>PRICE (RM)</th>
                            <th>AVAILABILITY</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Variant> variantList = ((List<Variant>) request.getAttribute("variantList"));
                            Map<String, Map<String, String>> variantAttrMap = (Map<String, Map<String, String>>) request.getAttribute("variantAttrMap");
                            List<Attribute> dynamicAttributes = (List<Attribute>) request.getAttribute("attributeList");

                            for (Variant v : variantList) {
                                Map<String, String> attributes = variantAttrMap.getOrDefault(v.getVariantId(), new HashMap<>());
                        %>
                        <tr>
                            <td>
                                <input type="hidden" name="variantId" value="<%= v.getVariantId() %>">
                                <input type="text" name="variantName"
                                       class="input input-bordered input-sm variant-field w-48"
                                       value="<%= v.getVariantName() %>"
                                >
                            </td>
                            <% for (Attribute attr : dynamicAttributes) { %>
                            <td>
                                <input type="text" name="variantAttr_<%= attr.getId() %>"
                                       class="input input-bordered input-sm variant-field"
                                       value="<%= attributes.getOrDefault(attr.getName(), "") %>"
                                       disabled
                                >
                            </td>
                            <% } %>
                            <td>
                                <input type="text" name="variantPrice"
                                       class="input input-bordered input-sm variant-field"
                                       value="<%= v.getPrice() %>">
                            </td>
                            <td>
                                <div class="flex items-center gap-1">
                                    <input type="checkbox" name="variantAvailability"
                                           class="switch switch-info variant-field"
                                           value="<%= v.getVariantId() %>"
                                        <%= v.isAvailability() ? "checked" : "" %>>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                    <div class="flex justify-end mt-6">
                        <button type="submit" class="btn btn-info btn-sm" id="saveVariantBtn" disabled>
                            <span class="icon-[tabler--device-floppy] mr-1"></span>
                            Save
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>


    <%
        List<Comment> commentList = (List<Comment>) request.getAttribute("commentsList");
        if (commentList != null && !commentList.isEmpty()) {
    %>
    <div class="my-5 flex flex-row  bg-base-100 border rounded-lg shadow divide-y divide-base-300">
        <div class="w-full p-10">

            <h2 class="text-2xl font-bold">Comments</h2>
            <% for (Comment comment : commentList) {
                if (comment.getReply() == null) {
            %>
            <!-- existing comment rendering here -->
            <div id="comment" class="flex flex-col items-right gap-2 m-5">
                <div class="flex">
                    <div class="w-14">
                        <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" class="rounded-full"
                             alt="avatar 1"/>
                    </div>

                    <div class="gap-3 mt-1 ml-4">
                        <p class="font-semibold text-[18px]"><%=comment.getUser().getUsername()%>
                        </p>
                        <div class="user-rating flex" data-score="<%= comment.getRating() %>"></div>
                        <p class="w-full text-[18px] mt-3"><%= comment.getMessage()%>
                        </p>

                        <% String modalId = "reply-modal-" + comment.getId(); %>

                        <div class="mt-5 ml-5">
                            <button class="flex flex-row gap-3"
                                    aria-haspopup="dialog"
                                    aria-expanded="false"
                                    aria-controls="<%= modalId %>"
                                    data-overlay="#<%= modalId %>">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round"
                                     class="icon icon-tabler icons-tabler-outline icon-tabler-corner-down-left-double">
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                    <path d="M19 5v6a3 3 0 0 1 -3 3h-7"/>
                                    <path d="M13 10l-4 4l4 4m-5 -8l-4 4l4 4"/>
                                </svg>
                                <p class="text-gray-950">Reply to Comment...</p>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="divider"></div>
            </div>
            <div id="<%= modalId %>"
                 class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden"
                 role="dialog" tabindex="-1">
                <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300">
                    <div class="modal-content">
                        <%--Reply Comment Form--%>
                        <form method="post" action="<%= request.getContextPath() %>/admin/product?action=replyComment">
                            <input type="hidden" name="commentId" value="<%= comment.getId() %>"/>
                            <input type="hidden" name="productId" value="<%= productObj.getId() %>"/>
                            <div class="modal-header m-2">
                                <h3 class="modal-title">Admin Reply</h3>
                                <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3"
                                        aria-label="Close" data-overlay="#<%= modalId %>">
                                    <span class="icon-[tabler--x] size-4"></span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="mx-2 pb-2">
                                                    <textarea class="textarea textarea-xl"
                                                              placeholder="Write a reply..."
                                                              aria-label="Textarea" name="text"></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-soft btn-secondary"
                                        data-overlay="#<%= modalId %>">Close
                                </button>
                                <button type="submit" class="btn btn-primary">Save changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
    <% } %>

</div>


<div id="add-attribute-modal"
     class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden" role="dialog"
     tabindex="-1">
    <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Add Attribute</h3>
                <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close"
                        data-overlay="#add-attribute-modal" <%= productObj.getId() == null ? "disabled" : "" %>
                >
                    <span class="icon-[tabler--x] size-4"></span>
                </button>
            </div>
            <form method="post" action="<%= request.getContextPath() %>/admin/product" id="addAttributeForm">
                <input type="hidden" name="action" value="saveAttribute">
                <input type="hidden" name="productId" value="<%= productObj.getId() %>">
                <div class="modal-body space-y-4">
                    <div>
                        <label for="attributeId" class="block font-medium mb-1">Select Attribute:</label>
                        <select id="attributeId" name="attributeId" class="select select-bordered w-full" required>
                            <option value="">Select an attribute</option>
                            <%
                                List<Attribute> allAttributes = (List<Attribute>) request.getAttribute("allAttributes");
                                if (allAttributes != null) {
                                    for (Attribute attr : allAttributes) {
                                        // Check if this attribute is already added to the product
                                        boolean isAlreadyAdded = false;
                                        if (attributeList != null) {
                                            for (Attribute existingAttr : attributeList) {
                                                if (existingAttr.getId().equals(attr.getId())) {
                                                    isAlreadyAdded = true;
                                                    break;
                                                }
                                            }
                                        }
                                        // Only show attributes that haven't been added yet
                                        if (!isAlreadyAdded) {
                            %>
                            <option value="<%= attr.getId() %>"><%= attr.getName() %>
                            </option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div>
                        <label for="attributeValue" class="block font-medium mb-1">Initial Value:</label>
                        <input type="text" id="attributeValue" name="attributeValue"
                               class="input input-bordered w-full"
                               placeholder="Enter initial value"
                               required>
                        <p class="text-sm text-gray-500 mt-1">
                            This value will be used to create the first variant
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-soft btn-secondary" data-overlay="#add-attribute-modal">
                        Cancel
                    </button>
                    <button type="submit" class="btn btn-info" disabled id="addAttributeBtn">Add Attribute</button>
                </div>
            </form>
        </div>
    </div>
</div>


<div id="delete-confirm-modal"
     class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden" role="dialog"
     tabindex="-1">
    <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300 max-w-md w-full">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Confirm Product Deletion</h3>
                <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close"
                        data-overlay="#change-password-modal">
                    <span class="icon-[tabler--x] size-4"></span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete product <%= productObj.getId()%>? This action is permanent.
            </div>
            <div class="modal-footer">
                <form method="post" action="${pageContext.request.contextPath}/admin/product">
                    <input type="hidden" name="action" value="deleteProduct"/>
                    <input type="hidden" name="productId" value="<%= productObj.getId() %>"/>
                    <button type="submit" class="btn btn-danger">Yes, Delete</button>
                    <button type="button" class="btn btn-secondary" data-overlay="#delete-confirm-modal">Cancel</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="/general/userFooter.jsp"%>

<script>
    function addValue(button, attrName) {
        const container = button.parentElement;
        attrName = "attr-" + attrName;

        const input = document.createElement('input');
        input.type = 'text';
        input.placeholder = 'e.g. New Value';
        input.className = 'input input-bordered input-sm attribute-field';
        input.name = attrName;

        container.insertBefore(input, button);
        document.getElementById('saveAttributeValueBtn').disabled = false;
    }

    // Enable/disable Add Attribute button based on selection
    document.getElementById('attributeId').addEventListener('change', function () {
        document.getElementById('addAttributeBtn').disabled = !this.value;
    });

    // Form validation for add attribute modal
    const attributeForm = {
        form: document.getElementById('addAttributeForm'),
        attributeSelect: document.getElementById('attributeId'),
        valueInput: document.getElementById('attributeValue'),
        submitButton: document.getElementById('addAttributeBtn')
    };

    function validateAttributeForm() {
        const isValid = attributeForm.attributeSelect.value &&
            attributeForm.valueInput.value.trim().length > 0;
        attributeForm.submitButton.disabled = !isValid;
    }

    attributeForm.attributeSelect.addEventListener('change', validateAttributeForm);
    attributeForm.valueInput.addEventListener('input', validateAttributeForm);

    // Track original values for comparison
    const originalValues = {
        product: new Map(),
        attribute: new Map(),
        variant: new Map()
    };

    // Store original values when page loads
    document.addEventListener('DOMContentLoaded', function () {
        // Store product form values
        document.querySelectorAll('.product-field').forEach(field => {
            originalValues.product.set(field.name, field.value);
        });

        // Store attribute form values
        document.querySelectorAll('.attribute-field').forEach(field => {
            originalValues.attribute.set(field.name, field.value);
        });

        // Store variant form values
        document.querySelectorAll('.variant-field').forEach(field => {
            const key = field.type === 'checkbox' ? field.value : field.name;
            const value = field.type === 'checkbox' ? field.checked : field.value;
            originalValues.variant.set(key, value);
        });
    });

    // Check for changes in product form
    document.querySelectorAll('.product-field').forEach(field => {
        field.addEventListener('input', function () {
            const hasChanges = Array.from(document.querySelectorAll('.product-field')).some(field => {
                return field.value !== originalValues.product.get(field.name);
            });
            document.getElementById('saveProductBtn').disabled = !hasChanges;
        });
    });


    // Check for changes in attribute form
    document.querySelectorAll('.attribute-field').forEach(field => {
        field.addEventListener('input', function () {
            const hasChanges = Array.from(document.querySelectorAll('.attribute-field')).some(field => {
                return field.value !== originalValues.attribute.get(field.name);
            });
            document.getElementById('saveAttributeValueBtn').disabled = !hasChanges;
        });
    });

    // Check for changes in variant form
    document.querySelectorAll('.variant-field').forEach(field => {
        field.addEventListener('input', function () {
            const hasChanges = Array.from(document.querySelectorAll('.variant-field')).some(field => {
                const key = field.type === 'checkbox' ? field.value : field.name;
                const currentValue = field.type === 'checkbox' ? field.checked : field.value;
                return currentValue !== originalValues.variant.get(key);
            });
            document.getElementById('saveVariantBtn').disabled = !hasChanges;
        });

        if (field.type === 'checkbox') {
            field.addEventListener('change', function () {
                const hasChanges = Array.from(document.querySelectorAll('.variant-field')).some(field => {
                    const key = field.type === 'checkbox' ? field.value : field.name;
                    const currentValue = field.type === 'checkbox' ? field.checked : field.value;
                    return currentValue !== originalValues.variant.get(key);
                });
                document.getElementById('saveVariantBtn').disabled = !hasChanges;
            });
        }
    });

    //Rating
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
</body>
</html>