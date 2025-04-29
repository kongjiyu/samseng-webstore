package com.samseng.web.controllers;

import com.samseng.web.models.*;
import com.samseng.web.repositories.Account.AccountRepository;
import com.samseng.web.repositories.Address.AddressRepository;
import com.samseng.web.repositories.Order_Product.Order_ProductRepository;
import com.samseng.web.repositories.Sales_Order.Sales_OrderRepository;
import com.samseng.web.repositories.Variant.VariantRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Log4j2
@WebServlet("/user/detail")
public class UserOrderDetail extends HttpServlet {
    @Inject
    private AccountRepository accountRepository;

    @Inject
    private Sales_OrderRepository orderRepository;

    @Inject
    private Order_ProductRepository productRepository;

    @Inject
    private AddressRepository addressRepository;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            String action = request.getParameter("action");
            
            if (action == null || action.trim().isEmpty()) {
                log.warn("Invalid action parameter in order detail request");
                session.setAttribute("toastMessage", "Invalid request. Please try again.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/user/orders.jsp");
                return;
            }

            if ("view".equals(action)) {
                view(request, response);
            } else {
                log.warn("Unknown action: {} in order detail request", action);
                session.setAttribute("toastMessage", "Invalid action requested.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/user/orders.jsp");
            }
        } catch (Exception e) {
            log.error("Error processing order detail request", e);
            session.setAttribute("toastMessage", "An error occurred while processing your request.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/user/orders.jsp");
        }
    }

    private void view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            // Get and validate order ID
            String id = request.getParameter("id");
            if (id == null || id.trim().isEmpty()) {
                log.warn("Missing order ID in view request");
                session.setAttribute("toastMessage", "Order ID is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/user/orders.jsp");
                return;
            }

            // Get current user from session
            Account currentUser = (Account) session.getAttribute("profile");
            if (currentUser == null) {
                log.warn("Unauthorized access attempt to order details");
                session.setAttribute("toastMessage", "Please login to view order details.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            // Get order details
            Sales_Order sales_order = orderRepository.findById(id);
            if (sales_order == null) {
                log.warn("Order not found: {}", id);
                session.setAttribute("toastMessage", "Order not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/user/orders.jsp");
                return;
            }

            // Verify order ownership
            if (!sales_order.getUser().getId().equals(currentUser.getId())) {
                log.warn("Unauthorized access attempt to order: {} by user: {}", id, currentUser.getEmail());
                session.setAttribute("toastMessage", "You are not authorized to view this order.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/user/orders.jsp");
                return;
            }

            // Get account details
            Account account = accountRepository.findAccountById(sales_order.getUser().getId());
            if (account == null) {
                log.error("Account not found for order: {}", id);
                session.setAttribute("toastMessage", "Error retrieving account information.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/user/orders.jsp");
                return;
            }

            // Get order products
            List<Order_Product> orderProducts = productRepository.findByStringOrderId(id);
            if (orderProducts == null) {
                log.warn("No products found for order: {}", id);
                orderProducts = new ArrayList<>();
            }

            // Get alternative addresses
            Address addresses = addressRepository.findDefaultByUserIdDiffrent(account.getId());

            // Set request attributes
            request.setAttribute("order", sales_order);
            request.setAttribute("products", orderProducts);
            request.setAttribute("account", account);
            request.setAttribute("addresses", addresses);

            log.info("Successfully retrieved order details for order: {} by user: {}", id, currentUser.getEmail());
            request.getRequestDispatcher("/user/orderDetail.jsp").forward(request, response);

        } catch (Exception e) {
            log.error("Error viewing order details", e);
            session.setAttribute("toastMessage", "An error occurred while retrieving order details.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/user/orders.jsp");
        }
    }
}
