package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.models.Address;
import com.samseng.web.models.Order_Product;
import com.samseng.web.models.Sales_Order;
import com.samseng.web.repositories.Account.AccountRepository;
import com.samseng.web.repositories.Address.AddressRepository;
import com.samseng.web.repositories.Order_Product.Order_ProductRepository;
import com.samseng.web.repositories.Sales_Order.Sales_OrderRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/detail")
public class AdminOrderDetailServlet extends HttpServlet {
    @Inject
    private AccountRepository accountRepository;

    @Inject
    private Sales_OrderRepository orderRepository;

    @Inject
    private Order_ProductRepository productRepository;

    @Inject
    private AddressRepository addressRepository;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if (action == null || action.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid action specified.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        try {
            if("view".equals(action)){
                view(request, response);
                return;
            }
            else if("updateStatus".equals(action)){
                updateStatus(request, response);
                return;
            } else {
                session.setAttribute("toastMessage", "Invalid action specified.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/orders");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "An error occurred: " + e.getMessage());
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("orderId");

        if (id == null || id.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid order ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        try {
            Sales_Order order = orderRepository.findById(id);
            if (order == null) {
                session.setAttribute("toastMessage", "Order not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }

            String currentStatus = order.getStatus();
            String nextStatus = null;
            String dateField = null;
            java.time.LocalDate now = java.time.LocalDate.now();

            switch (currentStatus) {
                case "Ordered":
                    nextStatus = "Packaged";
                    dateField = "packDate";
                    break;
                case "Packaged":
                    nextStatus = "Shipped";
                    dateField = "shipDate";
                    break;
                case "Shipped":
                    nextStatus = "Delivered";
                    dateField = "deliverDate";
                    break;
                default:
                    session.setAttribute("toastMessage", "Invalid order status: " + currentStatus);
                    session.setAttribute("toastType", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/detail?action=view&id=" + id);
                    return;
            }

            if (nextStatus != null && dateField != null) {
                orderRepository.updateStatusAndDateById(id, nextStatus, dateField, now);
                session.setAttribute("toastMessage", "Order status updated successfully to " + nextStatus + ".");
                session.setAttribute("toastType", "success");
            } else {
                session.setAttribute("toastMessage", "Failed to determine next status for order.");
                session.setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to update order status: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/detail?action=view&id=" + id);
    }

    private void view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid order ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        try {
            Sales_Order sales_order = orderRepository.findById(id);
            if (sales_order == null) {
                session.setAttribute("toastMessage", "Order not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }

            Account account = accountRepository.findAccountById(sales_order.getUser().getId());
            if (account == null) {
                session.setAttribute("toastMessage", "Associated account not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }

            List<Order_Product> orderProducts = productRepository.findByStringOrderId(id);
            if (orderProducts == null || orderProducts.isEmpty()) {
                session.setAttribute("toastMessage", "No products found for this order.");
                session.setAttribute("toastType", "warning");
            }

            Address addresses = addressRepository.findDefaultByUserIdDiffrent(account.getId());
            if (addresses == null) {
                session.setAttribute("toastMessage", "No shipping address found for this order.");
                session.setAttribute("toastType", "warning");
            }

            request.setAttribute("order", sales_order);
            request.setAttribute("products", orderProducts);
            request.setAttribute("account", account);
            request.setAttribute("addresses", addresses);
            request.getRequestDispatcher("/admin/orderDetail.jsp").forward(request, response);
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to load order details: " + e.getMessage());
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
}
