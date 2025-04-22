<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error - SAMSENG Webstore</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script defer src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>
<body class="min-h-screen flex flex-col justify-center items-center">
<video autoplay muted loop class="fixed top-0 left-0 w-full h-full object-cover -z-10">
    <source src="<%= request.getContextPath() %>/static/video/background3.mp4" type="video/mp4" />
    Your browser does not support the video tag.
</video>
    <div class="bg-white shadow-md rounded-lg p-10 text-center max-w-md">
        <h1 class="text-4xl font-bold text-red-500 mb-4">Oops!</h1>
        <p class="text-lg text-gray-700 mb-6">Something went wrong. Please try again later.</p>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if(errorMessage != null){
        %>
        <p class="text-lg text-gray-700 mb-6"><%=request.getAttribute("errorMessage")%></p>
        <% } %>
        <a href="/"><button class="btn btn-text btn-info">Go to Home</button></a>
    </div>
</body>
</html>
