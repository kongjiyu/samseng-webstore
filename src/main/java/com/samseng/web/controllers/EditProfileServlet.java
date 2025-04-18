package com.samseng.web.controllers;

import com.samseng.web.Dao.AccountDao;
import com.samseng.web.models.Account;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/editUser")
public class EditProfileServlet extends HttpServlet {

    @Inject
    private AccountDao accountDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account != null) {
            String newUsername = request.getParameter("username");
            String newEmail = request.getParameter("email");
            Account.Role newRole = account.getRole();
            LocalDate newDob = account.getDob();

            account.setUsername(newUsername);
            account.setEmail(newEmail);
            account.setRole(newRole);
            account.setDob(newDob);

            try {
                accountDao.update(account);
                session.setAttribute("account", account);
                response.sendRedirect("/userProfile.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Failed to update profile.");
                request.getRequestDispatcher("/userProfile.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("/loginRegisterForm.jsp");
        }
    }
}
