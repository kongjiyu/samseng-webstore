package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepositoryImpl;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/createUser")//This is for admin to create admin, staff and user account
public class CreateUserServlet extends HttpServlet {

    @Inject
    private AccountRepositoryImpl accountRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/createUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        LocalDate dob = LocalDate.parse(request.getParameter("dob"));
        Account.Role role = Account.Role.valueOf(request.getParameter("role").toUpperCase());

        Account account = new Account();
        account.setUsername(username);
        account.setEmail(email);
        account.setPassword(password);
        account.setDob(dob);
        account.setRole(role);

        accountRepo.create(account);

        request.setAttribute("message", "New user created successfully!");
        request.getRequestDispatcher("/createUser.jsp").forward(request, response);
    }
}
