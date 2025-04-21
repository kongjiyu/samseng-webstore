package com.samseng.web.controllers;

import com.samseng.web.repositories.Order_Product.Order_ProductRepository;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Path("/reports")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ReportResource {

    @Inject
    private Order_ProductRepository orderProductRepository;

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
    public Response getMonthlySales() {
        List<Object[]> results = orderProductRepository.getMonthlySales(); // You’ll implement this next

        List<String> months = new ArrayList<>();
        List<Double> totals = new ArrayList<>();

        for (Object[] row : results) {
            months.add((String) row[0]); // e.g., "Jan", "Feb"
            totals.add(((Number) row[1]).doubleValue()); // sales amount
        }

        Map<String, Object> response = new HashMap<>();
        response.put("labels", months);
        response.put("data", totals);

        return Response.ok(response).build();
    }
}