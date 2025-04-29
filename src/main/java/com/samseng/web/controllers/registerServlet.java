package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

@Log4j2
@WebServlet("/register")
public class registerServlet extends HttpServlet {

    @Inject
    AccountRepository accountRepo;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            // Get and validate input parameters
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String birthdate = request.getParameter("birthdate");

            // Validate required fields
            if (username == null || username.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Username is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            if (email == null || email.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Email is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Password is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            if (birthdate == null || birthdate.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Birthdate is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // Validate email format
            if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                session.setAttribute("toastMessage", "Invalid email format.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // Parse and validate birthdate
            LocalDate dob;
            try {
                dob = LocalDate.parse(birthdate);
            } catch (DateTimeParseException e) {
                session.setAttribute("toastMessage", "Invalid birthdate format. Please use YYYY-MM-DD.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // Check if email already exists
            Account existing = accountRepo.findAccountByEmail(email);
            if (existing != null) {
                session.setAttribute("toastMessage", "Email already registered!");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // Create new account
            Account acc = new Account();
            acc.setUsername(username);
            acc.setEmail(email);
            acc.setPassword(password);
            acc.setRole(Account.Role.USER);
            acc.setDob(dob);

            try {
                accountRepo.create(acc);
                session.setAttribute("toastMessage", "Registration successful! Please login.");
                session.setAttribute("toastType", "success");
                response.sendRedirect(request.getContextPath() + "/");
            } catch (Exception e) {
                log.error("Error creating account", e);
                session.setAttribute("toastMessage", "Error creating account. Please try again.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/");
            }

        } catch (Exception e) {
            log.error("Error during registration", e);
            session.setAttribute("toastMessage", "An unexpected error occurred. Please try again.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
