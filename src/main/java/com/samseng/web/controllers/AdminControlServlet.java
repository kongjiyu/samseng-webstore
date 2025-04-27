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

        if ("saveUpdatedAccount".equals(action)) {
            saveUpdatedAccount(request, response);
            return;
        } else if ("delete".equals(action)) {
            delete(request,response);
            return;
        } else if ("deleteConfirmed".equals(action)) {
            deleteConfirmed(request, response);
            return;
        } else if("view".equals(action)){
            view(request,response);
            return;
        } else if("create".equals(action)){
            create(request,response);
            return;
        } else if ("changePassword".equals(action)) {
            changePassword(request, response);
            return;
        } else if ("addressAdd".equals(action)) {
            addressAdd(request, response);
            return;
        } else if ("addressEdit".equals(action)) {
            addressEdit(request, response);
            return;
        }

        list(request, response);
        request.getRequestDispatcher("/admin/userList.jsp").forward(request, response);
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        List<Account> accountPage = accountRepo.findAll();

        request.setAttribute("accountList", accountPage);

        request.getRequestDispatcher("/admin/userList.jsp").forward(request, response);
    }

    private void saveUpdatedAccount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("id");
        Account account = accountRepo.findAccountById(id);
        String newUsername = request.getParameter("username");
        String email = request.getParameter("email");

        if (account != null) {
            account.setUsername(newUsername);
            account.setEmail(email);

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
        String id = request.getParameter("id");
        Account account = accountRepo.findAccountById(id);
        List<Address> addressList = addressRepo.findByUserId(account.getId());
        request.setAttribute("addresses", addressList);
        if (account != null) {
            request.setAttribute("account", account);
            request.setAttribute("addresses", addressList);
            request.getRequestDispatcher("/admin/customerDetail.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "User not found.");
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

    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        if (newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
            session.setAttribute("toastMessage", "Passwords do not match.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + id);
            return;
        }

        Account account = accountRepo.findAccountById(id);
        if (account != null) {
            account.setPassword(newPassword);
            accountRepo.update(account);
            session.setAttribute("toastMessage", "Password changed successfully.");
            session.setAttribute("toastType", "success");
        } else {
            session.setAttribute("toastMessage", "User not found.");
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + id);
    }

    private void addressAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = request.getParameter("id");

        if (userId == null) {
            session.setAttribute("toastMessage", "Invalid user ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        Address address = new Address();
        address.setUser(accountRepo.findAccountById(userId));
        address.setName(request.getParameter("address_title"));
        address.setAddress_1(request.getParameter("address_1"));
        address.setAddress_2(request.getParameter("address_2"));
        address.setAddress_3(request.getParameter("address_3"));
        address.setPostcode(Integer.parseInt(request.getParameter("postcode")));
        address.setCountry(request.getParameter("country"));
        address.setState(request.getParameter("state"));
        address.setContact_no(request.getParameter("contact_no"));
        address.setIsdefault(request.getParameter("isdefault") != null);

        addressRepo.create(address);

        session.setAttribute("toastMessage", "Address added successfully.");
        session.setAttribute("toastType", "success");
        response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + userId);
    }

    private void addressEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = request.getParameter("id");
        String addressId = request.getParameter("address_id");

        Address address = addressRepo.findById(addressId);
        if (address == null) {
            session.setAttribute("toastMessage", "Address not found.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        address.setName(request.getParameter("address_title"));
        address.setAddress_1(request.getParameter("address_1"));
        address.setAddress_2(request.getParameter("address_2"));
        address.setAddress_3(request.getParameter("address_3"));
        address.setPostcode(Integer.parseInt(request.getParameter("postcode")));
        address.setState(request.getParameter("state"));
        address.setCountry(request.getParameter("country"));
        address.setContact_no(request.getParameter("contact_no"));
        address.setIsdefault(request.getParameter("isdefault") != null);

        addressRepo.update(address);

        session.setAttribute("toastMessage", "Address updated successfully.");
        session.setAttribute("toastType", "success");
        response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + userId);
    }

    private void deleteConfirmed(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = request.getParameter("id");

        if (userId == null) {
            session.setAttribute("toastMessage", "Invalid user ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        try {
            Account account = accountRepo.findAccountById(userId);
            if (account != null) {
                accountRepo.delete(account);
                session.setAttribute("toastMessage", "User deleted successfully.");
                session.setAttribute("toastType", "success");
            } else {
                session.setAttribute("toastMessage", "User not found.");
                session.setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to delete user.");
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/control");
    }
}