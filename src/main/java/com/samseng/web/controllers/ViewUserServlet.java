package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepositoryImpl;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/viewUser")
public class ViewUserServlet extends HttpServlet {

    @Inject
    private AccountRepositoryImpl accountRepo;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String id = req.getParameter("id");
        if (id != null && !id.isEmpty()) {
            Account user = accountRepo.findAccountById(id);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/userProfile.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/customerList.jsp");
        }
    }
}

