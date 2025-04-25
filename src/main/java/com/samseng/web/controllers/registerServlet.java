package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.swing.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/register")
public class registerServlet extends HttpServlet {

    @Inject
    AccountRepository accountRepo;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String birthdate = request.getParameter("birthdate");

            LocalDate dob = LocalDate.parse(birthdate);

            Account existing = accountRepo.findAccountByEmail(email);
            if (existing != null) {
                request.setAttribute("toastMessage", "Email already registered!");
                request.setAttribute("toastType", "error");
                request.getRequestDispatcher("/").forward(request, response);
                return;
            }

            Account acc = new Account();
            acc.setUsername(username);
            acc.setEmail(email);
            acc.setPassword(password);
            acc.setRole(Account.Role.USER);
            acc.setDob(dob);
            accountRepo.create(acc);
            request.setAttribute("toastMessage", "Registration successful!");
            request.setAttribute("toastType", "success");
            request.getRequestDispatcher("/").forward(request, response);
        }
        catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("toastMessage", "Registration failed: " + e.getMessage());
            request.setAttribute("toastType", "error");
            request.getRequestDispatcher("/").forward(request, response);
        }

    }
}
