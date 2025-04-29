package com.samseng.web.controllers;

import com.samseng.web.models.Promo_Code;
import com.samseng.web.models.Account;
import com.samseng.web.repositories.Promo_Code.PromoCodeRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

@Log4j2
@WebServlet("/promo-code")
public class PromoCodeServlet extends HttpServlet {
    @Inject
    PromoCodeRepository promoCodeRepository;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            String code = request.getParameter("promo-code");

            if (code == null || code.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Please enter a promo code.");
                session.setAttribute("toastType", "error");
                session.setAttribute("promoCode", null);
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            // Convert code to uppercase for consistency
            code = code.toUpperCase();
            
            try {
                Promo_Code promoCode = promoCodeRepository.findById(code);
                
                if (promoCode == null) {
                    session.setAttribute("toastMessage", "Invalid promo code.");
                    session.setAttribute("toastType", "error");
                    session.setAttribute("promoCode", null);
                } else if (!promoCode.isAvailability()) {
                    session.setAttribute("toastMessage", "This promo code is no longer available.");
                    session.setAttribute("toastType", "error");
                    session.setAttribute("promoCode", null);
                } else if (code.equals("BIRTHDAY")) {
                    // Special handling for BIRTHDAY promo code
                    Account account = (Account) session.getAttribute("profile");
                    if (account == null) {
                        session.setAttribute("toastMessage", "Please log in to use the birthday promo code.");
                        session.setAttribute("toastType", "error");
                        session.setAttribute("promoCode", null);
                    } else if (isTodayUserBirthday(account.getDob())) {
                        session.setAttribute("promoCode", promoCode);
                        session.setAttribute("toastMessage", "Happy Birthday! Your birthday promo code has been applied!");
                        session.setAttribute("toastType", "success");
                        log.info("Birthday promo code applied successfully for user {} (session {})", account.getUsername(), session.getId());
                    } else {
                        session.setAttribute("toastMessage", "The birthday promo code can only be used on your birthday.");
                        session.setAttribute("toastType", "error");
                        session.setAttribute("promoCode", null);
                    }
                } else {
                    session.setAttribute("promoCode", promoCode);
                    session.setAttribute("toastMessage", "Promo code applied successfully!");
                    session.setAttribute("toastType", "success");
                    log.info("Promo code '{}' applied successfully for session {}", code, session.getId());
                }
            } catch (Exception e) {
                log.error("Error validating promo code: " + code, e);
                session.setAttribute("toastMessage", "An error occurred while validating the promo code.");
                session.setAttribute("toastType", "error");
                session.setAttribute("promoCode", null);
            }
        } catch (Exception e) {
            log.error("Error processing promo code request", e);
            session.setAttribute("toastMessage", "An unexpected error occurred. Please try again.");
            session.setAttribute("toastType", "error");
            session.setAttribute("promoCode", null);
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private boolean isTodayUserBirthday(LocalDate birthdate) {
        if (birthdate == null) {
            return false;
        }
        
        LocalDate today = LocalDate.now();
        
        return today.getMonthValue() == birthdate.getMonthValue()
            && today.getDayOfMonth() == birthdate.getDayOfMonth();
    }
}
