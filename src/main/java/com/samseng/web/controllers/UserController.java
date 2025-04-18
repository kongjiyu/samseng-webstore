package com.samseng.web.controllers;

import com.samseng.web.repositories.Account.AccountRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.HttpMethodConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@ServletSecurity(
        @HttpConstraint(rolesAllowed = {"USER"})
)
@WebServlet("/account")
public class UserController extends HttpServlet {
    @Inject
    private AccountRepository accountRepository;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        /*
        var principal = request.getUserPrincipal();
        var email = principal.getName();

        var account = accountRepository.findAccountByEmail(email);

        out.println("Username: <b>" + account.getUsername() + "</b>");
        out.println("Email: <b>" + account.getEmail() + "</b>");
        out.println("Password: <b>" + account.getPassword() + "</b>");
        out.println("Birthday: <b>" + account.getDob() + "</b>");
        out.close();*/
        response.sendRedirect("index.jsp");


    }
}