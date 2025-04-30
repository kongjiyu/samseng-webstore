<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contact Us</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>
<body data-theme="light" class="min-h-screen flex flex-col bg-transparent">
<%@include file="general/userHeader.jsp"%>

<main class="flex-1 flex items-center justify-center relative">
  <video autoplay muted loop class="fixed top-0 left-0 w-full h-full object-cover -z-10">
    <source src="<%= request.getContextPath() %>/static/video/background3.mp4" type="video/mp4" />
    Your browser does not support the video tag.
  </video>

  <div class="flex flex-col items-center justify-center w-full">
    <div class="flex flex-col md:flex-row w-full max-w-5xl mx-auto mt-4 p-3 rounded-lg bg-base-100 shadow-lg border border-base-200 z-10">
      <!-- Left Side: Company Info -->
      <div class="w-full md:w-1/2 pr-6">
        <h2 class="text-3xl font-bold mb-4">Contact Us</h2>
        <p class="mb-4">Feel free to use the form or drop us an email. Old-fashioned phone calls work too.</p>
        <ul class="space-y-4 text-base">
          <!-- Phone -->
          <li class="flex items-start gap-3">
            <span class="icon-[tabler--phone] w-6 h-6 flex-shrink-0 self-start text-primary"></span>
            <p class="text-sm break-words">${companyContact}</p>
          </li>

          <!-- Email -->
          <li class="flex items-start gap-3">
            <span class="icon-[tabler--mail] w-6 h-6 flex-shrink-0 self-start text-primary"></span>
            <p class="text-sm break-words">${companyEmail}</p>
          </li>

          <!-- Address -->
          <li class="flex items-start gap-3">
            <span class="icon-[tabler--map-pin] w-6 h-6 flex-shrink-0 self-start text-primary"></span>
            <p class="text-sm break-words">${companyAddress}</p>
          </li>
        </ul>
      </div>

      <!-- Right Side: Contact Form -->
      <div class="w-full md:w-1/2">
        <form method="POST" action="contact" class="space-y-4">
          <div class="form-control">
            <label class="label">
              <span class="label-text">Name</span>
            </label>
            <input type="text" name="name" placeholder="Your Name" class="input input-bordered w-full" required />
          </div>

          <div class="form-control">
            <label class="label">
              <span class="label-text">Email</span>
            </label>
            <input type="email" name="email" placeholder="you@example.com" class="input input-bordered w-full" required />
          </div>

          <div class="form-control">
            <label class="label">
              <span class="label-text">Message</span>
            </label>
            <textarea name="message" placeholder="Your message..." class="textarea textarea-bordered w-full" required></textarea>
          </div>

          <button type="submit" class="btn btn-primary w-full">Send Message</button>
        </form>
      </div>
    </div>
  </div>
</main>

<%@include file="general/userFooter.jsp"%>
</body>
</html>
