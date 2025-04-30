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

        try {
            if (user != null) {
                handleLoggedInUser(request, response, session, user, action, variantId);
            } else {
                handleGuestUser(request, response, session, action, variantId);
            }
        } catch (NumberFormatException e) {
            session.setAttribute("toastMessage", "Invalid quantity specified.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "An error occurred: " + e.getMessage());
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
        }
    }

    private void handleLoggedInUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, 
                                  Account user, String action, String variantId) throws ServletException, IOException {
        List<CartItemDTO> cartItems = cartProductRepository.findByAccountId(user.getId());
        List<Address> addressList = addressRepository.findByUserId(user.getId());
        request.setAttribute("addresses", addressList);

        boolean shouldRedirect = false;
        try {
            switch (action) {
                case "add":
                    int addQty = Integer.parseInt(request.getParameter("qty"));
                    if (addQty <= 0) {
                        session.setAttribute("toastMessage", "Quantity must be greater than 0.");
                        session.setAttribute("toastType", "error");
                        shouldRedirect = true;
                        break;
                    }
                    cartProductRepository.addOrUpdate(user.getId(), variantId, addQty);
                    session.setAttribute("toastMessage", "Product added to cart successfully.");
                    session.setAttribute("toastType", "success");
                    shouldRedirect = true;
                    break;

                case "remove":
                    cartProductRepository.remove(user.getId(), variantId);
                    session.setAttribute("toastMessage", "Product removed from cart successfully.");
                    session.setAttribute("toastType", "success");
                    shouldRedirect = true;
                    break;

                case "update":
                    int updateQty = Integer.parseInt(request.getParameter("qty"));
                    if (updateQty <= 0) {
                        cartProductRepository.remove(user.getId(), variantId);
                        session.setAttribute("toastMessage", "Product removed from cart successfully.");
                    } else {
                        cartProductRepository.updateQuantity(user.getId(), variantId, updateQty);
                        session.setAttribute("toastMessage", "Cart updated successfully.");
                    }
                    session.setAttribute("toastType", "success");
                    shouldRedirect = true;
                    break;

                case "increase":
                    handleQuantityChange(user, variantId, 1, true);
                    session.setAttribute("toastMessage", "Quantity increased successfully.");
                    session.setAttribute("toastType", "success");
                    shouldRedirect = true;
                    break;

                case "decrease":
                    handleQuantityChange(user, variantId, -1, false);
                    session.setAttribute("toastMessage", "Quantity decreased successfully.");
                    session.setAttribute("toastType", "success");
                    shouldRedirect = true;
                    break;

                default:
                    session.setAttribute("toastMessage", "Invalid action specified.");
                    session.setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to update cart: " + e.getMessage());
            session.setAttribute("toastType", "error");
            shouldRedirect = true;
        }

        cartItems = cartProductRepository.findByAccountId(user.getId());
        session.setAttribute("cart", cartItems);
        if (shouldRedirect) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
        } else {
            forwardToCartPage(request, response, session);
        }
    }

    private void handleGuestUser(HttpServletRequest request, HttpServletResponse response, HttpSession session,
                               String action, String variantId) throws ServletException, IOException {
        List<CartItemDTO> cartItems = (List<CartItemDTO>) session.getAttribute("cart");
        if (cartItems == null) {
            cartItems = new java.util.ArrayList<>();
            session.setAttribute("cart", cartItems);
        }

        boolean shouldRedirect = false;
        try {
            switch (action) {
                case "add":
                    int addQty = Integer.parseInt(request.getParameter("qty"));
                    if (addQty <= 0) {
                        session.setAttribute("toastMessage", "Quantity must be greater than 0.");
                        session.setAttribute("toastType", "error");
                        shouldRedirect = true;
                        break;
                    }
                    Variant variant = variantRepository.findById(variantId);
                    if (variant == null) {
                        session.setAttribute("toastMessage", "Product variant not found.");
                        session.setAttribute("toastType", "error");
                        shouldRedirect = true;
                        break;
                    }
                    cartItems.add(new CartItemDTO(variant, variant.getProduct().getImageUrls().iterator().next(), addQty));
                    session.setAttribute("toastMessage", "Product added to cart successfully.");
                    session.setAttribute("toastType", "success");
                    shouldRedirect = true;
                    break;

                case "remove":
                    if (cartItems.removeIf(item -> item.variant().getVariantId().equals(variantId))) {
                        session.setAttribute("toastMessage", "Product removed from cart successfully.");
                        session.setAttribute("toastType", "success");
                    }
                    shouldRedirect = true;
                    break;

                case "update":
                    int updateQty = Integer.parseInt(request.getParameter("qty"));
                    Variant updateVariant = variantRepository.findById(variantId);
                    if (updateVariant == null) {
                        session.setAttribute("toastMessage", "Product variant not found.");
                        session.setAttribute("toastType", "error");
                        shouldRedirect = true;
                        break;
                    }
                    if (updateQty <= 0) {
                        cartItems.removeIf(item -> item.variant().getVariantId().equals(variantId));
                        session.setAttribute("toastMessage", "Product removed from cart successfully.");
                    } else {
                        updateCartItemQuantity(cartItems, variantId, updateQty);
                        session.setAttribute("toastMessage", "Cart updated successfully.");
                    }
                    session.setAttribute("toastType", "success");
                    shouldRedirect = true;
                    break;

                case "increase":
                    if (updateCartItemQuantity(cartItems, variantId, 1)) {
                        session.setAttribute("toastMessage", "Quantity increased successfully.");
                        session.setAttribute("toastType", "success");
                    }
                    shouldRedirect = true;
                    break;

                case "decrease":
                    if (updateCartItemQuantity(cartItems, variantId, -1)) {
                        session.setAttribute("toastMessage", "Quantity decreased successfully.");
                        session.setAttribute("toastType", "success");
                    }
                    shouldRedirect = true;
                    break;

                default:
                    session.setAttribute("toastMessage", "Invalid action specified.");
                    session.setAttribute("toastType", "error");
                    shouldRedirect = true;
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to update cart: " + e.getMessage());
            session.setAttribute("toastType", "error");
            shouldRedirect = true;
        }

        session.setAttribute("cart", cartItems);
        if (shouldRedirect) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
        } else {
            forwardToCartPage(request, response, session);
        }
    }

    private void handleQuantityChange(Account user, String variantId, int change, boolean isIncrease) {
        List<CartItemDTO> cartItems = cartProductRepository.findByAccountId(user.getId());
        for (CartItemDTO item : cartItems) {
            if (item.variant().getVariantId().equals(variantId)) {
                int newQty = item.quantity() + change;
                if (newQty <= 0) {
                    cartProductRepository.remove(user.getId(), variantId);
                } else {
                    cartProductRepository.updateQuantity(user.getId(), variantId, newQty);
                }
                break;
            }
        }
    }

    private boolean updateCartItemQuantity(List<CartItemDTO> cartItems, String variantId, int change) {
        for (CartItemDTO item : cartItems) {
            if (item.variant().getVariantId().equals(variantId)) {
                int newQty = item.quantity() + change;
                if (newQty <= 0) {
                    cartItems.remove(item);
                } else {
                    cartItems.set(cartItems.indexOf(item), 
                        new CartItemDTO(item.variant(), item.imageUrl(), newQty));
                }
                return true;
            }
        }
        return false;
    }

    private void forwardToCartPage(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws ServletException, IOException {
        request.setAttribute("promoCode", session.getAttribute("promoCode"));
        request.setAttribute("promoError", session.getAttribute("promoError"));
        session.removeAttribute("promoCode");
        session.removeAttribute("promoError");
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}
