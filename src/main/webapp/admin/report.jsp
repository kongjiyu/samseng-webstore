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
<body data-theme="light" class="min-h-screen bg-gray-50 flex flex-col items-center justify-center">
<%@ include file="/general/adminHeader.jsp" %>

<div class="p-6 w-full">
    <!-- Stats Overview -->
    <div class="stats shadow mb-6 w-full">
        <div class="stat">
            <div class="stat-title">Total Orders</div>
            <div class="stat-value" id="totalOrders">-</div>
            <div class="stat-desc text-success">▲ 15% this month</div>
        </div>
        <div class="stat">
            <div class="stat-title">Today Orders</div>
            <div class="stat-value" id="todayOrders">-</div>
            <div class="stat-desc text-success">▲ 9% from last month</div>
        </div>
        <div class="stat">
            <div class="stat-title">Revenue</div>
            <div class="stat-value" id="revenue">-</div>
            <div class="stat-desc text-success">▲ 11.3%</div>
        </div>
        <div class="stat">
            <div class="stat-title">Avg. Order Value</div>
            <div class="stat-value" id="avgOrderValue">-</div>
            <div class="stat-desc">Stable</div>
        </div>
    </div>

    <!-- Chart Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="card p-4 h-[500px]">
            <h3 class="text-lg font-bold mb-2">Monthly Sales</h3>
            <canvas id="monthlySalesChart"></canvas>
        </div>
        <div class="card p-4 h-[500px]">
            <h3 class="text-lg font-bold mb-2">Revenue By Category</h3>
            <canvas id="revenueByCategoryChart"></canvas>
        </div>
        <div class="card p-4 h-[500px]">
            <h3 class="text-lg font-bold mb-2">Top Product Sales</h3>
            <canvas id="chart-top-sales"></canvas>
        </div>
        <div class="card p-4 h-[500px]">
            <h3 class="text-lg font-bold mb-2">Revenue Trends</h3>
            <canvas id="revenue-trends"></canvas>
        </div>
    </div>
</div>
<%@include file="/general/userFooter.jsp"%>

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


    fetch('<%= request.getContextPath() %>/api/reports/revenue-trends')
        .then(response => response.json())
        .then(data => {
            new Chart(document.getElementById('revenue-trends'), {
                type: 'line',
                data: {
                    labels: data.labels, // <-- Now uses real fetched labels
                    datasets: data.datasets // <-- Now uses real fetched datasets
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Revenue'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Month'
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
                        },
                        tooltip: {
                            enabled: true
                        }
                    }
                }
            });
        });

    fetch('<%= request.getContextPath() %>/api/reports/overview')
        .then(response => response.json())
        .then(data => {
            console.log(data);
            document.getElementById('totalOrders').innerText = data.totalOrders.toLocaleString();
            document.getElementById('todayOrders').innerText = data.todayOrders.toLocaleString();
            document.getElementById('revenue').innerText = 'RM' + parseFloat(data.revenue).toLocaleString();
            document.getElementById('avgOrderValue').innerText = 'RM' + parseFloat(data.avgOrderValue).toFixed(2);

            updateStatDesc('totalOrders', data.totalOrdersChange, "this month");
            updateStatDesc('todayOrders', data.todayOrdersChange, "since yesterday");
            updateStatDesc('revenue', data.revenueChange, "this month");
            updateStatDesc('avgOrderValue', data.avgOrderValueChange, "this month");
        })
        .catch(err => {
            console.log(err)
        });

    function updateStatDesc(statId, changePercent, compareText) {
        console.log(changePercent);
        const stat = document.getElementById(statId).parentNode;
        const statDesc = stat.querySelector('.stat-desc');
        if (changePercent > 0) {
            statDesc.className = "stat-desc text-success";
            statDesc.innerHTML = "▲ " + changePercent.toFixed(1) + "% "+ compareText;
        } else if (changePercent < 0) {
            statDesc.className = "stat-desc text-error";
            statDesc.innerHTML = "▼ " + Math.abs(changePercent).toFixed(1) + "% " + compareText;
        } else {
            statDesc.className = "stat-desc text-neutral";
            statDesc.innerHTML = `Stable`;
        }
    }
</script>
</body>
</html>
