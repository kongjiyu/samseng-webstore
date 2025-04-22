<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contact Us</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>
<body class="min-h-screen flex flex-col">
<%@include file="general/userHeader.jsp"%>
<div class="flex-grow flex justify-center items-center relative">
<video autoplay muted loop class="fixed top-0 left-0 w-full h-full object-cover -z-10">
  <source src="<%= request.getContextPath() %>/static/video/background3.mp4" type="video/mp4" />
  Your browser does not support the video tag.
</video>

<div class="flex flex-col min-h-screen items-center justify-center flex-grow">
  <div class="flex flex-col md:flex-row w-full max-w-5xl mx-auto mt-[5.5rem] p-6 rounded-lg bg-base-100 shadow-lg border border-base-200 z-10">
    <!-- Left Side: Company Info -->
    <div class="w-full md:w-1/2 pr-6">
      <h2 class="text-3xl font-bold mb-4">Contact Us</h2>
      <p class="mb-4">Feel free to use the form or drop us an email. Old-fashioned phone calls work too.</p>
      <ul class="space-y-4 text-base">
        <li class="flex items-center">
          <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-phone"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M5 4h4l2 5l-2.5 1.5a11 11 0 0 0 5 5l1.5 -2.5l5 2v4a2 2 0 0 1 -2 2a16 16 0 0 1 -15 -15a2 2 0 0 1 2 -2" /></svg>
          +60 12-345 6789
        </li>
        <li class="flex items-center">
          <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-mail"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M3 7a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v10a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-10z" /><path d="M3 7l9 6l9 -6" /></svg>
          info@samsengstore.com
        </li>
        <li class="flex items-center">
          <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-map"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M3 7l6 -3l6 3l6 -3v13l-6 3l-6 -3l-6 3v-13" /><path d="M9 4v13" /><path d="M15 7v13" /></svg>
          No. 1, Jalan Samseng, KL 50000
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
</div>
<%@include file="general/userFooter.jsp"%>
</body>
</html>
