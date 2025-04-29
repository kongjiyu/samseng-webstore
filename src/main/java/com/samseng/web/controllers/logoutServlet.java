package com.samseng.web.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class logoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            // Perform logout
            request.logout();
            session.invalidate();
            
            // Set success message
            session = request.getSession(true); // Create new session for the message
            session.setAttribute("toastMessage", "You have been logged out successfully.");
            session.setAttribute("toastType", "success");
            
            // Redirect to home page
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (ServletException e) {
            // Handle logout failure
            session.setAttribute("toastMessage", "Failed to logout. Please try again.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (Exception e) {
            // Handle any other unexpected errors
            session.setAttribute("toastMessage", "An unexpected error occurred during logout.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}
