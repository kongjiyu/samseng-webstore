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
import lombok.extern.log4j.Log4j2;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Log4j2
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
        try {
            log.info("Fetching top selling products");
            List<Object[]> results = orderProductRepository.getTopSellingProducts();

            if (results == null || results.isEmpty()) {
                log.warn("No top selling products found");
                return Response.ok(Json.createObjectBuilder()
                        .add("message", "No data available")
                        .build()).build();
            }

            JsonArrayBuilder productNamesBuilder = Json.createArrayBuilder();
            JsonArrayBuilder quantitiesBuilder = Json.createArrayBuilder();

            for (Object[] row : results) {
                productNamesBuilder.add((String) row[0]);
                quantitiesBuilder.add(((Number) row[1]).intValue());
            }

            JsonObjectBuilder responseBuilder = Json.createObjectBuilder();
            responseBuilder.add("products", productNamesBuilder);
            responseBuilder.add("quantities", quantitiesBuilder);

            log.info("Successfully retrieved top selling products");
            return Response.ok(responseBuilder.build()).build();
        } catch (Exception e) {
            log.error("Error fetching top selling products", e);
            return Response.serverError()
                    .entity(Json.createObjectBuilder()
                            .add("error", "Failed to fetch top selling products")
                            .build())
                    .build();
        }
    }

    @GET
    @Path("/monthly-sales")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getMonthlySalesForTopProducts() {
        try {
            log.info("Fetching monthly sales for top products");
            List<String> topProductIds = orderProductRepository.findTop5ProductIdsInLast6Months();
            
            if (topProductIds == null || topProductIds.isEmpty()) {
                log.warn("No top products found for monthly sales");
                return Response.ok(Json.createObjectBuilder()
                        .add("message", "No data available")
                        .build()).build();
            }

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

            List<String> labels = getLast6MonthsLabels();
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

            log.info("Successfully retrieved monthly sales for top products");
            return Response.ok(responseBuilder.build()).build();
        } catch (Exception e) {
            log.error("Error fetching monthly sales for top products", e);
            return Response.serverError()
                    .entity(Json.createObjectBuilder()
                            .add("error", "Failed to fetch monthly sales data")
                            .build())
                    .build();
        }
    }

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
        try {
            log.info("Fetching revenue by category");
            List<Object[]> results = orderProductRepository.findRevenueByProductCategory();

            if (results == null || results.isEmpty()) {
                log.warn("No revenue data by category found");
                return Response.ok(Json.createObjectBuilder()
                        .add("message", "No data available")
                        .build()).build();
            }

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

            log.info("Successfully retrieved revenue by category");
            return Response.ok(responseBuilder.build()).build();
        } catch (Exception e) {
            log.error("Error fetching revenue by category", e);
            return Response.serverError()
                    .entity(Json.createObjectBuilder()
                            .add("error", "Failed to fetch revenue by category")
                            .build())
                    .build();
        }
    }

    @GET
    @Path("/revenue-trends")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getMonthlyRevenueTrends() {
        try {
            log.info("Fetching monthly revenue trends");
            List<String> last12Months = getLast12MonthsLabels();
            List<Object[]> revenueData = salesOrderRepository.findRevenueLast12Months();

            if (revenueData == null || revenueData.isEmpty()) {
                log.warn("No revenue trends data found");
                return Response.ok(Json.createObjectBuilder()
                        .add("message", "No data available")
                        .build()).build();
            }

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

            log.info("Successfully retrieved monthly revenue trends");
            return Response.ok(responseBuilder.build()).build();
        } catch (Exception e) {
            log.error("Error fetching monthly revenue trends", e);
            return Response.serverError()
                    .entity(Json.createObjectBuilder()
                            .add("error", "Failed to fetch revenue trends")
                            .build())
                    .build();
        }
    }

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
        try {
            log.info("Fetching overview statistics");
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

            log.info("Successfully retrieved overview statistics");
            return Response.ok(responseBuilder.build()).build();
        } catch (Exception e) {
            log.error("Error fetching overview statistics", e);
            return Response.serverError()
                    .entity(Json.createObjectBuilder()
                            .add("error", "Failed to fetch overview statistics")
                            .build())
                    .build();
        }
    }

    private double calculatePercentageChange(Number oldVal, Number newVal) {
        if (oldVal == null || oldVal.doubleValue() == 0.0) {
            return 0.0;
        }
        return ((newVal.doubleValue() - oldVal.doubleValue()) / Math.abs(oldVal.doubleValue())) * 100;
    }
}