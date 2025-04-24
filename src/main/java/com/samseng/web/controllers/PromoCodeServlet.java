package com.samseng.web.controllers;

import com.samseng.web.models.Promo_Code;
import com.samseng.web.repositories.Promo_Code.PromoCodeRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

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
        String code = request.getParameter("promo-code");
        HttpSession session = request.getSession();

        if (code != null && !code.trim().isEmpty()) {
            Promo_Code promoCode = promoCodeRepository.findById(code.toUpperCase());
            if (promoCode != null && promoCode.isAvailability()) {
                session.setAttribute("promoCode", promoCode);
                session.removeAttribute("promoError");
            } else {
                session.setAttribute("promoCode", null);
                session.setAttribute("promoError", true);
            }
        } else {
            session.setAttribute("promoCode", null);
            session.setAttribute("promoError", true);
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
