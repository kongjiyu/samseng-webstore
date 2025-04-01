<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tailwind v3 with JSP</title>
    <link href="./static/css/output.css" rel="stylesheet">
    <script src="../node_modules/flyonui/flyonui.js"></script>
    <script src="../node_modules/flyonui/dist/js/accordion.js"></script>
</head>
<body class="bg-gray-100 text-center p-10">
<h1 class="text-4xl font-bold text-blue-600">Tailwind CSS v3 with JSP!</h1>
<p class="text-blue-600">Testing</p>
<!-- Stepper -->
<div data-stepper="" class="bg-base-100 flex w-full items-start gap-10 rounded-lg p-4 shadow-sm max-sm:flex-wrap max-sm:justify-center" id="wizard-validation" >
    <!-- Stepper Nav -->
    <ul class="relative flex flex-col gap-y-2">
        <li class="group flex flex-1 flex-col items-center" data-stepper-nav-item='{ "index": 1 }'>
      <span class="min-h-7.5 inline-flex flex-col items-center gap-2 align-middle text-sm">
        <span class="stepper-active:text-bg-primary stepper-active:shadow-sm shadow-base-300/20 stepper-success:text-bg-primary stepper-success:shadow-sm stepper-completed:text-bg-success stepper-error:text-bg-error text-bg-soft-neutral flex size-7.5 shrink-0 items-center justify-center rounded-full font-medium" >
          <span class="stepper-success:hidden stepper-error:hidden stepper-completed:hidden text-sm">1</span>
          <span class="icon-[tabler--check] stepper-success:block hidden size-4 shrink-0"></span>
          <span class="icon-[tabler--x] stepper-error:block hidden size-4 shrink-0"></span>
        </span>
        <span class="text-base-content text-nowrap font-medium">Account Details</span>
      </span>
            <div class="stepper-success:bg-primary stepper-completed:bg-success bg-base-content/20 mt-2 h-8 w-px group-last:hidden" ></div>
        </li>
        <li class="group flex flex-1 flex-col items-center" data-stepper-nav-item='{ "index": 2 }'>
      <span class="min-h-7.5 inline-flex flex-col items-center gap-2 align-middle text-sm">
        <span class="stepper-active:text-bg-primary stepper-active:shadow-sm shadow-base-300/20 stepper-success:text-bg-primary stepper-success:shadow-sm stepper-completed:text-bg-success stepper-error:text-bg-error text-bg-soft-neutral flex size-7.5 shrink-0 items-center justify-center rounded-full font-medium" >
          <span class="stepper-success:hidden stepper-error:hidden stepper-completed:hidden text-sm">2</span>
          <span class="icon-[tabler--check] stepper-success:block hidden size-4 shrink-0"></span>
          <span class="icon-[tabler--x] stepper-error:block hidden size-4 shrink-0"></span>
        </span>
        <span class="text-base-content text-nowrap font-medium">Personal Info</span>
      </span>
            <div class="stepper-success:bg-primary stepper-completed:bg-success bg-base-content/20 mt-2 h-8 w-px group-last:hidden" ></div>
        </li>
        <li class="group flex flex-1 flex-col items-center" data-stepper-nav-item='{ "index": 3 }'>
      <span class="min-h-7.5 inline-flex flex-col items-center gap-2 align-middle text-sm">
        <span class="stepper-active:text-bg-primary stepper-active:shadow-sm shadow-base-300/20 stepper-success:text-bg-primary stepper-success:shadow-sm stepper-completed:text-bg-success stepper-error:text-bg-error text-bg-soft-neutral flex size-7.5 shrink-0 items-center justify-center rounded-full font-medium" >
          <span class="stepper-success:hidden stepper-error:hidden stepper-completed:hidden text-sm">3</span>
          <span class="icon-[tabler--check] stepper-success:block hidden size-4 shrink-0"></span>
          <span class="icon-[tabler--x] stepper-error:block hidden size-4 shrink-0"></span>
        </span>
        <span class="text-base-content text-nowrap font-medium">Social Links</span>
      </span>
            <div class="stepper-success:bg-primary stepper-completed:bg-success bg-base-content/20 mt-2 h-8 w-px group-last:hidden" ></div>
        </li>
        <!-- End Item -->
    </ul>
    <!-- End Stepper Nav -->

    <!-- Stepper Content -->
    <form id="wizard-validation-form" class="form-validate w-full p-3" novalidate action="UserController" method="post">
        <!-- Account Details -->
        <div id="account-details-validation" class="space-y-5" data-stepper-content-item='{ "index": 1 }'>
            <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                <div>
                    <label class="label-text" for="firstName"> First Name </label>
                    <input type="text" placeholder="John" class="input" id="firstName" name="firstName" required />
                </div>
                <div>
                    <label class="label-text" for="lastName"> Last Name </label>
                    <input type="text" placeholder="Doe" class="input" id="lastName" name="lastName" required />
                </div>
            </div>
            <!-- Email and password -->
            <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                <div>
                    <label class="label-text" for="email"> Email </label>
                    <input type="email" class="input" placeholder="john@gmail.com" id="email" aria-label="john@gmail.com" required="" name="email" />
                </div>
                <div>
                    <label class="label-text" for="password">Password</label>
                    <div class="input">
                        <input id="password" type="password" placeholder="Enter password" required name="password"/>
                        <button type="button" data-toggle-password='{ "target": "#password" }' class="block cursor-pointer" aria-label="password toggle" >
                            <span class="icon-[tabler--eye] text-base-content/80 password-active:block hidden size-5 shrink-0"></span>
                            <span class="icon-[tabler--eye-off] text-base-content/80 password-active:hidden block size-5 shrink-0"></span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Account Details -->
        <!-- Personal Info -->
        <div id="personal-info-validation" class="space-y-5" data-stepper-content-item='{ "index": 2 }' style="display: none" >
            <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                <div>
                    <label class="label-text" for="profile"> Profile Pic </label>
                    <input type="file" class="input" id="profile" />
                </div>
                <div>
                    <label class="label-text" for="dob"> DOB </label>
                    <input type="text" class="input jsPickr" id="dob" placeholder="YYYY-MM-DD" required name="DOB"/>
                </div>
            </div>
            <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                <div>
                    <label class="label-text" for="country"> Pick your Country </label>
                    <select class="select" id="country" required>
                        <option value="">Select Country</option>
                        <option value="usa">USA</option>
                        <option value="uk">UK</option>
                        <option value="france">France</option>
                        <option value="australia">Australia</option>
                        <option value="spain">Spain</option>
                    </select>
                </div>
                <div>
                    <h6 class="text-sm text-base-content mb-1">Gender</h6>
                    <div class="flex gap-4">
                        <div class="flex items-center gap-1">
                            <input type="radio" name="gender" class="radio radio-primary" id="male" required />
                            <label class="label-text text-base" for="male"> Male </label>
                        </div>
                        <div class="flex items-center gap-1">
                            <input type="radio" name="gender" class="radio radio-primary" id="female" required />
                            <label class="label-text text-base" for="female"> Female </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Personal Info -->
        <!-- Social Links -->
        <div id="social-links-validation" class="space-y-5" data-stepper-content-item='{ "index": 3}' style="display: none">
            <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                <div>
                    <label class="label-text" for="forTwitter"> TWITTER </label>
                    <input type="text" name="forTwitter" id="forTwitter" class="input" placeholder="https://twitter.com/abc" />
                </div>
                <div>
                    <label class="label-text" for="forFacebook"> FACEBOOK </label>
                    <input type="text" name="forFacebook" id="forFacebook" class="input" placeholder="https://facebook.com/abc" />
                </div>
            </div>
            <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
                <div>
                    <label class="label-text" for="forGoogle"> GOOGLE+ </label>
                    <input type="text" name="forGoogle" id="forGoogle" class="input" placeholder="https://plus.google.com/abc" />
                </div>
                <div>
                    <label class="label-text" for="formValidationLinkedIn"> LINKEDIN </label>
                    <input type="text" name="formValidationLinkedIn" id="formValidationLinkedIn" class="input" placeholder="https://linkedin.com/abc" />
                </div>
            </div>
        </div>
        <!-- End Social Links -->
        <!-- Final Content -->
        <div data-stepper-content-item='{ "isFinal": true }' style="display: none">
            <div class="border-base-content/40 bg-base-200/50 flex h-48 items-center justify-center rounded-xl border border-dashed p-4">
                <h3 class="text-base-content/50 text-3xl">Your Form has been Submitted</h3>
            </div>
        </div>
        <!-- End Final Content -->
        <!-- Button Group -->
        <div class="mt-5 flex items-center justify-between gap-x-2">
            <button type="button" class="btn btn-primary btn-prev max-sm:btn-square" data-stepper-back-btn="">
                <span class="icon-[tabler--chevron-left] text-primary-content size-5 rtl:rotate-180"></span>
                <span class="max-sm:hidden">Back</span>
            </button>
            <button type="button" class="btn btn-primary btn-next max-sm:btn-square" data-stepper-next-btn="">
                <span class="max-sm:hidden">Next</span>
                <span class="icon-[tabler--chevron-right] text-primary-content size-5 rtl:rotate-180"></span>
            </button>
            <button type="button" class="btn btn-primary" data-stepper-finish-btn="" style="display: none">Finish</button>
            <button type="reset" class="btn btn-primary" data-stepper-reset-btn="" style="display: none">Reset</button>
        </div>
        <!-- End Button Group -->
    </form>
    <!-- End Stepper Content -->
</div>
<!-- End Stepper -->
</body>

<script>
    window.addEventListener('load', function () {
        // Initialize flatpickr
        flatpickr('.jsPickr', {
            allowInput: true,
            monthSelectorType: 'static'
        })
    })
</script>


</html>