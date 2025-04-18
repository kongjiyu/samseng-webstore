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
    <div class="flex flex-col lg:flex-row lg:items-stretch bg-base-100 border rounded-lg shadow divide-y lg:divide-y-0 lg:divide-x divide-base-300">
        <!-- Left Panel: Product Information -->

        <div class="w-full lg:w-1/3 p-10 space-y-4">
            <%
                Product productObj = (Product) request.getAttribute("product");
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
                    <div class="flex justify-end mt-4">
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
                    <button type="button" class="btn btn-info btn-sm" aria-haspopup="dialog" aria-expanded="false"
                            aria-controls="add-attribute-modal" data-overlay="#add-attribute-modal"><span
                            class="icon-[tabler--plus] mr-1"></span>
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
                        <input type="hidden" name="attributeList" value="<%= attrName %>" />
                        <div class="flex flex-wrap gap-2">
                            <% 
                                for (String value : values) {
                            %>
                            <input type="text" class="input input-bordered input-sm attribute-field" 
                                   name="attr-<%= attrName %>" value="<%= value %>"/>
                            <% 
                                }
                            %>
                            <button type="button" class="btn btn-outline btn-sm mt-2" onclick="addValue(this, '<%=attrName%>')">Add Value
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
                            <%
                                List<Attribute> attributeList = ((List<Attribute>) request.getAttribute("attributeList"));
                                for (Attribute attribute : attributeList) {
                            %>
                            <th><%=attribute.getName()%>
                            </th>
                            <%
                                }
                            %>
                            <th>PRICE</th>
                            <th>AVAILABILITY</th>
                            <th>ACTION</th>
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
                                <input type="text" class="input input-bordered input-sm" value="<%= v.getVariantId() %>"
                                       disabled>
                            </td>
                            <td>
                                <input type="text" name="variantName"
                                       class="input input-bordered input-sm variant-field"
                                       value="<%= v.getVariantName() %>">
                            </td>
                            <% for (Attribute attr : dynamicAttributes) { %>
                            <td>
                                <input type="text" name="variantAttr_<%= attr.getId() %>"
                                       class="input input-bordered input-sm variant-field"
                                       value="<%= attributes.getOrDefault(attr.getName(), "") %>">
                            </td>
                            <% } %>
                            <td>
                                <input type="text" name="variantPrice"
                                       class="input input-bordered input-sm variant-field"
                                       value="RM<%= v.getPrice() %>">
                            </td>
                            <td>
                                <div class="flex items-center gap-1">
                                    <input type="checkbox" name="variantAvailability"
                                           class="switch switch-info variant-field"
                                           value="<%= v.getVariantId() %>"
                                        <%= v.isAvailability() ? "checked" : "" %>>
                                </div>
                            </td>
                            <td>
                                <button class="btn btn-circle btn-text btn-sm" aria-label="Edit">
                                    <span class="icon-[tabler--pencil] size-5"></span>
                                </button>
                                <button class="btn btn-circle btn-text btn-sm" aria-label="Delete">
                                    <span class="icon-[tabler--trash] size-5"></span>
                                </button>
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
</div>
<div id="add-attribute-modal"
     class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden" role="dialog"
     tabindex="-1">
    <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Add Attribute</h3>
                <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close"
                        data-overlay="#add-attribute-modal">
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

<script>
    function addValue(button, attrName) {
        const container = button.parentElement;
        attrName = "attr-" + attrName;

        const input = document.createElement('input');
        input.type = 'text';
        input.placeholder = 'e.g. New Value';
        input.className = 'input input-bordered input-sm attribute-field';
        input.name = attrName ;
        
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
</script>
</body>
</html>