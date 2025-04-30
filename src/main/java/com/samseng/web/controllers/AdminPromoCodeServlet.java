package com.samseng.web.controllers;

import com.samseng.web.models.Promo_Code;
import com.samseng.web.repositories.Promo_Code.PromoCodeRepository;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/promo")
public class AdminPromoCodeServlet extends HttpServlet {

    @Inject
    private PromoCodeRepository promoRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            List<Promo_Code> promoList = promoRepo.findAll();
            if (promoList == null || promoList.isEmpty()) {
                session.setAttribute("toastMessage", "No promo codes found.");
                session.setAttribute("toastType", "info");
            }
            request.setAttribute("promoList", promoList);
            request.getRequestDispatcher("/admin/promoList.jsp").forward(request, response);
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to load promo codes: " + e.getMessage());
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid action specified.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/promo");
            return;
        }

        try {
            if ("add".equals(action)) {
                addPromoCode(request, session);
            } else if ("toggle".equals(action)) {
                togglePromoCode(request, session);
            } else {
                session.setAttribute("toastMessage", "Invalid action specified.");
                session.setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "An error occurred: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/promo");
    }

    private void addPromoCode(HttpServletRequest request, HttpSession session) {
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        String discountStr = request.getParameter("discount");
        String status = request.getParameter("status");
        boolean available = "on".equals(request.getParameter("available"));

        if (code == null || code.isEmpty() || description == null || description.isEmpty() || 
            discountStr == null || discountStr.isEmpty()) {
            session.setAttribute("toastMessage", "All fields are required.");
            session.setAttribute("toastType", "error");
            return;
        }

        try {
            double discount = Double.parseDouble(discountStr) / 100;
            if (discount <= 0 || discount > 1) {
                session.setAttribute("toastMessage", "Discount must be between 0 and 100.");
                session.setAttribute("toastType", "error");
                return;
            }

            Promo_Code existingPromo = promoRepo.findById(code);
            if (existingPromo != null) {
                session.setAttribute("toastMessage", "Promo code already exists.");
                session.setAttribute("toastType", "error");
                return;
            }

            Promo_Code promo = new Promo_Code(code, available, discount, description);
            promoRepo.create(promo);
            session.setAttribute("toastMessage", "Promo code created successfully.");
            session.setAttribute("toastType", "success");
        } catch (NumberFormatException e) {
            session.setAttribute("toastMessage", "Invalid discount value. Please enter a valid number.");
            session.setAttribute("toastType", "error");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to create promo code: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }
    }

    private void togglePromoCode(HttpServletRequest request, HttpSession session) {
        String code = request.getParameter("code");
        String availableStr = request.getParameter("available");

        if (code == null || code.isEmpty() || availableStr == null) {
            session.setAttribute("toastMessage", "Invalid parameters for toggle operation.");
            session.setAttribute("toastType", "error");
            return;
        }

        try {
            boolean available = "true".equals(availableStr);
            Promo_Code promo = promoRepo.findById(code);
            
            if (promo == null) {
                session.setAttribute("toastMessage", "Promo code not found.");
                session.setAttribute("toastType", "error");
                return;
            }

            promoRepo.updateAvailability(code, available);
            session.setAttribute("toastMessage", "Promo code " + (available ? "activated" : "deactivated") + " successfully.");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to toggle promo code status: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }
    }
}
