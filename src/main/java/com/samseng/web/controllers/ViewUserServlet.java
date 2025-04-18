package com.samseng.web.controllers;

import com.samseng.web.Dao.AccountDao;
import com.samseng.web.models.Account;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewUsers")
public class ViewUserServlet extends HttpServlet {

    @Inject
    private AccountDao accountDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Account> users = accountDao.findAll();
        request.setAttribute("users", users);

        request.getRequestDispatcher("/userList.jsp").forward(request, response);
    }
}
