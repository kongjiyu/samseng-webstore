package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepositoryImpl;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewAllUsers")
public class ViewAllUsersServlet extends HttpServlet {

    @Inject
    private AccountRepositoryImpl accountRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account loggedInUser = (Account) session.getAttribute("account");

        if (loggedInUser != null && loggedInUser.getRole() == Account.Role.ADMIN) {
            String keyword = request.getParameter("search");
            List<Account> users;

            if (keyword != null && !keyword.trim().isEmpty()) {
                users = accountRepo.searchAllFields(keyword.trim());
            } else {
                users = accountRepo.findAll();
            }

            request.setAttribute("users", users);
            request.setAttribute("searchQuery", keyword);
            request.getRequestDispatcher("customerList.jsp").forward(request, response);
        } else {
            response.sendRedirect("/loginRegisterForm.jsp");
        }
    }
}
