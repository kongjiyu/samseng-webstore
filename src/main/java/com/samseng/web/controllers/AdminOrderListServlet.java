package com.samseng.web.controllers;

import com.samseng.web.dto.OrderListingDTO;
import com.samseng.web.models.*;
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
        String searchQuery = req.getParameter("searchQuery");

        // get the list of orders
        List<Sales_Order> orders = listOrders(req, searchQuery);

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
        RequestDispatcher view = req.getRequestDispatcher("/admin/orderList.jsp");
        view.forward(req, resp);

    }

    private List<Sales_Order> listOrders(HttpServletRequest req, String searchQuery) throws ServletException, IOException {
        // logic to Paginate the output
        int page = 1;
        int pageSize = 10;

        String pageParam = req.getParameter("page");
        if (pageParam != null && pageParam.matches("\\d+")) {
            page = Integer.parseInt(pageParam);
        }
        long totalCount = 0;

        if (searchQuery != null) { totalCount = salesOrderRepository.countByQuery(searchQuery); }
        else { totalCount = salesOrderRepository.count(); }

        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        int startOrder = (page - 1) * pageSize + 1;
        int endOrder = Math.min(page * pageSize, (int) totalCount);

        // grab items from sales_order table and put into List called "orders"
        // and also order it by "id"
        List<Sales_Order> orders;
        if (searchQuery != null) { orders = salesOrderRepository.findPagedByQuery(searchQuery, page, pageSize); }
        else { orders = salesOrderRepository.findPaged(page, pageSize); }
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalItems", totalCount);
        req.setAttribute("startItem", startOrder);
        req.setAttribute("endItem", endOrder);

        return orders;
    }

}
