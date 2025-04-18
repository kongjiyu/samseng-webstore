package com.samseng.web.controllers;

import com.samseng.web.Dao.AddressDao;
import com.samseng.web.models.Account;
import com.samseng.web.models.Address;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/addresses")
public class AddressServlet extends HttpServlet {
    @Inject
    private AddressDao addressDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("loginRegisterForm.jsp");
            return;
        }

        List<Address> addresses = addressDao.findByUserId(user.getId());
        request.setAttribute("addresses", addresses);
        request.getRequestDispatcher("/userProfile.jsp").forward(request, response);
    }

}
