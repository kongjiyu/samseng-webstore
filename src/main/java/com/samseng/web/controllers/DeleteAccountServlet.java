package com.samseng.web.controllers;

import com.samseng.web.Dao.AccountDao;
import com.samseng.web.models.Account;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteAccount")
public class DeleteAccountServlet extends HttpServlet {

    @Inject
    private AccountDao accountDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account != null) {
            try {
                accountDao.delete(account);
                session.invalidate();
                response.sendRedirect("loginRegisterForm.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Failed to delete account.");
                request.getRequestDispatcher("userProfile.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("loginRegisterForm.jsp");
        }
    }
}
