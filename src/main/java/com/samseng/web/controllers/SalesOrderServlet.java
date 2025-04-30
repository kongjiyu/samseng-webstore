package com.samseng.web.controllers;

import com.samseng.web.dto.CartItemDTO;
import com.samseng.web.models.*;
import com.samseng.web.repositories.Address.AddressRepository;
import com.samseng.web.repositories.Cart_Product.Cart_ProductRepository;
import com.samseng.web.repositories.Order_Product.Order_ProductRepository;
import com.samseng.web.repositories.Promo_Code.PromoCodeRepository;
import com.samseng.web.repositories.Sales_Order.Sales_OrderRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.transaction.Transactional;
import lombok.extern.log4j.Log4j2;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Log4j2
@WebServlet("/user/sales-order")
public class SalesOrderServlet extends HttpServlet {
    @Inject
    private Sales_OrderRepository salesOrderRepo;

    @Inject
    private Order_ProductRepository orderProductRepo;

    @Inject
    private AddressRepository addressRepo;

    @Inject
    private PromoCodeRepository promoRepo;

    @Inject
    private Cart_ProductRepository cartProductRepo;

    @Transactional
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            // Get user and cart items
            Account user = (Account) session.getAttribute("profile");
            List<CartItemDTO> cartItems = (List<CartItemDTO>) session.getAttribute("cart");

            // Validate user and cart
            if (user == null) {
                log.warn("Unauthorized access attempt to sales order");
                session.setAttribute("toastMessage", "Please login to place an order.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            if (cartItems == null || cartItems.isEmpty()) {
                log.warn("Empty cart attempt for user: {}", user.getEmail());
                session.setAttribute("toastMessage", "Your cart is empty. Please add items to your cart.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/cart.jsp");
                return;
            }

            // Get and validate required parameters
            String addressId = request.getParameter("radio-17");
            String paymentMethod = request.getParameter("radio-19");
            String promoCodeInput = request.getParameter("promo-code");

            if (addressId == null || addressId.trim().isEmpty()) {
                log.warn("No address selected for order by user: {}", user.getEmail());
                session.setAttribute("toastMessage", "Please select a delivery address.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/cart.jsp");
                return;
            }

            if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
                log.warn("No payment method selected for order by user: {}", user.getEmail());
                session.setAttribute("toastMessage", "Please select a payment method.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/cart.jsp");
                return;
            }

            // Get and validate address
            Address address = addressRepo.findById(addressId);
            if (address == null) {
                log.error("Invalid address ID: {} for user: {}", addressId, user.getEmail());
                session.setAttribute("toastMessage", "Invalid delivery address. Please select a valid address.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/cart.jsp");
                return;
            }

            Promo_Code promoCode = promoRepo.findById(promoCodeInput.toUpperCase());

            // Parse and validate price values
            try {
                double grossPrice = Double.parseDouble(request.getParameter("grossPrice"));
                double taxCharge = Double.parseDouble(request.getParameter("taxCharge"));
                double deliveryCharge = Double.parseDouble(request.getParameter("deliveryCharge"));
                double discountAmount = Double.parseDouble(request.getParameter("discountAmount"));
                double netPrice = Double.parseDouble(request.getParameter("netPrice"));

                // Validate price values
                if (grossPrice < 0 || taxCharge < 0 || deliveryCharge < 0 || discountAmount < 0 || netPrice < 0) {
                    log.error("Invalid price values in order attempt by user: {}", user.getEmail());
                    session.setAttribute("toastMessage", "Invalid price values. Please try again.");
                    session.setAttribute("toastType", "error");
                    response.sendRedirect(request.getContextPath() + "/cart.jsp");
                    return;
                }

                // Create and save order
                Sales_Order order = new Sales_Order();
                order.setUser(user);
                order.setAddress(address);
                order.setPromo_code(promoCode);
                order.setGrossPrice(grossPrice);
                order.setTaxCharge(taxCharge);
                order.setDeliveryCharge(deliveryCharge);
                order.setDiscountAmount(discountAmount);
                order.setNetPrice(netPrice);
                order.setStatus("Ordered");
                order.setPaymentMethod(paymentMethod);
                order.setRefNo(UUID.randomUUID().toString().substring(0, 8));
                order.setOrderedDate(LocalDate.now());

                try {
                    salesOrderRepo.create(order);
                    log.info("Order created successfully for user: {} with order ID: {}", user.getEmail(), order.getId());

                    // Create order products
                    for (CartItemDTO item : cartItems) {
                        Order_Product op = new Order_Product();
                        op.setSalesOrder(order);
                        op.setVariant(item.variant());
                        op.setQuantity(item.quantity());
                        op.setPrice(item.variant().getPrice());
                        orderProductRepo.create(op);
                    }

                    // Clear cart
                    session.removeAttribute("cart");
                    cartProductRepo.removeAll(user.getId());

                    // Set success message
                    session.setAttribute("toastMessage", "Order placed successfully! Your order number is: " + order.getRefNo());
                    session.setAttribute("toastType", "success");
                    response.sendRedirect(request.getContextPath() + "/user/detail?action=view&id=" + order.getId());

                } catch (Exception e) {
                    log.error("Error creating order for user: {}", user.getEmail(), e);
                    session.setAttribute("toastMessage", "Error creating order. Please try again.");
                    session.setAttribute("toastType", "error");
                    response.sendRedirect(request.getContextPath() + "/cart.jsp");
                }

            } catch (NumberFormatException e) {
                log.error("Invalid price format in order attempt by user: {}", user.getEmail(), e);
                session.setAttribute("toastMessage", "Invalid price values. Please try again.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/cart.jsp");
            }

        } catch (Exception e) {
            log.error("Unexpected error in sales order processing", e);
            session.setAttribute("toastMessage", "An unexpected error occurred. Please try again.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
        }
    }
}
