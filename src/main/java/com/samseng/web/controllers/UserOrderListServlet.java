package com.samseng.web.controllers;

import com.samseng.web.dto.OrderListingDTO;
import com.samseng.web.models.*;
import com.samseng.web.repositories.Account.AccountRepository;
import com.samseng.web.repositories.Sales_Order.Sales_OrderRepository;
import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;

import java.io.IOException;
import java.util.List;

@Log4j2
@WebServlet("/user/orders")
public class UserOrderListServlet extends HttpServlet {
    @Inject
    private Sales_OrderRepository salesOrderRepository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        try {
            // Get and validate user
            Account user = (Account) session.getAttribute("profile");
            if (user == null) {
                log.warn("Unauthorized access attempt to order list");
                session.setAttribute("toastMessage", "Please login to view your orders.");
                session.setAttribute("toastType", "error");
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }

            String userId = user.getId();
            log.info("Fetching orders for user: {}", user.getEmail());

            // Get the list of orders
            List<Sales_Order> orders = salesOrderRepository.findByUserIdPaged(userId);
            
            if (orders == null) {
                log.warn("Null orders list returned for user: {}", user.getEmail());
                session.setAttribute("toastMessage", "Error retrieving orders. Please try again.");
                session.setAttribute("toastType", "error");
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }

            // Convert into DTO
            List<OrderListingDTO> dtos = orders.stream()
                    .map(o -> {
                        try {
                            return new OrderListingDTO(
                                    o.getId(),
                                    o.getNetPrice(),
                                    o.getStatus(),
                                    o.getOrderedDate(),
                                    o.getUser().getUsername(),
                                    o.getUser().getEmail()
                            );
                        } catch (Exception e) {
                            log.error("Error converting order to DTO: {}", o.getId(), e);
                            return null;
                        }
                    })
                    .filter(dto -> dto != null)
                    .toList();

            if (dtos.isEmpty() && !orders.isEmpty()) {
                log.error("All order conversions failed for user: {}", user.getEmail());
                session.setAttribute("toastMessage", "Error processing orders. Please try again.");
                session.setAttribute("toastType", "error");
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }

            // Pass "orders" dto to jsp
            req.setAttribute("orders", dtos);

            if (dtos.isEmpty()) {
                log.info("No orders found for user: {}", user.getEmail());
                session.setAttribute("toastMessage", "You have no orders yet.");
                session.setAttribute("toastType", "info");
            } else {
                log.info("Successfully retrieved {} orders for user: {}", dtos.size(), user.getEmail());
            }

            // Forward to JSP
            RequestDispatcher view = req.getRequestDispatcher("/user/orderList.jsp");
            view.forward(req, resp);

        } catch (Exception e) {
            log.error("Error retrieving order list", e);
            session.setAttribute("toastMessage", "An error occurred while retrieving your orders.");
            session.setAttribute("toastType", "error");
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
}
