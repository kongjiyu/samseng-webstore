package com.samseng.web.controllers;

import com.samseng.web.dto.OrderListingDTO;
import com.samseng.web.models.Sales_Order;
import com.samseng.web.repositories.Sales_Order.Sales_OrderRepository;
import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderListServlet extends HttpServlet {
    @Inject
    private Sales_OrderRepository salesOrderRepository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Load all orders without pagination or search
        List<Sales_Order> orders = salesOrderRepository.findAll();

        // Convert into DTO
        List<OrderListingDTO> dtos = orders.stream()
                .map(o -> new OrderListingDTO(
                        o.getId(),
                        o.getNetPrice(),
                        o.getStatus(),
                        o.getOrderedDate(),
                        o.getUser().getUsername(),
                        o.getUser().getEmail()
                ))
                .toList();

        // Set attributes for JSP
        req.setAttribute("orders", dtos);

        // Forward to JSP
        RequestDispatcher view = req.getRequestDispatcher("/admin/orderList.jsp");
        view.forward(req, resp);
    }
}