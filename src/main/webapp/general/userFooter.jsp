<html>
<head>
    <title>Footer</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>

</head>
<body>
<footer data-theme="light" class="footer bg-base-200 flex flex-col items-center gap-4 p-6">
    <div class="flex items-center gap-2 text-xl font-bold">
        <span>SAMSENG</span>
    </div>
    <aside>
        <div class="flex flex-row items-center justify-center max-h-20 gap-1">
            <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 23 23"
                 fill="none" stroke="currentColor" stroke-width="1.25" stroke-linecap="round" stroke-linejoin="round"
                 class="icon icon-tabler icons-tabler-outline icon-tabler-copyright">
                <path stroke="none" d="M0 0h20v20H0z" fill="none"/>
                <path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0"/>
                <path d="M14 9.75a3.016 3.016 0 0 0 -4.163 .173a2.993 2.993 0 0 0 0 4.154a3.016 3.016 0 0 0 4.163 .173"/>
                <span>2025 SAMSENG</span>
            </svg>
        </div>
    </aside>
    <nav class="text-base-content grid-flow-col gap-4">
        <a class="link link-hover" href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a class="link link-hover" href="${pageContext.request.contextPath}/products">Products</a>
        <a class="link link-hover" href="${pageContext.request.contextPath}/contactUs.jsp">Contact Us</a>
        <a class="link link-hover" href="${pageContext.request.contextPath}/promotions.jsp">Promotions</a>
    </nav>
    <div class="flex h-5 gap-4">
        <a href="https://github.com/kongjiyu/samseng-webstore.git" class="link" aria-label="Github Link">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                 class="icon icon-tabler icons-tabler-outline icon-tabler-brand-github">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                <%--why the fuck is this so long--%>
                <path d="M9 19c-4.3 1.4 -4.3 -2.5 -6 -3m12 5v-3.5c0 -1 .1 -1.4 -.5 -2c2.8 -.3 5.5 -1.4 5.5 -6a4.6 4.6 0 0 0 -1.3 -3.2a4.2 4.2 0 0 0 -.1 -3.2s-1.1 -.3 -3.5 1.3a12.3 12.3 0 0 0 -6.2 0c-2.4 -1.6 -3.5 -1.3 -3.5 -1.3a4.2 4.2 0 0 0 -.1 3.2a4.6 4.6 0 0 0 -1.3 3.2c0 4.6 2.7 5.7 5.5 6c-.6 .6 -.6 1.2 -.5 2v3.5"/>
            </svg>
        </a>
        <a href="https://www.facebook.com/profile.php?id=100006784063291" class="link" aria-label="Facebook Link">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                 class="icon icon-tabler icons-tabler-outline icon-tabler-brand-facebook">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                <path d="M7 10v4h3v7h4v-7h3l1 -4h-4v-2a1 1 0 0 1 1 -1h3v-4h-3a5 5 0 0 0 -5 5v2h-3"/>
            </svg>
        </a>
        <a href="https://open.spotify.com/playlist/62HKtTf1xIFFx8JXhEauVv?si=c51e4137b5ad43a1" class="link"
           aria-label="Spotify Link">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                 class="icon icon-tabler icons-tabler-outline icon-tabler-brand-spotify">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                <path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0"/>
                <path d="M8 11.973c2.5 -1.473 5.5 -.973 7.5 .527"/>
                <path d="M9 15c1.5 -1 4 -1 5 .5"/>
                <path d="M7 9c2 -1 6 -2 10 .5"/>
            </svg>
        </a>
        <a href="https://www.instagram.com/kongjiyu0198?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw=="
           class="link" aria-label="Insta Link">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                 class="icon icon-tabler icons-tabler-outline icon-tabler-brand-instagram">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                <path d="M4 8a4 4 0 0 1 4 -4h8a4 4 0 0 1 4 4v8a4 4 0 0 1 -4 4h-8a4 4 0 0 1 -4 -4z"/>
                <path d="M9 12a3 3 0 1 0 6 0a3 3 0 0 0 -6 0"/>
                <path d="M16.5 7.5v.01"/>
            </svg>
        </a>
    </div>
</footer>
</body>
</html>
