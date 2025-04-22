<%--
  Created by IntelliJ IDEA.
  User: kongjy
  Date: 21/04/2025
  Time: 9:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Report</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>

</head>
<body class="min-h-screen bg-gray-50 flex flex-col items-center justify-center p-10">
<h1 class="text-2xl font-bold mb-6">Sales Report</h1>
<!-- Chart 1: Payment Timing -->
<div class="accordion-item accordion-item-active:scale-[1.05] accordion-item-active:mb-3 active transition-transform ease-in duration-300 delay-[1ms]" id="payment-popout">
    <button class="accordion-toggle inline-flex items-center gap-x-4 px-5 py-4 text-start" aria-controls="payment-popout-collapse" aria-expanded="true">
        <span class="icon-[tabler--plus] accordion-item-active:hidden text-base-content size-4.5 block shrink-0"></span>
        <span class="icon-[tabler--minus] accordion-item-active:block text-base-content size-4.5 hidden shrink-0"></span>
        Top Selling Product
    </button>
    <div id="payment-popout-collapse" class="accordion-content w-full overflow-hidden transition-[height] duration-300" aria-labelledby="payment-popout" role="region">
        <div class="px-5 pb-4">
            <canvas id="chart-top-sales" width="800" height="400"></canvas>
        </div>
    </div>
</div>

<div class="accordion-item accordion-item-active:scale-[1.05] accordion-item-active:mb-3 transition-transform ease-in duration-300 delay-[1ms]" id="monthly-sales-popout">
    <button class="accordion-toggle inline-flex items-center gap-x-4 px-5 py-4 text-start" aria-controls="monthly-sales-popout-collapse" aria-expanded="false">
        <span class="icon-[tabler--plus] accordion-item-active:hidden text-base-content size-4.5 block shrink-0"></span>
        <span class="icon-[tabler--minus] accordion-item-active:block text-base-content size-4.5 hidden shrink-0"></span>
        Monthly Sales Performance
    </button>
    <div id="monthly-sales-popout-collapse" class="accordion-content hidden w-full overflow-hidden transition-[height] duration-300" aria-labelledby="monthly-sales-popout" role="region">
        <div class="px-5 pb-4">
            <canvas id="chart-monthly-sales" width="800" height="400"></canvas>
        </div>
    </div>
</div>

<!-- Chart 2 to 10 -->
<% for(int i = 2; i <= 10; i++) { %>
<div class="accordion-item accordion-item-active:scale-[1.05] accordion-item-active:mb-3 active transition-transform ease-in duration-300 delay-[1ms]" id="report-<%= i %>-popout">
    <button class="accordion-toggle inline-flex items-center gap-x-4 px-5 py-4 text-start" aria-controls="report-<%= i %>-popout-collapse" aria-expanded="false">
        <span class="icon-[tabler--plus] accordion-item-active:hidden text-base-content size-4.5 block shrink-0"></span>
        <span class="icon-[tabler--minus] accordion-item-active:block text-base-content size-4.5 hidden shrink-0"></span>
        Report Chart <%= i %>
    </button>
    <div id="report-<%= i %>-popout-collapse"
         class="accordion-content hidden w-full overflow-hidden transition-[height] duration-300"
         aria-labelledby="report-<%= i %>-popout"
         role="region">
        <div class="px-5 pb-4">
            <canvas id="chart-<%= i %>" width="400" height="200"></canvas>
        </div>
    </div>
</div>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    fetch('<%= request.getContextPath() %>/api/reports/top-products')
        .then(response => response.json())
        .then(data => {
            const ctxTop = document.getElementById('chart-top-sales').getContext('2d');
            new Chart(ctxTop, {
                type: 'bar',
                data: {
                    labels: data.products,
                    datasets: [{
                        label: 'Units Sold',
                        data: data.quantities,
                        backgroundColor: 'rgba(54, 162, 235, 0.5)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: { responsive: true, scales: { y: { beginAtZero: true } } }
        });
    });
    fetch('<%= request.getContextPath() %>/api/reports/monthly-sales')
        .then(response => response.json())
        .then(data => {
            const ctxMonthly = document.getElementById('chart-monthly-sales').getContext('2d');
            new Chart(ctxMonthly, {
                type: 'line',
                data: {
                    labels: data.months,
                    datasets: [{
                        label: 'Sales (RM)',
                        data: data.sales,
                        borderColor: 'rgba(75, 192, 192, 1)',
                        tension: 0.3,
                        fill: true,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)'
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });
        });
</script>
</body>
</html>
