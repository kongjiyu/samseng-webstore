package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepositoryImpl;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/editUser")
public class EditOthersProfileServlet extends HttpServlet {

    @Inject
    private AccountRepositoryImpl accountRepo;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");

        if (id != null && !id.isEmpty()) {
            Account user = accountRepo.findAccountById(id);

            if (user != null) {
                req.setAttribute("user", user);
                req.getRequestDispatcher("/userProfile.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "User not found.");
                resp.sendRedirect("/customerList.jsp");
            }
        } else {
            resp.sendRedirect("/customerList.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String id = req.getParameter("id");
        Account user = accountRepo.findAccountById(id);

        if (user != null) {
            user.setUsername(req.getParameter("username"));
            user.setEmail(req.getParameter("email"));

            String roleParam = req.getParameter("role");
            user.setRole(Account.Role.valueOf(roleParam));

            String dobParam = req.getParameter("dob");
            LocalDate newDob = LocalDate.parse(dobParam);
            user.setDob(newDob);

            accountRepo.update(user);
            resp.sendRedirect("/customerList.jsp");
        } else {
            req.setAttribute("error", "Failed to update user.");
            resp.sendRedirect("/customerList.jsp");
        }
    }
}
