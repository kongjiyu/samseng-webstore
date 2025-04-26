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
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("updateStatus".equals(action)) {
            String orderId   = req.getParameter("orderId");
            String newStatus = req.getParameter("newStatus");
            salesOrderRepository.updateStatus(orderId, newStatus);
            // you could set a flash-style message here:
            req.getSession().setAttribute("msg", "Order " + orderId + " status changed to " + newStatus);
        }
        // after POST, redirect back to avoid form-resubmission
        resp.sendRedirect(req.getContextPath() + "/admin/orders?page=" + req.getParameter("currentPage"));
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchQuery = req.getParameter("searchQuery");
        int page     = 1;
        int pageSize = 5;
        String p     = req.getParameter("page");
        if (p != null && p.matches("\\d+")) page = Integer.parseInt(p);

        List<OrderListingDTO> dtos;
        long totalCount;
        int totalPages;
        int startItem;
        int endItem;

        if (searchQuery != null && !searchQuery.isBlank()) {
            Sales_Order order = salesOrderRepository.findById(searchQuery);

            if (order != null) {
                dtos = List.of(new OrderListingDTO(
                        order.getId(),
                        order.getNetPrice(),
                        order.getStatus(),
                        order.getOrderedDate(),
                        order.getUser().getUsername(),
                        order.getUser().getEmail()
                ));
                totalCount = 1;
            } else {
                dtos = List.of();
                totalCount = 0;
            }

            page = 1;
            totalPages  = 1;
            startItem   = totalCount > 0 ? 1 : 0;
            endItem     = totalCount > 0 ? 1 : 0;
        } else {
            // ----- normal paged listing -----
            totalCount = salesOrderRepository.count();
            totalPages = (int) Math.ceil((double) totalCount / pageSize);
            startItem  = (page - 1) * pageSize + 1;
            endItem    = (int) Math.min(page * pageSize, totalCount);

            List<Sales_Order> orders = salesOrderRepository.findPaged(page, pageSize);
            dtos = orders.stream()
                    .map(o -> new OrderListingDTO(
                            o.getId(), o.getNetPrice(), o.getStatus(),
                            o.getOrderedDate(), o.getUser().getUsername(), o.getUser().getEmail()
                    ))
                    .toList();
        }

        req.setAttribute("orders",      dtos);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages",  totalPages);
        req.setAttribute("startItem",   startItem);
        req.setAttribute("endItem",     endItem);
        req.setAttribute("totalItems",  totalCount);
        req.setAttribute("searchQuery", searchQuery);  // so JSP can preserve the term

        RequestDispatcher view = req.getRequestDispatcher("/admin/orderList.jsp");
        view.forward(req, resp);
    }
}
