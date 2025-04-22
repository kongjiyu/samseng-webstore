package com.samseng.web.utils;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepository;
import com.samseng.web.dto.CartItemDTO;
import java.util.ArrayList;
import java.util.List;

import com.samseng.web.repositories.Cart_Product.Cart_ProductRepository;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class UserSessionFilter implements Filter {
    @Inject
    AccountRepository accountRepository;
    @Inject
    Cart_ProductRepository cartRepository;

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();

        // Step 1: Load profile if not yet set
        if (request.getUserPrincipal() != null && session.getAttribute("profile") == null) {
            String email = request.getUserPrincipal().getName();
            Account account = accountRepository.findAccountByEmail(email);
            if (account != null) {
                session.setAttribute("profile", account);
            }
        }

        // Step 2: Always reload cart if user is logged in
        Account account = (Account) session.getAttribute("profile");
        if (account != null) {
            List<CartItemDTO> cartItems = cartRepository.findByAccountId(account.getId());
            session.setAttribute("cart", cartItems);
        } else {
            session.setAttribute("cart", new ArrayList<CartItemDTO>());
        }

        chain.doFilter(req, res);
    }
}
