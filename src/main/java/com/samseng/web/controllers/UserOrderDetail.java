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

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
        request.getRequestDispatcher("/user/orderDetail.jsp").forward(request, response);
    }

}
