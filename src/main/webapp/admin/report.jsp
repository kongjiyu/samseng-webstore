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
    <title>Sales Analytics Report</title>
    <link href="<%= request.getContextPath() %>/static/css/output.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/static/js/flyonui.js"></script>

</head>
<body class="min-h-screen bg-gray-50 flex flex-col items-center justify-center">
<%@ include file="/general/adminHeader.jsp" %>

<div class="p-6 w-full">
    <!-- Stats Overview -->
    <div class="stats shadow mb-6 w-full">
        <div class="stat">
            <div class="stat-title">Total Orders</div>
            <div class="stat-value">12,540</div>
            <div class="stat-desc text-success">▲ 15% this month</div>
        </div>
        <div class="stat">
            <div class="stat-title">New Customers</div>
            <div class="stat-value">4,325</div>
            <div class="stat-desc text-success">▲ 9% from last month</div>
        </div>
        <div class="stat">
            <div class="stat-title">Revenue</div>
            <div class="stat-value">RM102,450</div>
            <div class="stat-desc text-success">▲ 11.3%</div>
        </div>
        <div class="stat">
            <div class="stat-title">Avg. Order Value</div>
            <div class="stat-value">RM81.70</div>
            <div class="stat-desc">Stable</div>
        </div>
    </div>

    <!-- Chart Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="card p-4 h-[400px]">
            <h3 class="text-lg font-bold mb-2">Monthly Sales</h3>
            <canvas id="monthlySalesChart"></canvas>
        </div>
        <div class="card p-4 h-[400px]">
            <h3 class="text-lg font-bold mb-2">Revenue By Category</h3>
            <canvas id="revenueByCategoryChart" height="300px"></canvas>
        </div>
        <div class="card p-4 h-[400px]">
            <h3 class="text-lg font-bold mb-2">Traffic Sources</h3>
            <canvas id="trafficSourceChart"></canvas>
        </div>
        <div class="card p-4 h-[400px]">
            <h3 class="text-lg font-bold mb-2">Top Product Sales</h3>
            <canvas id="chart-top-sales"></canvas>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    //top sales chart
    fetch("<%= request.getContextPath() %>/api/reports/monthly-sales")
    .then(res => res.json())
    .then(data => {
        const ctx = document.getElementById("monthlySalesChart").getContext("2d");
        new Chart(ctx, {
            type: "line",
            data: {
                labels: data.labels, // e.g., ["2024-11", "2024-12", ..., "2025-04"]
                datasets: data.datasets.map((ds, index) => ({
                    ...ds,
                    borderColor: getColor(index),
                    backgroundColor: getColor(index),
                }))
            },
            options: {
                responsive: true,
                plugins: {
                    title: {
                        display: true,
                        text: 'Monthly Sales Trends for Top 5 Products'
                    }
                }
            }
        });
    });

function getColor(index) {
    const colors = ["#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0", "#9966FF"];
    return colors[index % colors.length];
}

    //revenue-by-category
    fetch('/api/reports/revenue-by-category')
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('revenueByCategoryChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: data.datasets.map((ds, index) => ({
                        ...ds,
                        borderColor: getColor(index),
                        backgroundColor: getColor(index),
                    }))
                },
                options: {
                    responsive: true
                }
            });
        });

    // Top Sales (dynamic example kept)
    fetch('<%= request.getContextPath() %>/api/reports/top-products')
        .then(response => response.json())
        .then(data => {
            new Chart(document.getElementById('chart-top-sales'), {
                type: 'bar',
                data: {
                    labels: data.products,
                    datasets: [{label: 'Units Sold', data: data.quantities, backgroundColor: '#60a5fa'}]
                },
                options: {responsive: true, scales: {y: {beginAtZero: true}}}
            });
        });
</script>
</body>
</html>
