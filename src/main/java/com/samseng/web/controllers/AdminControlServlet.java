package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.models.Address;
import com.samseng.web.models.Product;
import com.samseng.web.repositories.Account.AccountRepository;
import com.samseng.web.repositories.Address.AddressRepository;
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
import java.security.Principal;
import java.time.LocalDate;
import java.util.List;

@Transactional
@WebServlet(name = "control", urlPatterns = {"/admin/control"})
@MultipartConfig
public class AdminControlServlet extends HttpServlet {

    @Inject
    private AccountRepository accountRepo;

    @Inject
    private AddressRepository addressRepo;

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
        list(request, response);


        request.getRequestDispatcher("/admin/userList.jsp").forward(request, response);
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int page = 1;
        int pageSize = 20;

        String pageParam = request.getParameter("page");
        if (pageParam != null && pageParam.matches("\\d+")) {
            page = Integer.parseInt(pageParam);
        }

        long totalCount = accountRepo.count();
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        int startItem = (page - 1) * pageSize + 1;
        int endItem = Math.min(page * pageSize, (int) totalCount);

        List<Account> accountPage = accountRepo.findPaged(page, pageSize);

        request.setAttribute("accountList", accountPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalCount);
        request.setAttribute("startItem", startItem);
        request.setAttribute("endItem", endItem);

        request.getRequestDispatcher("/admin/userList.jsp").forward(request, response);
    }



    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");
        Account account = accountRepo.findAccountById(id);

        if (account != null) {
            request.setAttribute("account", account);
            request.getRequestDispatcher("/admin/customerDetail.jsp").forward(request, response);
        } else {
            session.setAttribute("toastMessage", "User not found.");
            session.setAttribute("toastType", "error");
            request.getRequestDispatcher("/general/errorPage.jsp").forward(request, response);
        }
    }

    private void saveUpdatedAccount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("id");
        Account account = accountRepo.findAccountById(id);
        HttpSession session = request.getSession();

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
            session.setAttribute("toastMessage", "User updated successfully.");
            session.setAttribute("toastType", "success");
            response.sendRedirect("/admin/control"); // redirect back to list
        } else {
            session.setAttribute("toastMessage", "Failed to update. User not found.");
            session.setAttribute("toastType", "error");
            request.getRequestDispatcher("/general/errorPage.jsp").forward(request, response);
        }
    }


    private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = request.getParameter("id"); // ID of the user to delete

            try {
                Account userToDelete = accountRepo.findAccountById(userId); // Find the user
                if (userToDelete != null) {

                    userToDelete.setPassword(null);
                    userToDelete.setEmail(null);
                    userToDelete.setUsername("user_deleted");
                    userToDelete.setId(userToDelete.getId());

                    accountRepo.update(userToDelete);
                    response.sendRedirect("/admin/control");
                } else {
                    session.setAttribute("toastMessage", "User not found.");
                    session.setAttribute("toastType", "error");
                    request.getRequestDispatcher("/general/errorPage.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("toastMessage", "Failed to delete user.");
                session.setAttribute("toastType", "error");
                request.getRequestDispatcher("/general/errorPage.jsp").forward(request, response);
            }

    }

    private void view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");
        Account account = accountRepo.findAccountById(id);
        List<Address> addressList = addressRepo.findByUserId(account.getId());
        request.setAttribute("addresses", addressList);
        if (account != null) {
            session.setAttribute("account", account);
            session.setAttribute("addresses", addressList);
            request.getRequestDispatcher("/admin/customerDetail.jsp").forward(request, response);
        } else {
            session.setAttribute("toastMessage", "User not found.");
            session.setAttribute("toastType", "error");
            request.getRequestDispatcher("/general/errorPage.jsp").forward(request, response);
        }
    }

    private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession();
            String keyword = request.getParameter("search");
            List<Account> accounts;

            if (keyword != null && !keyword.trim().isEmpty()) {
                accounts = accountRepo.searchAllFields(keyword.trim());

            }else {
                session.setAttribute("toastMessage", "User not found.");
                session.setAttribute("toastType", "error");
                accounts = accountRepo.findAll(); // fallback to show all
            }
            if(accounts == null || accounts.isEmpty()) {
                session.setAttribute("toastMessage", "User not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/control");
                return;
            }
            request.setAttribute("accountList", accounts);

            request.getRequestDispatcher("/admin/userList.jsp").forward(request, response);

    }

    private void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = "changeit";
        LocalDate dob = LocalDate.parse(request.getParameter("dob"));
        Account.Role role = Account.Role.valueOf(request.getParameter("role").toUpperCase());

        Account account = new Account();
        account.setUsername(username);
        account.setEmail(email);
        account.setPassword(password);
        account.setDob(dob);
        account.setRole(role);

        accountRepo.create(account);

        session.setAttribute("toastMessage", "User created successfully. Default password is 'changeit'");
        session.setAttribute("toastType", "success");
        response.sendRedirect(request.getContextPath() + "/admin/control");
    }

}