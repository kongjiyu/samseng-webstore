<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
<video autoplay muted loop class="fixed top-0 left-0 w-full h-full object-cover -z-10">
    <source src="<%= request.getContextPath() %>/static/video/background3.mp4" type="video/mp4" />
    Your browser does not support the video tag.
</video>
<%@ include file="/general/userHeader.jsp" %>

<div class="flex flex-col gap-6 p-10 pt-[5.5rem] backdrop-blur-lg min-h-screen">
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
                <form class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="label">User ID</label>
                            <input type="text" class="input input-bordered w-full" placeholder="USR123456"
                                   disabled />
                        </div>
                        <div>
                            <label class="label">Username</label>
                            <input type="text" class="input input-bordered w-full" placeholder="admin" name="username" value="${Account.username}"/>
                        </div>
                        <div>
                            <label class="label">Date of Birth</label>
                            <input type="date" class="input input-bordered w-full" value="2000-01-01" disabled />
                        </div>
                        <div>
                            <label class="label">Email</label>
                            <input type="email" class="input input-bordered w-full"
                                   placeholder="user@example.com" />
                        </div>
                        <div>
                            <label class="label">Role</label>
                            <input type="text" class="input input-bordered w-full" placeholder="User" disabled />
                        </div>
                    </div>
                    <div class="text-right">
                        <button class="btn btn-info">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Address Section -->
    <div class="bg-base-100 p-8 rounded-lg shadow-lg">
        <h2 class="text-xl font-semibold mb-4">Addresses</h2>
        <div class="space-y-4">
            <!-- First address with default badge -->
            <div class="border border-base-300 p-4 rounded-lg flex justify-between items-start">
                <div>
                    <p class="font-semibold">Home Address</p>
                    <p class="text-sm">123 Main Street, Springfield</p>
                    <p class="text-sm">+1 234 567 890</p>
                    <p class="text-sm">USA</p>
                    <span class="badge badge-info mt-2">Default</span>
                </div>
                <button type="button" class="btn btn-outline btn-sm" aria-haspopup="dialog" aria-expanded="false" aria-controls="edit-address-modal-home" data-overlay="#edit-address-modal-home">
                    Edit
                </button>
            </div>

            <div class="border border-base-300 p-4 rounded-lg flex justify-between items-start">
                <div>
                    <p class="font-semibold">Workplace</p>
                    <p class="text-sm">456 Side Road, Shelbyville</p>
                    <p class="text-sm">+1 987 654 321</p>
                    <p class="text-sm">USA</p>
                </div>
                <button type="button" class="btn btn-outline btn-sm" aria-haspopup="dialog" aria-expanded="false" aria-controls="edit-address-modal-work" data-overlay="#edit-address-modal-work">
                    Edit
                </button>
            </div>
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
                        <div class="modal-body space-y-4">
                            <form id="new-address-form" class="grid grid-cols-1 gap-4" action="${pageContext.request.contextPath}/addAddress" method="post">
                                <input type="text" class="input input-bordered w-full" placeholder="Address Title (e.g. Rose Avenue)" required />
                                <input type="text" class="input input-bordered w-full" placeholder="Address Line 1" required />
                                <input type="text" class="input input-bordered w-full" placeholder="Address Line 2" />
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <input type="text" class="input input-bordered w-full" placeholder="City / District" required />
                                    <input type="text" class="input input-bordered w-full" placeholder="State / Province" required />
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <input type="text" class="input input-bordered w-full" placeholder="Postal Code" required />
                                    <select class="select select-bordered w-full" required></select>
                                </div>
                                <label class="flex items-center gap-2">
                                    <input type="checkbox" class="checkbox" />
                                    <span>Set as default</span>
                                </label>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-soft btn-secondary" data-overlay="#add-address-modal">Cancel</button>
                            <button type="submit" class="btn btn-info" form="new-address-form">Save Address</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Edit Address Modal for Home Address -->
            <div id="edit-address-modal-home"
                 class="overlay modal modal-middle overlay-open:opacity-100 overlay-open:duration-300 hidden overflow-y-auto backdrop-blur-sm [--body-scroll:true] z-0"
                 role="dialog" tabindex="-1">
                <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300 max-w-xl w-full">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">Edit Address</h3>
                            <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close"
                                    data-overlay="#edit-address-modal-home">
                                <span class="icon-[tabler--x] size-4"></span>
                            </button>
                        </div>
                        <div class="modal-body space-y-4">
                            <form id="edit-address-form-home" class="grid grid-cols-1 gap-4">
                                <input type="text" class="input input-bordered w-full" placeholder="Address Title (e.g. Home Address)" value="Home Address" />
                                <input type="text" class="input input-bordered w-full" placeholder="Address Line 1" value="123 Main Street" />
                                <input type="text" class="input input-bordered w-full" placeholder="Address Line 2" />
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <input type="text" class="input input-bordered w-full" placeholder="City / District" value="Springfield" />
                                    <input type="text" class="input input-bordered w-full" placeholder="State / Province" />
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <input type="text" class="input input-bordered w-full" placeholder="Postal Code" />
                                    <select class="select select-bordered w-full"></select>
                                </div>
                                <label class="flex items-center gap-2">
                                    <input type="checkbox" class="checkbox" checked />
                                    <span>Set as default</span>
                                </label>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-soft btn-secondary" data-overlay="#edit-address-modal-home">Cancel</button>
                            <button type="submit" class="btn btn-info" form="edit-address-form-home">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Edit Address Modal for Workplace -->
            <div id="edit-address-modal-work"
                 class="overlay modal modal-middle overlay-open:opacity-100 overlay-open:duration-300 hidden overflow-y-auto backdrop-blur-sm [--body-scroll:true] z-0"
                 role="dialog" tabindex="-1">
                <div class="modal-dialog overlay-open:opacity-100 overlay-open:duration-300 max-w-xl w-full">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">Edit Address</h3>
                            <button type="button" class="btn btn-text btn-circle btn-sm absolute end-3 top-3" aria-label="Close"
                                    data-overlay="#edit-address-modal-work">
                                <span class="icon-[tabler--x] size-4"></span>
                            </button>
                        </div>
                        <div class="modal-body space-y-4">
                            <form id="edit-address-form-work" class="grid grid-cols-1 gap-4">
                                <input type="text" class="input input-bordered w-full" placeholder="Address Title (e.g. Workplace)" value="Workplace" />
                                <input type="text" class="input input-bordered w-full" placeholder="Address Line 1" value="456 Side Road" />
                                <input type="text" class="input input-bordered w-full" placeholder="Address Line 2" />
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <input type="text" class="input input-bordered w-full" placeholder="City / District" value="Shelbyville" />
                                    <input type="text" class="input input-bordered w-full" placeholder="State / Province" />
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <input type="text" class="input input-bordered w-full" placeholder="Postal Code" />
                                    <select class="select select-bordered w-full"></select>
                                </div>
                                <label class="flex items-center gap-2">
                                    <input type="checkbox" class="checkbox" />
                                    <span>Set as default</span>
                                </label>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-soft btn-secondary" data-overlay="#edit-address-modal-work">Cancel</button>
                            <button type="submit" class="btn btn-info" form="edit-address-form-work">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

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
                const countrySelect = document.querySelector('#add-address-modal select');
                data
                    .sort((a, b) => a.name.common.localeCompare(b.name.common))
                    .forEach(country => {
                        const option = document.createElement('option');
                        option.value = country.name.common;
                        option.textContent = country.name.common;
                        countrySelect.appendChild(option);
                    });
            })
            .catch(err => console.error('Failed to load countries:', err));
    });
</script>
</body>

</html>