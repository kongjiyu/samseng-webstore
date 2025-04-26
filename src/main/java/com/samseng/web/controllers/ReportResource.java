package com.samseng.web.controllers;

import com.samseng.web.repositories.Order_Product.Order_ProductRepository;
import com.samseng.web.repositories.Product.ProductRepository;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

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
    private Order_ProductRepository orderProductRepository;

    @Inject
    private ProductRepository productRepository;

    @GET
    @Path("/top-products")
    public Response getTopSellingProducts() {
        List<Object[]> results = orderProductRepository.getTopSellingProducts();

        List<String> productNames = new ArrayList<>();
        List<Integer> quantities = new ArrayList<>();

        for (Object[] row : results) {
            productNames.add((String) row[0]);
            quantities.add(((Number) row[1]).intValue());
        }

        Map<String, Object> response = new HashMap<>();
        response.put("products", productNames);
        response.put("quantities", quantities);

        return Response.ok(response).build();
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
        List<Map<String, Object>> datasets = new ArrayList<>();

        for (String productName : productMonthlySales.keySet()) {
            Map<String, Object> dataset = new HashMap<>();
            dataset.put("label", productName);
            dataset.put("fill", false);
            dataset.put("borderWidth", 3);
            dataset.put("data", labels.stream()
                    .map(month -> productMonthlySales.get(productName).getOrDefault(month, 0))
                    .collect(Collectors.toList()));
            datasets.add(dataset);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("labels", labels);
        response.put("datasets", datasets);

        return Response.ok(response).build();
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

        List<Map<String, Object>> datasets = new ArrayList<>();
        List<String> labels = new ArrayList<>();
        List<Double> data = new ArrayList<>();

        for (Object[] row : results) {
            String category = (String) row[0];
            Double revenue = ((Number) row[1]).doubleValue();

            labels.add(category);
            data.add(revenue);
        }

        Map<String, Object> dataset = new HashMap<>();
        dataset.put("label", "Revenue");
        dataset.put("data", data);

        datasets.add(dataset);

        Map<String, Object> response = new HashMap<>();
        response.put("labels", labels);
        response.put("datasets", datasets);

        return Response.ok(response).build();
    }
}