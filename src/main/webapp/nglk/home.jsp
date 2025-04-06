<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("username");
    if (user == null) {
        response.sendRedirect("login.jsp");
    }
%>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
<h2>Welcome, <%= user %>!</h2>
<a href="logoutServlet">Logout</a>
</body>
</html>

