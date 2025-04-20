package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {

    @Inject
    private AccountRepository accountRepo;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("id"); // ID of the user to delete
        HttpSession session = request.getSession();
        Account currentAccount = (Account) session.getAttribute("account");

        // Check if admin is logged in
        if (currentAccount != null && currentAccount.getRole() == Account.Role.ADMIN) {
            try {
                Account userToDelete = accountRepo.findAccountById(userId); // Find the user
                if (userToDelete != null) {
                    accountRepo.delete(userToDelete);
                    response.sendRedirect("/customerList.jsp");
                } else {
                    request.setAttribute("error", "User not found.");
                    request.getRequestDispatcher("/customerList.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Failed to delete user.");
                request.getRequestDispatcher("/customerList.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("loginRegisterForm.jsp");
        }
    }
}

