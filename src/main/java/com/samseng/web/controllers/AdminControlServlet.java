package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@Transactional
@WebServlet(name = "control", urlPatterns = {"/admin/control"})
@MultipartConfig
public class AdminControlServlet extends HttpServlet {

    @Inject
    private AccountRepository accountRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            update(request,response);
            return;
        }
        else if ("delete".equals(action)) {
            delete(request,response);
            return;
        }
        else if("list".equals(action)){
            list(request,response);
            return;
        }
        else if("search".equals(action)){
            search(request,response);
            return;
        }
        else if("create".equals(action)){
            create(request,response);
            return;
        }
        Account accountProfile = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());
        request.setAttribute("profile", accountProfile);
        request.getRequestDispatcher("/admin/customerList.jsp").forward(request, response);
    }


    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        String id = request.getParameter("id");
        Account user = accountRepo.findAccountById(id);

        if (user != null) {
            user.setUsername(request.getParameter("username"));
            user.setEmail(request.getParameter("email"));

            String roleParam = request.getParameter("role");
            if (roleParam != null) {
                user.setRole(Account.Role.valueOf(roleParam.toUpperCase()));
            }

            String dobParam = request.getParameter("dob");
            if (dobParam != null && !dobParam.isEmpty()) {
                user.setDob(LocalDate.parse(dobParam));
            }

            accountRepo.update(user);
            response.sendRedirect("/customerList.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to update user.");
            response.sendRedirect("/general/errorPage.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userId = request.getParameter("id"); // ID of the user to delete
        HttpSession session = request.getSession();
        Account currentAccount = (Account) session.getAttribute("account");

        // Check if admin is logged in
        if (currentAccount != null && currentAccount.getRole() == Account.Role.ADMIN) {
            try {
                Account userToDelete = accountRepo.findAccountById(userId); // Find the user
                if (userToDelete != null) {
                    accountRepo.delete(userToDelete);
                    response.sendRedirect("/admin/customerList.jsp");
                } else {
                    request.setAttribute("errorMessage", "User not found.");
                    request.getRequestDispatcher("/general/errorPage.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Failed to delete user.");
                request.getRequestDispatcher("/general/errorPage.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("/login-flow");
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account loggedInUser = (Account) session.getAttribute("account");

        if (loggedInUser != null && loggedInUser.getRole() == Account.Role.ADMIN) {
            // Fetch all users
            request.setAttribute("users", accountRepo.findAll());
            request.getRequestDispatcher("/admin/customerList.jsp").forward(request, response);
        } else {
            response.sendRedirect("/login-flow");
        }
    }

    private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            request.getRequestDispatcher("/admin/customerList.jsp").forward(request, response);
        } else {
            response.sendRedirect("/login-flow");
        }
    }

    private void create(HttpServletRequest request, HttpServletResponse response)
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
        request.getRequestDispatcher("/admin/profile").forward(request, response);
    }

}

