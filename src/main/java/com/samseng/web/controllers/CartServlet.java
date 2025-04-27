package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.models.Address;
import com.samseng.web.models.Cart_Product;
import com.samseng.web.models.Variant;
import com.samseng.web.repositories.Address.AddressRepository;
import com.samseng.web.repositories.Cart_Product.Cart_ProductRepository;
import com.samseng.web.repositories.Variant.VariantRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import com.samseng.web.dto.CartItemDTO;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    @Inject
    Cart_ProductRepository cartProductRepository;

    @Inject
    VariantRepository variantRepository;

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

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String action = request.getParameter("action");
        String variantId = request.getParameter("variantId");
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("profile");

        if (user != null) {
            List<CartItemDTO> cartItems = cartProductRepository.findByAccountId(user.getId());
            List<Address> addressList = addressRepository.findByUserId(user.getId());
            request.setAttribute("addresses", addressList);

            if ("add".equals(action)) {
                int qty = Integer.parseInt(request.getParameter("qty"));
                cartProductRepository.addOrUpdate(user.getId(), variantId, qty);
            } else if ("remove".equals(action)) {
                cartProductRepository.remove(user.getId(), variantId);
            } else if ("update".equals(action)) {
                int qty = Integer.parseInt(request.getParameter("qty"));
                if (qty <= 0) {
                    cartProductRepository.remove(user.getId(), variantId);
                } else {
                    cartProductRepository.updateQuantity(user.getId(), variantId, qty);
                }
            } else if ("increase".equals(action)) {
                for (CartItemDTO item : cartItems) {
                    if (item.variant().getVariantId().equals(variantId)) {
                        int newQty = item.quantity() + 1;
                        cartProductRepository.updateQuantity(user.getId(), variantId, newQty);
                        break;
                    }
                }
            } else if ("decrease".equals(action)) {
                for (CartItemDTO item : cartItems) {
                    if (item.variant().getVariantId().equals(variantId)) {
                        int newQty = item.quantity() - 1;
                        if (newQty <= 0) {
                            cartProductRepository.remove(user.getId(), variantId);
                        } else {
                            cartProductRepository.updateQuantity(user.getId(), variantId, newQty);
                        }
                        break;
                    }
                }
            }
            cartItems = cartProductRepository.findByAccountId(user.getId());
            session.setAttribute("cart", cartItems);
        } else {
            List<CartItemDTO> cartItems = (List<CartItemDTO>) session.getAttribute("cart");
            if (cartItems == null) {
                cartItems = new java.util.ArrayList<>();
                session.setAttribute("cart", cartItems);
            }

            if ("add".equals(action)) {
                int qty = Integer.parseInt(request.getParameter("qty"));
                Variant variant = variantRepository.findById(variantId);
                cartItems.add(new CartItemDTO(variant, variant.getProduct().getImageUrls().iterator().next(), qty));
            } else if ("remove".equals(action)) {
                cartItems.removeIf(item -> item.variant().getVariantId().equals(variantId));
            } else if ("update".equals(action)) {
                int qty = Integer.parseInt(request.getParameter("qty"));
                Variant variant = variantRepository.findById(variantId);
                if (qty <= 0) {
                    cartItems.removeIf(item -> item.variant().getVariantId().equals(variantId));
                } else {
                    for (CartItemDTO item : cartItems) {
                        if (item.variant().getVariantId().equals(variantId)) {
                            cartItems.set(cartItems.indexOf(item), new CartItemDTO(item.variant(), item.imageUrl(), qty));
                            break;
                        }
                    }
                }
            } else if ("increase".equals(action)) {
                for (CartItemDTO item : cartItems) {
                    if (item.variant().getVariantId().equals(variantId)) {
                        int newQty = item.quantity() + 1;
                        cartItems.set(cartItems.indexOf(item), new CartItemDTO(item.variant(), item.imageUrl(), newQty));
                        break;
                    }
                }
            } else if ("decrease".equals(action)) {
                for (CartItemDTO item : cartItems) {
                    if (item.variant().getVariantId().equals(variantId)) {
                        int newQty = item.quantity() - 1;
                        if (newQty <= 0) {
                            cartItems.remove(item);
                        } else {
                            cartItems.set(cartItems.indexOf(item), new CartItemDTO(item.variant(), item.imageUrl(), newQty));
                        }
                        break;
                    }
                }
            }
            session.setAttribute("cart", cartItems);
        }

        request.setAttribute("promoCode", session.getAttribute("promoCode"));
        request.setAttribute("promoError", session.getAttribute("promoError"));
        session.removeAttribute("promoCode");
        session.removeAttribute("promoError");

        request.getRequestDispatcher("/cart.jsp").forward(request, response);
        response.sendRedirect(request.getContextPath() + "/cart.jsp");

    }
}
