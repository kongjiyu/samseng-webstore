package com.samseng.web.controllers;

import com.samseng.web.repositories.Order_Product.Order_ProductRepository;
import com.samseng.web.repositories.Product.ProductRepository;
import com.samseng.web.repositories.Sales_Order.Sales_OrderRepository;
import jakarta.inject.Inject;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Path("/reports")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ReportResource {
    @Inject
    private Sales_OrderRepository salesOrderRepository;

    @Inject
    private Order_ProductRepository orderProductRepository;

    @Inject
    private ProductRepository productRepository;

    @GET
    @Path("/top-products")
    public Response getTopSellingProducts() {
        List<Object[]> results = orderProductRepository.getTopSellingProducts();

        JsonArrayBuilder productNamesBuilder = Json.createArrayBuilder();
        JsonArrayBuilder quantitiesBuilder = Json.createArrayBuilder();

        for (Object[] row : results) {
            productNamesBuilder.add((String) row[0]);
            quantitiesBuilder.add(((Number) row[1]).intValue());
        }

        JsonObjectBuilder responseBuilder = Json.createObjectBuilder();
        responseBuilder.add("products", productNamesBuilder);
        responseBuilder.add("quantities", quantitiesBuilder);

        return Response.ok(responseBuilder.build()).build();
    }

    @GET
    @Path("/monthly-sales")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getMonthlySalesForTopProducts() {
        List<String> topProductIds = orderProductRepository.findTop5ProductIdsInLast6Months();
        List<Object[]> salesData = orderProductRepository.findMonthlySalesForTopProducts(topProductIds);

        Map<String, Map<String, Integer>> productMonthlySales = new HashMap<>();

        for (Object[] row : salesData) {
            String productId = (String) row[0];
            String productName = productRepository.findById(productId).getName();
            String month = (String) row[1];
            Integer quantity = ((Number) row[2]).intValue();

            productMonthlySales
                    .computeIfAbsent(productName, k -> new HashMap<>())
                    .put(month, quantity);
        }

        // Prepare response structure
        List<String> labels = getLast6MonthsLabels(); // Helper to generate "2024-11", "2024-12", ...
        JsonArrayBuilder labelsBuilder = Json.createArrayBuilder();
        for (String label : labels) {
            labelsBuilder.add(label);
        }

        JsonArrayBuilder datasetsBuilder = Json.createArrayBuilder();

        for (String productName : productMonthlySales.keySet()) {
            JsonArrayBuilder dataBuilder = Json.createArrayBuilder();
            for (String month : labels) {
                dataBuilder.add(productMonthlySales.get(productName).getOrDefault(month, 0));
            }

            JsonObjectBuilder datasetBuilder = Json.createObjectBuilder();
            datasetBuilder.add("label", productName);
            datasetBuilder.add("fill", false);
            datasetBuilder.add("borderWidth", 3);
            datasetBuilder.add("data", dataBuilder);

            datasetsBuilder.add(datasetBuilder);
        }

        JsonObjectBuilder responseBuilder = Json.createObjectBuilder();
        responseBuilder.add("labels", labelsBuilder);
        responseBuilder.add("datasets", datasetsBuilder);

        return Response.ok(responseBuilder.build()).build();
    }

    // Generate last 6 month labels like "2024-11", "2024-12", ...
    private List<String> getLast6MonthsLabels() {
        List<String> months = new ArrayList<>();
        LocalDate now = LocalDate.now();
        for (int i = 5; i >= 0; i--) {
            months.add(now.minusMonths(i).format(DateTimeFormatter.ofPattern("yyyy-MM")));
        }
        return months;
    }

    @GET
    @Path("/revenue-by-category")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getRevenueByCategory() {
        List<Object[]> results = orderProductRepository.findRevenueByProductCategory();

        JsonArrayBuilder labelsBuilder = Json.createArrayBuilder();
        JsonArrayBuilder dataBuilder = Json.createArrayBuilder();

        for (Object[] row : results) {
            String category = (String) row[0];
            Double revenue = ((Number) row[1]).doubleValue();

            labelsBuilder.add(category);
            dataBuilder.add(revenue);
        }

        JsonObjectBuilder datasetBuilder = Json.createObjectBuilder();
        datasetBuilder.add("label", "Revenue");
        datasetBuilder.add("data", dataBuilder);

        JsonArrayBuilder datasetsBuilder = Json.createArrayBuilder();
        datasetsBuilder.add(datasetBuilder);

        JsonObjectBuilder responseBuilder = Json.createObjectBuilder();
        responseBuilder.add("labels", labelsBuilder);
        responseBuilder.add("datasets", datasetsBuilder);

        return Response.ok(responseBuilder.build()).build();
    }

    @GET
    @Path("/revenue-trends")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getMonthlyRevenueTrends() {
        List<String> last12Months = getLast12MonthsLabels();
        List<Object[]> revenueData = salesOrderRepository.findRevenueLast12Months();

        Map<String, Double> revenueMap = new HashMap<>();
        for (Object[] row : revenueData) {
            String month = (String) row[0];
            Double revenue = ((Number) row[1]).doubleValue();
            revenueMap.put(month, revenue);
        }

        JsonArrayBuilder revenueValuesBuilder = Json.createArrayBuilder();
        for (String month : last12Months) {
            revenueValuesBuilder.add(revenueMap.getOrDefault(month, 0.0));
        }

        JsonObjectBuilder datasetBuilder = Json.createObjectBuilder();
        datasetBuilder.add("label", "Monthly Revenue");
        datasetBuilder.add("data", revenueValuesBuilder);
        datasetBuilder.add("fill", "start");
        datasetBuilder.add("borderWidth", 3);

        JsonArrayBuilder datasetsBuilder = Json.createArrayBuilder();
        datasetsBuilder.add(datasetBuilder);

        JsonArrayBuilder labelsBuilder = Json.createArrayBuilder();
        for (String label : last12Months) {
            labelsBuilder.add(label);
        }

        JsonObjectBuilder responseBuilder = Json.createObjectBuilder();
        responseBuilder.add("labels", labelsBuilder);
        responseBuilder.add("datasets", datasetsBuilder);

        return Response.ok(responseBuilder.build()).build();
    }

    // Generate last 12 month labels like "2024-05", "2024-06", ...
    private List<String> getLast12MonthsLabels() {
        List<String> months = new ArrayList<>();
        LocalDate now = LocalDate.now();
        for (int i = 11; i >= 0; i--) {
            months.add(now.minusMonths(i).format(DateTimeFormatter.ofPattern("yyyy-MM")));
        }
        return months;
    }

    @GET
    @Path("/overview")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getOverviewStats() {
        JsonObjectBuilder responseBuilder = Json.createObjectBuilder();

        long totalOrdersThisMonth = salesOrderRepository.getTotalOrdersThisMonth();
        long totalOrdersLastMonth = salesOrderRepository.getTotalOrdersLastMonth();
        BigDecimal revenueThisMonth = salesOrderRepository.getRevenueThisMonth();
        BigDecimal revenueLastMonth = salesOrderRepository.getRevenueLastMonth();
        BigDecimal avgOrderValueThisMonth = salesOrderRepository.getAvgOrderValueThisMonth();
        BigDecimal avgOrderValueLastMonth = salesOrderRepository.getAvgOrderValueLastMonth();
        long todayOrders = salesOrderRepository.getTodayOrders();
        long yesterdayOrders = salesOrderRepository.getYesterdayOrders();

        responseBuilder.add("totalOrders", totalOrdersThisMonth);
        responseBuilder.add("totalOrdersChange", calculatePercentageChange(totalOrdersLastMonth, totalOrdersThisMonth));

        responseBuilder.add("revenue", revenueThisMonth);
        responseBuilder.add("revenueChange", calculatePercentageChange(revenueLastMonth, revenueThisMonth));

        responseBuilder.add("avgOrderValue", avgOrderValueThisMonth);
        responseBuilder.add("avgOrderValueChange", calculatePercentageChange(avgOrderValueLastMonth, avgOrderValueThisMonth));

        responseBuilder.add("todayOrders", todayOrders);
        responseBuilder.add("todayOrdersChange", calculatePercentageChange(yesterdayOrders, todayOrders));

        return Response.ok(responseBuilder.build()).build();
    }

    // Helper function
    private double calculatePercentageChange(Number oldVal, Number newVal) {
        if (oldVal == null || oldVal.doubleValue() == 0.0) {
            return 0.0;
        }
        return ((newVal.doubleValue() - oldVal.doubleValue()) / Math.abs(oldVal.doubleValue())) * 100;
    }
}