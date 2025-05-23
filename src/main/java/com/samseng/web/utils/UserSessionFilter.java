package com.samseng.web.utils;

import com.samseng.web.models.Account;
import com.samseng.web.models.Product;
import com.samseng.web.repositories.Account.AccountRepository;
import com.samseng.web.dto.CartItemDTO;

import java.util.ArrayList;
import java.util.List;

import com.samseng.web.repositories.Cart_Product.Cart_ProductRepository;
import com.samseng.web.repositories.Product.ProductRepository;
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
    @Inject
    private ProductRepository productRepository;

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();

        // Step 1: Always reload profile from DB if user is logged in
        if (request.getUserPrincipal() != null) {
            String email = request.getUserPrincipal().getName();
            Account account = accountRepository.findAccountByEmail(email);
            if (account != null) {
                session.setAttribute("profile", account);

                Boolean cartMerged = (Boolean) session.getAttribute("cartMerged");
                if (cartMerged == null || !cartMerged) {
                    List<CartItemDTO> sessionCart = (List<CartItemDTO>) session.getAttribute("cart");
                    if (sessionCart != null && !sessionCart.isEmpty()) {
                        List<CartItemDTO> dbCart = cartRepository.findByAccountId(account.getId());

                        for (CartItemDTO sessionItem : sessionCart) {
                            boolean alreadyExists = dbCart.stream()
                                    .anyMatch(dbItem -> dbItem.variant().getVariantId().equals(sessionItem.variant().getVariantId()));

                            if (!alreadyExists) {
                                cartRepository.addOrUpdate(account.getId(), sessionItem.variant().getVariantId(), sessionItem.quantity());
                            }
                        }

                        session.removeAttribute("cart");
                        session.setAttribute("cartMerged", true);
                    }
                }
            }
        }

        // Step 2: Always reload cart if user is logged in
        Account account = (Account) session.getAttribute("profile");
        if (account != null) {
            List<CartItemDTO> cartItems = cartRepository.findByAccountId(account.getId());
            session.setAttribute("cart", cartItems);
        } else {
            List<CartItemDTO> cartItems = (List<CartItemDTO>)session.getAttribute("cart");
            if(cartItems == null){
                session.setAttribute("cart", new ArrayList<CartItemDTO>());
            }else{
                session.setAttribute("cart", cartItems);
            }
        }

        // Step 3: Create a list of all products for header searching purposes, if not already existing
        List<Product> searchableProducts = productRepository.findAll();
        session.setAttribute("searchableProducts", searchableProducts);


        chain.doFilter(req, res);
    }
}
