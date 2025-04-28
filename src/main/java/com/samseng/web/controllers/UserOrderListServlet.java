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

import java.io.IOException;
import java.util.List;

@WebServlet("/user/orders")
public class UserOrderListServlet extends HttpServlet {
    @Inject
    private Sales_OrderRepository salesOrderRepository;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account user = (Account) req.getSession().getAttribute("profile");
        String userId = user.getId();

        // get the list of orders
        List<Sales_Order> orders = salesOrderRepository.findByUserIdPaged(userId);

        // convert into DTO
        List<OrderListingDTO> dtos = orders.stream()
                .map(o -> {
                    return new OrderListingDTO(
                            o.getId(),
                            o.getNetPrice(),
                            o.getStatus(),
                            o.getOrderedDate(),
                            o.getUser().getUsername(),
                            o.getUser().getEmail()
                    );
                }).toList();

        // pass "orders" dto to jsp use
        req.setAttribute("orders", dtos);
        // note that we only pass "orders". we don't pass attributes such as "currentPage" into the DTO.

        // pass the next step to jsp
        RequestDispatcher view = req.getRequestDispatcher("/user/orderList.jsp");
        view.forward(req, resp);

    }

}
