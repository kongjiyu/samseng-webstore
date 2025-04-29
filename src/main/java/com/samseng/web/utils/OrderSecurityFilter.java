package com.samseng.web.utils;

import com.samseng.web.models.Account;
import com.samseng.web.models.Sales_Order;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.samseng.web.repositories.Sales_Order.Sales_OrderRepository;

@WebFilter(urlPatterns = {"/user/detail"})
public class OrderSecurityFilter implements Filter {
    @Inject
    private Sales_OrderRepository orderRepository;


    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String orderId = request.getParameter("id");
        Account currentUser = (Account) request.getSession().getAttribute("profile");

        if (orderId != null && currentUser != null) {
            Sales_Order order = orderRepository.findById(orderId);

            if (order != null && (order.getUser().getId().equals(currentUser.getId()) || Account.Role.ADMIN.equals(order.getUser().getRole()))) {
                // User owns the order OR user is admin, allow access
                chain.doFilter(request, response);
                return;
            }
        }

        // Block access
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized access to order details.");
    }

    @Override
    public void destroy() {
    }
}