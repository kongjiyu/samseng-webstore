<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html class="scroll-smooth">

<head>
    <title>Home</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/index.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>
</head>

<body data-theme="dark" class="bg-base-200">
<div class="loader">
    <span class="loading loading-spinner loading-lg"></span>
</div>
<div class="">
    <%@ include file="/general/homeHeader.jsp" %>

    <div class="relative isolate px-6 pt-14 lg:px-8">
        <div class="absolute inset-0 z-[-10]">
            <video autoplay muted loop playsinline preload="auto" class="w-full h-full object-cover" id="hero-video">
                <source src="<%= request.getContextPath() %>/static/video/background.mp4" type="video/mp4"/>
                Your browser does not support the video tag.
            </video>
            <div
                    class="absolute inset-x-0 bottom-0 h-96 bg-gradient-to-b from-transparent via-black/80 to-black z-[-1] pointer-events-none">
            </div>
        </div>
        <div class="absolute inset-x-0 -top-40 -z-10 transform-gpu overflow-hidden blur-3xl sm:-top-80"
             aria-hidden="true">
            <div class="relative left-[calc(50%-11rem)] aspect-1155/678 w-[36.125rem] -translate-x-1/2 rotate-[30deg] bg-linear-to-tr from-[#ff80b5] to-[#9089fc] opacity-30 sm:left-[calc(50%-30rem)] sm:w-[72.1875rem]"
                 style="clip-path: polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)">
            </div>
        </div>
        <div class="mx-auto max-w-2xl py-32 sm:py-48 lg:py-56">
            <div class="hidden sm:mb-8 sm:flex sm:justify-center">
                <div
                        class="relative rounded-full px-3 py-1 text-sm/6 text-white ring-1 ring-white/30 hover:ring-white/50 bg-white/5 backdrop-blur">
                    Announcing our next round of promotion. <a href="<%= request.getContextPath() %>/promotions.jsp" class="font-semibold text-cyan-400"><span
                        class="absolute inset-0" aria-hidden="true"></span>Read more <span
                        aria-hidden="true">&rarr;</span></a>
                </div>
            </div>
            <div class="text-center">
                <h1 class="text-5xl font-semibold tracking-tight text-balance text-white sm:text-7xl">Upgrade Your
                    Tech Empower Your Life</h1>
                <p class="mt-8 text-lg font-medium text-pretty text-white/80 sm:text-xl/8">Explore the latest
                    Samseng smartphones and accessories—designed to keep you connected, productive, and inspired
                    every day.</p>

                <div class="mt-10 flex items-center justify-center gap-x-6">

                    <a href="#about">
                        <button class="hero-animated-button">
                            <svg class="arr-2" fill="#000000" height="200px" width="200px" version="1.1"
                                 id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 330 330"
                                 xml:space="preserve">
                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                <g id="SVGRepo_iconCarrier">
                                    <path id="XMLID_24_"
                                          d="M216.358,271.76c-2.322-5.605-7.792-9.26-13.858-9.26H180V15c0-8.284-6.716-15-15-15 c-8.284,0-15,6.716-15,15v247.5h-22.5c-6.067,0-11.537,3.655-13.858,9.26c-2.321,5.605-1.038,12.057,3.252,16.347l37.5,37.5 C157.322,328.536,161.161,330,165,330s7.678-1.464,10.607-4.394l37.5-37.5C217.396,283.816,218.68,277.365,216.358,271.76z">
                                    </path>
                                </g>
                                </svg>
                            <span class="text">Learn More</span>
                            <span class="circle"></span>
                            <svg class="arr-1" fill="#000000" height="200px" width="200px" version="1.1"
                                 id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 330 330"
                                 xml:space="preserve">
                                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                                <g id="SVGRepo_iconCarrier">
                                    <path id="XMLID_24_"
                                          d="M216.358,271.76c-2.322-5.605-7.792-9.26-13.858-9.26H180V15c0-8.284-6.716-15-15-15 c-8.284,0-15,6.716-15,15v247.5h-22.5c-6.067,0-11.537,3.655-13.858,9.26c-2.321,5.605-1.038,12.057,3.252,16.347l37.5,37.5 C157.322,328.536,161.161,330,165,330s7.678-1.464,10.607-4.394l37.5-37.5C217.396,283.816,218.68,277.365,216.358,271.76z">
                                    </path>
                                </g>
                                </svg>
                        </button>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="relative z-10 -mt-24 h-52 bg-gradient-to-b from-transparent via-black/80 to-black"></div>
</div>

<div class="h-screen bg-black">
    <div class="relative z-10 flex h-screen justify-center items-center text-center px-6">
        <h2 class="text-3xl md:text-4xl font-bold text-white leading-snug max-w-4xl">
            Empowering lifestyles through cutting-edge innovation — from flagship smartphones and immersive TVs to
            smart accessories that enhance everyday life.
        </h2>
    </div>
</div>


<div class="relative isolate" id="about">
    <div class="relative z-10 -mt-24 h-52 bg-gradient-to-b from-black via-black/80 to-transparent"></div>
    <video autoplay muted loop playsinline class="absolute inset-0 w-full h-full object-cover z-[-1]">
        <source src="<%= request.getContextPath() %>/static/video/background2.mp4" type="video/mp4"/>
        Your browser does not support the video tag.
    </video>
    <div class="h-screen flex items-center justify-center bg-cover bg-center bg-no-repeat px-4">
        <div
                class="card flex flex-col sm:flex-row items-center sm:items-start text-center sm:text-left max-w-6xl w-full bg-white/10 backdrop-blur-2xl border border-white/20 rounded-3xl overflow-hidden shadow-2xl text-white p-8 gap-10">
            <figure class="w-full max-w-xs">
                <img src="https://media.istockphoto.com/id/943067460/photo/male-it-specialist-holds-laptop-and-discusses-work-with-female-server-technician-theyre.jpg?s=612x612&w=0&k=20&c=851ArmF2ooz-2yQCRCWkjJLCYwDdpTCYzPinl9WgA_s="
                     alt="Who We Are" class="rounded-2xl w-full h-auto object-cover shadow-md mx-auto">
            </figure>
            <div class="card-body p-0 flex flex-col justify-center items-center sm:items-start">
                <h2 class="text-4xl font-bold mb-4 leading-tight">Who We Are</h2>
                <p class="text-lg text-white/90 leading-relaxed max-w-xl">
                    At Samseng, we are driven by innovation and inspired by real human needs. We design cutting-edge
                    mobile devices,
                    smart TVs, and connected accessories that power everyday life. Trusted by over <strong>12
                    million users</strong> worldwide.
                </p>
            </div>
        </div>
    </div>
    <div class="h-screen flex items-center justify-center bg-cover bg-center bg-no-repeat px-4">
        <div
                class="card flex flex-col sm:flex-row items-center sm:items-start text-center sm:text-left max-w-6xl w-full bg-white/10 backdrop-blur-2xl border border-white/20 rounded-3xl overflow-hidden shadow-2xl text-white p-8 gap-10">
            <div class="card-body p-0 flex flex-col justify-center items-center sm:items-start">
                <h2 class="text-4xl font-bold mb-4 leading-tight">What We Do</h2>
                <p class="text-lg text-white/90 leading-relaxed max-w-xl">
                    From ultra-fast smartphones to immersive displays and smart accessories, we create seamless
                    experiences for work,
                    play, and everything in between. Proudly shipping to <strong>50+ countries</strong> and
                    supporting <strong>200+ retailers</strong>.
                </p>
            </div>
            <figure class="w-full max-w-xs">
                <img src="https://media.istockphoto.com/id/1390456645/photo/metaverse-and-blockchain-technology-concepts-person-with-an-experiences-of-metaverse-virtual.jpg?s=612x612&w=0&k=20&c=eoKihFdi8QF2s2WomQJxpiy-pvM5tKLYAIaWdP_kQwc="
                     alt="What We Do" class="rounded-2xl w-full h-auto object-cover shadow-md mx-auto">
            </figure>

        </div>
    </div>
    <div class="h-screen flex items-center justify-center bg-cover bg-center bg-no-repeat px-4">
        <div
                class="card flex flex-col sm:flex-row items-center sm:items-start text-center sm:text-left max-w-6xl w-full bg-white/10 backdrop-blur-2xl border border-white/20 rounded-3xl overflow-hidden shadow-2xl text-white p-8 gap-10">
            <figure class="w-full max-w-xs">
                <img src="https://media.istockphoto.com/id/1346125184/photo/group-of-successful-multiethnic-business-team.jpg?s=612x612&w=0&k=20&c=5FHgRQZSZed536rHji6w8o5Hco9JVMRe8bpgTa69hE8="
                     alt="Why Choose Us" class="rounded-2xl w-full h-auto object-cover shadow-md mx-auto">
            </figure>
            <div class="card-body p-0 flex flex-col justify-center items-center sm:items-start">
                <h2 class="text-4xl font-bold mb-4 leading-tight">Why Choose Us</h2>
                <p class="text-lg text-white/90 leading-relaxed max-w-xl">
                    Our mission is to redefine modern tech living. With a <strong>99.8% satisfaction rate</strong>
                    and award-winning support,
                    Samseng delivers not just devices—but an entire lifestyle built on excellence and trust.
                </p>
            </div>
        </div>
    </div>
</div>

<div data-theme="light" class="flex flex-col items-center justify-center py-20 px-4 bg-base-100 text-secondary">
    <h1 class="text-4xl font-bold text-center mb-8">
        Looking for something else?
    </h1>

    <div class="flex items-center w-full max-w-md mb-4">
        <div class="relative w-full">
            <div class="absolute inset-y-0 left-0 flex items-center pl-4 pointer-events-none">
                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-4.35-4.35m0 0A7.5 7.5 0 1110.5 3a7.5 7.5 0 016.15 13.65z"/>
                </svg>
            </div>
            <form action="./products">
            <input
                    type="text"
                    name="name"
                    placeholder="Search Keyword"
                    class="w-full pl-12 pr-4 py-3 border border-4 rounded-full focus:ring-2 focus:ring-primary focus:outline-none"
            />
            </form>
        </div>
    </div>
    <div class="my-4 text-xl font-bold">
        <h1>Here are our Top Selling Products:</h1>
    </div>

    <div class="flex flex-wrap justify-center gap-4">
        <a class="btn px-6 py-2 rounded-full border border-gray-300 bg-white hover:bg-gray-100" href="${pageContext.request.contextPath}/product?productId=SP-S25U">
            Galaxy S25 Ultra
        </a>
        <a class="btn px-6 py-2 rounded-full border border-gray-300 bg-white hover:bg-gray-100" href="${pageContext.request.contextPath}/product?productId=MT-OG7">
            Olympus G7 Monitor
        </a>
        <a class="btn px-6 py-2 rounded-full border border-gray-300 bg-white hover:bg-gray-100" href="${pageContext.request.contextPath}/product?productId=T-S10">
            Milkyway Tab S10
        </a>
        <a class="btn px-6 py-2 rounded-full border border-gray-300 bg-white hover:bg-gray-100" href="${pageContext.request.contextPath}/product?productId=WT-SW7">
            Sirius Smartwatch 7
        </a>
        <a class="btn px-6 py-2 rounded-full border border-gray-300 bg-white hover:bg-gray-100" href="${pageContext.request.contextPath}/product?productId=B-AB2">
            Sirius Buds2
        </a>
    </div>
</div>

<%@ include file="/general/userFooter.jsp" %>

<script>
    const heroVideo = document.getElementById('hero-video');

    // Check if video pauses unexpectedly
    heroVideo.addEventListener('pause', () => {
        heroVideo.play().catch(e => console.warn("Autoplay blocked or error:", e));
    });

    // Optional: Retry every few seconds
    setInterval(() => {
        if (heroVideo.paused) {
            heroVideo.play().catch(e => console.warn("Retry autoplay error:", e));
        }
    }, 5000); // retry every 5s
</script>

</body>

</html>