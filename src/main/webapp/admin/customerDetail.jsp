<%@ page import="com.samseng.web.models.Account" %>
<%@ page import="com.samseng.web.models.Address" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
  <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>
<body>
<!--Header-->
<nav class="navbar rounded-box flex w-full items-center justify-between gap-2 shadow-base-300/20 shadow-sm">
  <div class="navbar-start max-md:w-1/4">
    <a class="link text-base-content link-neutral text-xl font-bold no-underline" href="#">
      FlyonUI
    </a>
  </div>
  <div class="navbar-center max-md:hidden">
    <ul class="menu menu-horizontal p-0 font-medium [--menu-active-bg:transparent]">
      <li><a href="#">Profile</a></li>
      <li><a href="#">Order</a></li>
      <li><a href="#">Product</a></li>
      <li><a href="#">Customers</a></li>
    </ul>
  </div>

  <div class="navbar-end items-center gap-4">
    <div class="dropdown relative inline-flex [--auto-close:inside] [--offset:8] [--placement:bottom-end]">
      <button id="dropdown-scrollable" type="button" class="dropdown-toggle flex items-center"
              aria-haspopup="menu" aria-expanded="false" aria-label="Dropdown">
        <div class="avatar">
          <div class="size-9.5 rounded-full">
            <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar 1" />
          </div>
        </div>
      </button>
      <ul class="dropdown-menu dropdown-open:opacity-100 hidden min-w-60" role="menu"
          aria-orientation="vertical" aria-labelledby="dropdown-avatar">
        <li class="dropdown-header gap-2">
          <div class="avatar">
            <div class="w-10 rounded-full">
              <img src="https://cdn.flyonui.com/fy-assets/avatar/avatar-1.png" alt="avatar" />
            </div>
          </div>
          <div>
            <h6 class="text-base-content text-base font-semibold">John Doe</h6>
            <small class="text-base-content/50">Admin</small>
          </div>
        </li>
        <li>
          <a class="dropdown-item" href="#">
            <span class="icon-[tabler--user]"></span>
            My Profile
          </a>
        </li>
        <li>
          <a class="dropdown-item" href="#">
            <span class="icon-[tabler--settings]"></span>
            Settings
          </a>
        </li>
        <li>
          <a class="dropdown-item" href="#">
            <span class="icon-[tabler--receipt-rupee]"></span>
            Billing
          </a>
        </li>
        <li>
          <a class="dropdown-item" href="#">
            <span class="icon-[tabler--help-triangle]"></span>
            FAQs
          </a>
        </li>
        <li class="dropdown-footer gap-2">
          <a class="btn btn-error btn-soft btn-block" href="#">
            <span class="icon-[tabler--logout]"></span>
            Sign out
          </a>
        </li>
      </ul>
    </div>
  </div>

</nav>
<div class="breadcrumbs ml-6">
  <ul>
    <li>
      <a href="#">Admin</a>
    </li>
    <li class="breadcrumbs-separator rtl:rotate-180"><span class="icon-[tabler--chevron-right]"></span></li>
    <li>
      <a href="#">Users</a>
    </li>
    <li class="breadcrumbs-separator rtl:rotate-180"><span class="icon-[tabler--chevron-right]"></span></li>
    <li aria-current="page">User Info</li>
  </ul>
</div>

<div class="flex flex-col gap-6 p-10 backdrop-blur-lg min-h-screen">
  <!-- Profile Section -->
  <div class="bg-base-100 p-8 rounded-lg shadow-lg">
    <h1 class="text-2xl font-bold mb-6">Profile</h1>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <!-- Profile Picture -->
      <div class="col-span-1 flex flex-col items-center">
        <div class="avatar mb-4">
          <div class="w-32 rounded-full ring ring-cyan-400 ring-offset-base-100 ring-offset-2">
            <img src="https://i.pravatar.cc/150?img=3" alt="User Avatar">
          </div>
        </div>
        <input id="avatarUpload" type="file" class="hidden" />
        <button class="btn btn-outline btn-info w-full max-w-xs"
                onclick="document.getElementById('avatarUpload').click();">
          Upload Profile Picture
        </button>
        <button class="btn btn-outline btn-error mt-2">Delete</button>
      </div>

      <!-- Profile Information Form -->
      <div class="col-span-2">
        <%
          Account profile = (Account) request.getAttribute("profile");
        %>
        <div class="bg-base-100 p-8 rounded-lg shadow-lg">
          <h1 class="text-2xl font-bold mb-6">Profile</h1>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Profile Picture -->
            <div class="col-span-1 flex flex-col items-center my-auto">
              <div class="relative inline-flex items-center justify-center w-24 h-24 overflow-hidden bg-gray-100 rounded-full dark:bg-gray-600">
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
                <span class="text-3xl uppercase"><%= initials.toString() %></span>
              </div>
              <button class="btn btn-outline btn-error mt-6">Delete</button>
            </div>

            <!-- Profile Information Form -->
            <div class="col-span-2">
              <form method="post" action="<%= request.getContextPath() %>/user/profile" class="space-y-4">
                <input type="hidden" name="action" value="update" />

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label class="label">User ID</label>
                    <input type="text" class="input input-bordered w-full" value="<%=profile.getId()%>" disabled />
                  </div>
                  <div>
                    <label class="label">Username</label>
                    <input type="text" class="input input-bordered w-full" name="username" value="<%=profile.getUsername()%>" />
                  </div>
                  <div>
                    <label class="label">Date of Birth</label>
                    <input type="date" class="input input-bordered w-full" name="dob" value="<%=profile.getDob()%>" />
                  </div>
                  <div>
                    <label class="label">Email</label>
                    <input type="email" class="input input-bordered w-full" name="email" value="<%=profile.getEmail()%>" />
                  </div>
                  <div>
                    <label class="label">Role</label>
                    <select class="select w-full appearance-none" name="role" required>
                      <option value="USER" <%= profile.getRole() == Account.Role.USER ? "selected" : "" %>>User</option>
                      <option value="STAFF" <%= profile.getRole() == Account.Role.STAFF ? "selected" : "" %>>Staff</option>
                      <option value="ADMIN" <%= profile.getRole() == Account.Role.ADMIN ? "selected" : "" %>>Admin</option>
                    </select>
                  </div>
                </div>

                <div class="text-right">
                  <button class="btn btn-info" type="submit">Save</button>
                </div>
              </form>
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
                  <p class="font-semibold"><%=address.getName()%></p>
                  <p class="text-sm"><%=address.getAddress_1()%></p>
                  <p class="text-sm"><%=address.getAddress_2()%></p>
                  <% if (address.getAddress_3()!=null) {%>
                  <p class="text-sm"><%=address.getAddress_3()%></p>
                  <% } %>
                  <p class="text-sm"><%=address.getPostcode()%></p>
                  <p class="text-sm"><%=address.getCountry()%></p>
                  <p class="text-sm"><%=address.getContact_no()%></p>
                  <% if(address.getIsdefault()){ %>
                  <span class="badge badge-info mt-2">Default</span>
                  <% } %>
                </div>
                <button type="button" class="btn btn-outline btn-sm" aria-haspopup="dialog" aria-expanded="false" aria-controls="edit-address-modal-<%=address.getId()%>" data-overlay="#edit-address-modal-<%=address.getId()%>">
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
              <button type="button" class="btn btn-info btn-sm" aria-haspopup="dialog" aria-expanded="false" aria-controls="add-address-modal" data-overlay="#add-address-modal">
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
                      <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close"
                              data-overlay="#add-address-modal">
                        <span class="icon-[tabler--x] size-4"></span>
                      </button>
                    </div>
                    <form id="new-address-form"  action="<%= request.getContextPath() %>/user/profile"  method="post">
                      <div class="modal-body space-y-4">

                        <div class="grid grid-cols-1 gap-4">
                          <input type="text" class="input input-bordered w-full" placeholder="Address Title (e.g. Rose Avenue)" name="address_title" required />
                          <input type="text" class="input input-bordered w-full" placeholder="Address Line 1"  name="address_1" required />
                          <input type="text" class="input input-bordered w-full" placeholder="Address Line 2" name="address_2" />
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                          <input type="text" class="input input-bordered w-full" placeholder="City / District" name="address_3" required />
                          <input type="text" class="input input-bordered w-full" placeholder="State / Province" name="state" required />
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                          <input type="text" class="input input-bordered w-full" placeholder="Postal Code"  name="postcode" required />
                          <select class="select select-bordered w-full" name="country" required></select>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                          <input type="text" class="input input-bordered w-full" placeholder="Contact_No" name="contact_no" required />
                        </div>
                        <label class="flex items-center gap-2">
                          <input type="checkbox" class="checkbox" name="isdefault"/>
                          <span>Set as default</span>
                        </label>

                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-soft btn-secondary" data-overlay="#add-address-modal">Cancel</button>
                        <input type="hidden" name="action" value="addressAdd" />
                        <button type="submit" class="btn btn-info" form="new-address-form">Save Address </button>
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
        if (address !=null){
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
                <form id="edit-address-form-<%=address.getId()%>"  action="<%= request.getContextPath() %>/user/profile"  method="post">

                  <input type="hidden" name="address_id" value="<%= address.getId() %>" />
                  <div class="modal-body space-y-4">

                    <div class="grid grid-cols-1 gap-4">
                      <input type="text" class="input input-bordered w-full" placeholder="Address Title (e.g. Rose Avenue)" value="<%= address.getName() %>" name="address_title" required />
                      <input type="text" class="input input-bordered w-full" placeholder="Address Line 1"  name="address_1"  value="<%= address.getAddress_1() %>" required />
                      <input type="text" class="input input-bordered w-full" placeholder="Address Line 2" name="address_2"  value="<%= address.getAddress_2() %>" />
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <input type="text" class="input input-bordered w-full" placeholder="City / District" name="address_3" value="<%= address.getAddress_3() %>" required />
                      <input type="text" class="input input-bordered w-full" placeholder="Postal Code"  name="postcode" value="<%= address.getPostcode() %>" required />
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <input type="text" class="input input-bordered w-full" placeholder="State / Province" name="state"  value="<%= address.getState()%>" required />
                      <select class="select select-bordered w-full" name="country" data-selected-country="<%= address.getCountry() %>" required></select>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <input type="text" class="input input-bordered w-full" placeholder="Contact_No" name="contact_no" required />
                    </div>
                    <label class="flex items-center gap-2">
                      <input type="checkbox" class="checkbox" name="isdefault" <%= address.getIsdefault() ? "checked" : "" %> />
                      <span>Set as default</span>
                    </label>

                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-soft btn-secondary" data-overlay="#edit-address-modal-<%=address.getId()%>">Cancel</button>
                    <input type="hidden" name="action" value="addressEdit" />
                    <button type="submit" class="btn btn-info" form="edit-address-form-<%=address.getId()%>">Save Changes</button>
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

          <footer data-theme="dark" class="footer bg-base-200 flex flex-col items-center gap-4 p-6">
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
          <script>
            window.addEventListener('DOMContentLoaded', () => {
              fetch('https://restcountries.com/v3.1/all')
                      .then(res => res.json())
                      .then(data => {

                        const addCountrySelect = document.querySelector('#add-address-modal select[name="country"]');
                        if (addCountrySelect) {
                          data.sort((a, b) => a.name.common.localeCompare(b.name.common))
                                  .forEach(country => {
                                    const option = document.createElement('option');
                                    option.value = country.name.common;
                                    option.textContent = country.name.common;
                                    addCountrySelect.appendChild(option);
                                  });
                        }


                        document.querySelectorAll('div[id^="edit-address-modal-"] select[name="country"]').forEach(select => {
                          const currentCountry = select.getAttribute('data-selected-country');
                          data.sort((a, b) => a.name.common.localeCompare(b.name.common))
                                  .forEach(country => {
                                    const option = document.createElement('option');
                                    option.value = country.name.common;
                                    option.textContent = country.name.common;
                                    if (country.name.common === currentCountry) {
                                      option.selected = true;
                                    }
                                    select.appendChild(option);
                                  });
                        });
                      })
                      .catch(err => console.error('Failed to load countries:', err));
            });

          </script>

</body>
</html>