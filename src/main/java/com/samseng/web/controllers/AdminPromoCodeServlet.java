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
        List<Promo_Code> promoList = promoRepo.findAll();
        request.setAttribute("promoList", promoList);
        request.getRequestDispatcher("/admin/voucherList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            String discountStr = request.getParameter("discount");
            String status = request.getParameter("status");
            boolean available = "on".equals(request.getParameter("available"));

            try {
                double discount = Double.parseDouble(discountStr) / 100;
                Promo_Code promo = new Promo_Code(code, available, discount, description);
                promoRepo.create(promo);
            } catch (NumberFormatException e) {
                request.setAttribute("toastType", "error");
                request.setAttribute("toastMessage", "Invalid discount value.");
            }

        } else if ("toggle".equals(action)) {
            String code = request.getParameter("code");
            boolean available = "true".equals(request.getParameter("available"));
            promoRepo.updateAvailability(code, available);
        }

        response.sendRedirect(request.getContextPath() + "/admin/promo");
    }
}
