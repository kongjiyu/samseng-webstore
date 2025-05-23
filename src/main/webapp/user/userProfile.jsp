<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@page import="com.samseng.web.models.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
    <script src="https://unpkg.com/libphonenumber-js@1.10.21/bundle/libphonenumber-js.min.js"></script>
</head>

<body data-theme="light" class="bg-transparent">
<video autoplay muted loop class="fixed top-0 left-0 w-full h-full object-cover -z-10">
    <source src="<%= request.getContextPath() %>/static/video/background3.mp4" type="video/mp4"/>
    Your browser does not support the video tag.
</video>
<%@ include file="/general/userHeader.jsp" %>

<div class="flex flex-col gap-6 p-10 pt-[5.5rem] backdrop-blur-lg min-h-screen">
    <!-- Profile Section -->
    <%
        Account profile = (Account) session.getAttribute("profile");
    %>
    <div class="bg-base-100 p-8 rounded-lg shadow-lg">
        <h1 class="text-2xl font-bold mb-6">Profile</h1>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Profile Picture -->
            <div class="col-span-1 flex flex-col items-center my-auto">
                <div class="relative inline-flex items-center justify-center w-24 h-24 overflow-hidden bg-secondary rounded-full">
                    <%
                        String[] nameParts = profile.getUsername().trim().split("\\s+");
                        StringBuilder initials = new StringBuilder();
                        for (String part : nameParts) {
                            if (!part.isEmpty()) {
                                initials.append(part.charAt(0));
                                if (initials.length() == 2) break;
                            }
                        }
                    %>
                    <span class="text-3xl uppercase text-white"><%= initials.toString() %></span>
                </div>
                <button class="btn btn-outline btn-error mt-6" data-overlay="#delete-confirm-modal">Delete</button>
            </div>

            <!-- Profile Information Form -->
            <div class="col-span-2">
                <form class="space-y-4" method="post" action="<%= request.getContextPath() %>/user/profile">
                    <input type="hidden" name="action" value="update"/>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="label">User ID</label>
                            <input type="text" class="input input-bordered w-full" value="<%=profile.getId()%>" disabled/>
                        </div>
                        <div>
                            <label class="label">Username</label>
                            <input type="text" class="input input-bordered w-full" name="username" value="<%=profile.getUsername()%>"/>
                        </div>
                        <div>
                            <label class="label">Date of Birth</label>
                            <input type="date" class="input input-bordered w-full" value="<%=profile.getDob()%>" disabled/>
                        </div>
                        <div>
                            <label class="label">Email</label>
                            <input type="email" class="input input-bordered w-full" name="email" value="<%=profile.getEmail()%>"/>
                            <small class="text-sm text-warning">Changing your email will log you out automatically.</small>
                        </div>
                        <div>
                            <label class="label">Role</label>
                            <input type="text" class="input input-bordered w-full" placeholder="<%=profile.getRole().name()%>" disabled/>
                        </div>
                    </div>

                    <div class="text-right mt-4">
                        <button class="btn btn-info" type="submit">Save</button>
                        <button type="button" class="btn btn-warning ml-2"
                                aria-haspopup="dialog" aria-expanded="false"
                                aria-controls="change-password-modal"
                                data-overlay="#change-password-modal">
                            Change Password
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Address Section -->
    <%
        List<Address> addressList = (List<Address>) request.getAttribute("addresses");
        if (addressList != null) {
    %>
    <div class="bg-base-100 p-8 rounded-lg shadow-lg">
        <h2 class="text-xl font-semibold mb-4">Addresses</h2>

        <div class="space-y-4">
            <!-- First address with default badge -->
            <%
                for (Address address : addressList) {
            %>
            <div class="border border-base-300 p-4 rounded-lg flex justify-between items-start">
                <div>
                    <p class="font-semibold"><%=address.getName()%>
                    </p>
                    <p class="text-sm"><%=address.getAddress_1()%>
                    </p>
                    <p class="text-sm"><%=address.getAddress_2()%>
                    </p>
                    <% if (address.getAddress_3() != null) {%>
                    <p class="text-sm"><%=address.getAddress_3()%>
                    </p>
                    <% } %>
                    <p class="text-sm"><%=address.getPostcode()%>
                    </p>
                    <p class="text-sm"><%=address.getCountry()%>
                    </p>
                    <p class="text-sm"><%=address.getContact_no()%>
                    </p>
                    <% if (address.getIsdefault()) { %>
                    <span class="badge badge-info mt-2">Default</span>
                    <% } %>
                </div>
                <button type="button" class="btn btn-outline btn-sm" aria-haspopup="dialog" aria-expanded="false"
                        aria-controls="edit-address-modal-<%=address.getId()%>"
                        data-overlay="#edit-address-modal-<%=address.getId()%>">
                    Edit
                </button>
            </div>
            <%
                }
            %>
            <%
                }
            %>
        </div>


        <div class="text-right mt-4">
            <!-- Add Address Button -->
            <button type="button" class="btn btn-info btn-sm" aria-haspopup="dialog" aria-expanded="false"
                    aria-controls="add-address-modal" data-overlay="#add-address-modal">
                Add New Address
            </button>

            <!-- Add Address Modal -->
            <div id="add-address-modal"
                 class="overlay modal modal-middle overlay-open:opacity-100 overlay-open:duration-300 hidden overflow-y-auto backdrop-blur-sm [--body-scroll:true] z-0"
                 role="dialog" tabindex="-1">
                <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300 max-w-xl w-full">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">Add New Address</h3>
                            <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3"
                                    aria-label="Close"
                                    data-overlay="#add-address-modal">
                                <span class="icon-[tabler--x] size-4"></span>
                            </button>
                        </div>
                        <form id="new-address-form" action="<%= request.getContextPath() %>/user/profile" method="post">
                            <div class="modal-body space-y-4">

                                <div class="grid grid-cols-1 gap-4">
                                    <input type="text" class="input input-bordered w-full"
                                           placeholder="Address Title (e.g. Home)" name="address_title" required/>
                                    <input type="text" class="input input-bordered w-full" placeholder="Address Line 1"
                                           name="address_1" required/>
                                    <input type="text" class="input input-bordered w-full" placeholder="Address Line 2"
                                           name="address_2"/>
                                    <input type="text" class="input input-bordered w-full" placeholder="Address Line 3"
                                           name="address_3"/>

                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <input type="text" class="input input-bordered w-full"
                                           placeholder="State / Province" name="state" required/>
                                           <input type="text" class="input input-bordered w-full"
                                           placeholder="Postal Code"
                                           name="postcode"
                                           pattern="\d{5}"
                                           maxlength="5"
                                           inputmode="numeric"
                                           required
                                           title="Please enter a 5-digit postcode"/>
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    
                                    <select class="select select-bordered w-full" name="country" disabled required>
                                        <option value="Malaysia" selected>Malaysia</option>
                                    </select>
                                    <input type="hidden" name="country" value="Malaysia" />
                                    <input type="tel" class="input input-bordered w-full" placeholder="Phone Number" name="contact_no" id="contact-no-input" required/>

                                </div>
                                <label class="flex items-center gap-2">
                                    <input type="checkbox" class="checkbox" name="isdefault" <%= (addressList != null && addressList.isEmpty()) ? "checked disabled" : "" %>/>
                                    <span>Set as default</span>
                                </label>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-soft btn-secondary"
                                        data-overlay="#add-address-modal">Cancel
                                </button>
                                <input type="hidden" name="action" value="addressAdd"/>
                                <button type="submit" class="btn btn-info" form="new-address-form">Save Address</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Edit Address Modal for Home Address -->
<%
    for (Address address : addressList) {
        if (address != null) {
%>
<div id="edit-address-modal-<%=address.getId()%>"
     class="overlay modal modal-middle overlay-open:opacity-100 overlay-open:duration-300 hidden overflow-y-auto backdrop-blur-sm [--body-scroll:true] z-0"
     role="dialog" tabindex="-1">
    <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300 max-w-xl w-full">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Edit Address</h3>
                <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close"
                        data-overlay="#edit-address-modal-<%= address.getId() %>">
                    <span class="icon-[tabler--x] size-4"></span>
                </button>
            </div>
            <form id="edit-address-form-<%=address.getId()%>" action="<%= request.getContextPath() %>/user/profile"
                  method="post">

                <input type="hidden" name="address_id" value="<%= address.getId() %>"/>
                <div class="modal-body space-y-4">

                    <div class="grid grid-cols-1 gap-4">
                        <input type="text" class="input input-bordered w-full"
                               placeholder="Address Title (e.g. Rose Avenue)" value="<%= address.getName() %>"
                               name="address_title" required/>
                        <input type="text" class="input input-bordered w-full" placeholder="Address Line 1"
                               name="address_1" value="<%= address.getAddress_1() %>" required/>
                        <input type="text" class="input input-bordered w-full" placeholder="Address Line 2"
                               name="address_2" value="<%= address.getAddress_2() %>"/>
                        <input type="text" class="input input-bordered w-full" placeholder="Address Line 3"
                               name="address_3" value="<%= address.getAddress_3() %>"/>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <input type="text" class="input input-bordered w-full" placeholder="State / Province"
                        name="state" value="<%= address.getState()%>" required/>
                        <input type="text" class="input input-bordered w-full" placeholder="Postal Code"
                               name="postcode"
                               value="<%= address.getPostcode() %>"
                               pattern="\d{5}"
                               maxlength="5"
                               inputmode="numeric"
                               required
                               title="Please enter a 5-digit postcode"/>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <select class="select select-bordered w-full" name="country" disabled required>
                            <option value="Malaysia" selected>Malaysia</option>
                        </select>
                        <input type="hidden" name="country" value="Malaysia" />
                        <input type="tel" class="input input-bordered w-full" placeholder="Phone Number"
                        name="contact_no" value="<%= address.getContact_no() %>" required
                        id="contact-no-input-<%= address.getId() %>"/>

                    </div>
                    <label class="flex items-center gap-2">
                        <input type="checkbox" class="checkbox"
                               name="isdefault" <%= address.getIsdefault() ? "checked disabled" : "" %> />
                        <span>Set as default</span>
                    </label>
                    <% if (address.getIsdefault()) { %>
                    <input type="hidden" name="isdefault" value="on" />
                    <% } %>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-soft btn-secondary"
                            data-overlay="#edit-address-modal-<%=address.getId()%>">Cancel
                    </button>
                    <input type="hidden" name="action" value="addressEdit"/>
                    <button type="submit" class="btn btn-info" form="edit-address-form-<%=address.getId()%>">Save
                        Changes
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<%
    }
%>
<%
    }
%>

<div id="change-password-modal" class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden" role="dialog" tabindex="-1">
    <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300 max-w-md w-full">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Change Password</h3>
                <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close" data-overlay="#change-password-modal">
                    <span class="icon-[tabler--x] size-4"></span>
                </button>
            </div>
            <form action="<%= request.getContextPath() %>/user/profile" method="post">
                <div class="modal-body space-y-4">
                    <div class="grid grid-cols-1 gap-4">
                        <div>
                            <label class="label">Current Password</label>
                            <input type="password" name="current_password" class="input input-bordered w-full" placeholder="Enter current password" required />
                        </div>
                        <div>
                            <label class="label">New Password</label>
                            <input type="password" name="new_password" class="input input-bordered w-full" placeholder="Enter new password" required />
                        </div>
                        <div>
                            <label class="label">Confirm Password</label>
                            <input type="password" name="confirm_password" class="input input-bordered w-full" placeholder="Confirm password" required />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-soft btn-secondary" data-overlay="#change-password-modal">Cancel</button>
                    <input type="hidden" name="action" value="changePassword"/>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="delete-confirm-modal" class="overlay modal overlay-open:opacity-100 overlay-open:duration-300 modal-middle hidden" role="dialog" tabindex="-1">
    <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300 max-w-md w-full">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Confirm Account Deletion</h3>
                <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close" data-overlay="#delete-confirm-modal">
                    <span class="icon-[tabler--x] size-4"></span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete your account? This action is permanent.
            </div>
            <div class="modal-footer gap-2">
                <form method="post" action="${pageContext.request.contextPath}/user/profile">
                    <input type="hidden" name="action" value="deleteConfirmed" />
                    <button type="submit" class="btn btn-danger">Yes, Delete</button>
                    <button type="button" class="btn btn-secondary" data-overlay="#delete-confirm-modal">Cancel</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="/general/userFooter.jsp" %>
<script>
    function isValidPhoneNumber(phone) {
        try {
            const phoneNumber = libphonenumber.parsePhoneNumber(phone, 'MY');
            return phoneNumber.isValid();
        } catch {
            return false;
        }
    }

    const addressForm = document.getElementById('new-address-form');
    addressForm.addEventListener('submit', function (e) {
        const phoneValue = document.getElementById('contact-no-input').value;
        if (!isValidPhoneNumber(phoneValue)) {
            e.preventDefault();
            alert("Invalid phone number.");
        }
    });
</script>

<script>
    document.querySelectorAll('form[id^="edit-address-form-"]').forEach((form) => {
        const phoneInput = form.querySelector('input[name="contact_no"]');

        form.addEventListener('submit', function (e) {
            try {
                const phoneNumber = libphonenumber.parsePhoneNumber(phoneInput.value, 'MY');
                if (!phoneNumber.isValid()) {
                    e.preventDefault();
                    alert("Invalid phone number.");
                }
            } catch {
                e.preventDefault();
                alert("Invalid phone number.");
            }
        });
    });
</script>

</body>

</html>