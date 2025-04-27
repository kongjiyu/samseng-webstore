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

        if("view".equals(action)){
            view(request, response);
            return;
        }
        else if("updateStatus".equals(action)){
            updateStatus(request, response);
            return;

        }
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("orderId");
        Sales_Order order = orderRepository.findById(id);

        if (order != null) {
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
            }

            if (nextStatus != null && dateField != null) {
                orderRepository.updateStatusAndDateById(id, nextStatus, dateField, now);
            }

            response.sendRedirect(request.getContextPath() + "/admin/detail?action=view&id=" + id);

        }
    }




    private void view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Sales_Order sales_order = orderRepository.findById(id);
        Account account=accountRepository.findAccountById(sales_order.getUser().getId());
        List<Order_Product> orderProducts= productRepository.findByStringOrderId(id);
        Address addresses = addressRepository.findDefaultByUserIdDiffrent(account.getId());

        request.setAttribute("order", sales_order);
        request.setAttribute("products", orderProducts);
        request.setAttribute("account", account);
        request.setAttribute("addresses", addresses);
        request.getRequestDispatcher("/admin/orderDetail.jsp").forward(request, response);
    }

}
