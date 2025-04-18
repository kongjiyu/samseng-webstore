package com.samseng.web.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/logout")
public class logoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException {
        try {
            req.logout();
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        } catch (IOException e) {
            throw new ServletException("Redirect failed", e);
        }
    }
}
