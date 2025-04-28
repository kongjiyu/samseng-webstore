package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.models.Sales_Order;
import com.samseng.web.repositories.Account.AccountRepository;
import com.samseng.web.repositories.Sales_Order.Sales_OrderRepository;
import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/order-detail")
public class AdminOrderDetailServlet extends HttpServlet {
    @Inject
    private Sales_OrderRepository salesOrderRepository;
    private AccountRepository accountRepository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");

        if (idParam == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }

        Sales_Order order = salesOrderRepository.findById(idParam);

        if (order == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }

        Account account = order.getUser();

        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }


        req.setAttribute("order", order);
        req.setAttribute("account", account);

        RequestDispatcher view = req.getRequestDispatcher("/admin/orderDetail.jsp");
        view.forward(req, resp);
    }

}
