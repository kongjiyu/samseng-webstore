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

        List<Account> accounts = (List<Account>) request.getAttribute("users");

        if (accounts == null) {
            accounts = accountRepo.findAll();
        }

        request.setAttribute("accountList", accounts);
        request.getRequestDispatcher("/admin/userList.jsp").forward(request, response);
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
        else if ("saveUpdate".equals(action)) {
            saveUpdatedAccount(request, response);
            return;
        }
        else if ("delete".equals(action)) {
            delete(request,response);
            return;
        }
        else if("search".equals(action)){
            search(request,response);
            return;
        }
        else if("view".equals(action)){
            view(request,response);
            return;
        }
        else if("create".equals(action)){
            create(request,response);
            return;
        }
        List<Account> accounts = accountRepo.findAll();
        request.getSession().setAttribute("accountList", accounts);
        request.getRequestDispatcher("/admin/userList.jsp").forward(request, response);
    }


    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("id");
        Account account = accountRepo.findAccountById(id);

        if (account != null) {
            request.setAttribute("account", account);
            request.getRequestDispatcher("/admin/customerDetail.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "User not found.");
            request.getRequestDispatcher("/general/errorPage.jsp").forward(request, response);
        }
    }

    private void saveUpdatedAccount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("id");
        Account account = accountRepo.findAccountById(id);

        if (account != null) {
            account.setUsername(request.getParameter("username"));
            account.setEmail(request.getParameter("email"));

            String dob = request.getParameter("dob");
            if (dob != null && !dob.isEmpty()) {
                account.setDob(LocalDate.parse(dob));
            }

            String role = request.getParameter("role");
            if (role != null) {
                account.setRole(Account.Role.valueOf(role));
            }

            accountRepo.update(account);
            response.sendRedirect("/admin/control"); // redirect back to list
        } else {
            request.setAttribute("errorMessage", "User not found.");
            request.getRequestDispatcher("/general/errorPage.jsp").forward(request, response);
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
                    response.sendRedirect("/admin/control");
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

    private void view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Account account = accountRepo.findAccountById(id);

        if (account != null) {
            request.setAttribute("account", account);
            request.getRequestDispatcher("/admin/customerDetail.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "User not found.");
            request.getRequestDispatcher("/general/errorPage.jsp").forward(request, response);
        }
    }

    private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account loggedInUser = (Account) session.getAttribute("account");

        if (loggedInUser != null && loggedInUser.getRole() == Account.Role.ADMIN) {
            String keyword = request.getParameter("search");
            List<Account> accounts;

            if (keyword != null && !keyword.trim().isEmpty()) {
                accounts = accountRepo.searchAllFields(keyword.trim());

            }else {
                accounts = accountRepo.findAll(); // fallback to show all
            }
            request.setAttribute("accountList", accounts);

            request.getRequestDispatcher("/admin/userList.jsp").forward(request, response);
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

