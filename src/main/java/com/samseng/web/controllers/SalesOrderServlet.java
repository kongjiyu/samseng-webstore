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

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

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
        Account user = (Account) session.getAttribute("profile");
        List<CartItemDTO> cartItems = (List<CartItemDTO>) session.getAttribute("cart");

        if (user == null || cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
            return;
        }

        String addressId = request.getParameter("radio-17");
        String paymentMethod = request.getParameter("radio-19");
        String promoCodeInput = request.getParameter("promo-code");

        Address address = addressRepo.findById(addressId);
        Promo_Code promoCode = promoCodeInput != null && !promoCodeInput.isEmpty() ? promoRepo.findById(promoCodeInput.toUpperCase()) : null;

        double grossPrice = Double.parseDouble(request.getParameter("grossPrice"));
        double taxCharge = Double.parseDouble(request.getParameter("taxCharge"));
        double deliveryCharge = Double.parseDouble(request.getParameter("deliveryCharge"));
        double discountAmount = Double.parseDouble(request.getParameter("discountAmount"));
        double netPrice = Double.parseDouble(request.getParameter("netPrice"));

        Sales_Order order = new Sales_Order();
        order.setUser(user);
        order.setAddress(address);
        order.setPromo_code(promoCode);
        order.setGrossPrice(grossPrice);
        order.setTaxCharge(taxCharge);
        order.setDeliveryCharge(deliveryCharge);
        order.setDiscountAmount(discountAmount);
        order.setNetPrice(netPrice);
        order.setStatus("ORDERED");
        order.setPaymentMethod(paymentMethod);
        order.setRefNo(UUID.randomUUID().toString().substring(0, 8));
        order.setOrderedDate(LocalDate.now());
        order.setPackDate(LocalDate.now().plusDays(1));
        order.setShipDate(LocalDate.now().plusDays(2));
        order.setDeliverDate(LocalDate.now().plusDays(3));

        salesOrderRepo.create(order);

        for (CartItemDTO item : cartItems) {
            Order_Product op = new Order_Product();
            op.setSalesOrder(order);
            op.setProduct(item.variant().getProduct());
            op.setQuantity(item.quantity());
            op.setPrice(item.variant().getPrice());
            orderProductRepo.create(op);
        }

        session.removeAttribute("cart");
        cartProductRepo.removeAll(user.getId());
        response.sendRedirect(request.getContextPath() + "/user/orderDetails.jsp?orderId=" + order.getId());
    }
}
