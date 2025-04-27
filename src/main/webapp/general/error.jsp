<%@ page import="java.awt.*" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!--=============== BOXICONS ===============-->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>

        <!--=============== CSS ===============-->
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/error.css">
        <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">

        <title>Responsive 404 website - Bedimcode</title>
    </head>
    <body data-theme="light">

        <%@include file="userHeader.jsp"%>
        <!--==================== MAIN ====================-->
        <main class="main">
            <!--==================== HOME ====================-->
            <section class="home">

                <div class="home__container container">
                    <div class="home__data">
                        <span class="home__subtitle">Error ${pageContext.errorData.statusCode}</span>
                        <h1 class="home__title">Hey Buddy</h1>
                        <p class="home__description">
                            <%
                                int statusCode = pageContext.getErrorData().getStatusCode();
                                String message = "";

                                if (statusCode == 404) {
                                    message = "Oops! The page you're looking for doesn't exist.";
                                } else if (statusCode == 500) {
                                    message = "Sorry! There was a server error. Please try again later.";
                                } else {
                                    message = "An unexpected error occurred.";
                                }
                            %>
                            <%=message%>
                        </p>
                        <a href="<%= request.getContextPath() %>/" class="home__button">
                            Go Home
                        </a>
                    </div>

                    <div class="home__img">
                        <img src="<%= request.getContextPath() %>/static/img/ghost-img2.png" alt="">
                        <div class="home__shadow"></div>
                    </div>
                </div>
            </section>
        </main>

        <!--=============== SCROLLREVEAL ===============-->
        <script src="<%= request.getContextPath() %>/static/js/scrollreveal.min.js"></script>

        <!--=============== MAIN JS ===============-->
        <script src="<%= request.getContextPath() %>/static/js/error.js"></script>

        <%@include file="userFooter.jsp"%>
    </body>
</html>