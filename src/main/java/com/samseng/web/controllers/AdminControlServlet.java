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
        HttpSession session = request.getSession();
        String id = request.getParameter("id");
        
        if (id == null || id.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid account ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        Account account = accountRepo.findAccountById(id);
        if (account == null) {
            session.setAttribute("toastMessage", "Account not found.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        try {
            String newUsername = request.getParameter("username");
            String email = request.getParameter("email");

            if (newUsername == null || newUsername.isEmpty() || email == null || email.isEmpty()) {
                session.setAttribute("toastMessage", "Username and email are required fields.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + id);
                return;
            }

            account.setUsername(newUsername);
            account.setEmail(email);

            String dob = request.getParameter("dob");
            if (dob != null && !dob.isEmpty()) {
                try {
                    account.setDob(LocalDate.parse(dob));
                } catch (Exception e) {
                    session.setAttribute("toastMessage", "Invalid date format.");
                    session.setAttribute("toastType", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + id);
                    return;
                }
            }

            String role = request.getParameter("role");
            if (role != null) {
                try {
                    account.setRole(Account.Role.valueOf(role));
                } catch (IllegalArgumentException e) {
                    session.setAttribute("toastMessage", "Invalid role specified.");
                    session.setAttribute("toastType", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + id);
                    return;
                }
            }

            accountRepo.update(account);
            session.setAttribute("toastMessage", "Account updated successfully.");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to update account: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/control");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = request.getParameter("id");

        if (userId == null || userId.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid account ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        try {
            Account userToDelete = accountRepo.findAccountById(userId);
            if (userToDelete == null) {
                session.setAttribute("toastMessage", "Account not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/control");
                return;
            }

            userToDelete.setPassword(null);
            userToDelete.setEmail(null);
            userToDelete.setUsername("user_deleted");
            userToDelete.setId(userToDelete.getId());

            accountRepo.update(userToDelete);
            session.setAttribute("toastMessage", "Account deactivated successfully.");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to deactivate account: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/control");
    }

    private void view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid account ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        Account account = accountRepo.findAccountById(id);
        if (account == null) {
            session.setAttribute("toastMessage", "Account not found.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        List<Address> addressList = addressRepo.findByUserId(id);
        request.setAttribute("account", account);
        request.setAttribute("addresses", addressList);
        request.getRequestDispatcher("/admin/customerDetail.jsp").forward(request, response);
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String dobStr = request.getParameter("dob");
        String roleStr = request.getParameter("role");

        if (username == null || username.isEmpty() || email == null || email.isEmpty() || 
            dobStr == null || dobStr.isEmpty() || roleStr == null || roleStr.isEmpty()) {
            session.setAttribute("toastMessage", "All fields are required.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        try {
            LocalDate dob = LocalDate.parse(dobStr);
            Account.Role role = Account.Role.valueOf(roleStr.toUpperCase());
            String password = "changeit";

            Account account = new Account();
            account.setUsername(username);
            account.setEmail(email);
            account.setPassword(password);
            account.setDob(dob);
            account.setRole(role);

            accountRepo.create(account);
            session.setAttribute("toastMessage", "Account created successfully. Default password is 'changeit'");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to create account: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/control");
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        if (id == null || id.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid account ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        if (newPassword == null || newPassword.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
            session.setAttribute("toastMessage", "Both password fields are required.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + id);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("toastMessage", "Passwords do not match.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + id);
            return;
        }

        try {
            Account account = accountRepo.findAccountById(id);
            if (account == null) {
                session.setAttribute("toastMessage", "Account not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/control");
                return;
            }

            account.setPassword(newPassword);
            accountRepo.update(account);
            session.setAttribute("toastMessage", "Password changed successfully.");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to change password: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + id);
    }

    private void addressAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = request.getParameter("id");

        if (userId == null || userId.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid account ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        String address1 = request.getParameter("address_1");
        String postcode = request.getParameter("postcode");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        String contactNo = request.getParameter("contact_no");

        if (address1 == null || address1.isEmpty() || postcode == null || postcode.isEmpty() ||
            state == null || state.isEmpty() || country == null || country.isEmpty() ||
            contactNo == null || contactNo.isEmpty()) {
            session.setAttribute("toastMessage", "Required address fields are missing.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + userId);
            return;
        }

        try {
            Address address = new Address();
            address.setUser(accountRepo.findAccountById(userId));
            address.setName(request.getParameter("address_title"));
            address.setAddress_1(address1);
            address.setAddress_2(request.getParameter("address_2"));
            address.setAddress_3(request.getParameter("address_3"));
            address.setPostcode(Integer.parseInt(postcode));
            address.setCountry(country);
            address.setState(state);
            address.setContact_no(contactNo);
            address.setIsdefault(request.getParameter("isdefault") != null);

            addressRepo.create(address);
            session.setAttribute("toastMessage", "Address added successfully.");
            session.setAttribute("toastType", "success");
        } catch (NumberFormatException e) {
            session.setAttribute("toastMessage", "Invalid postcode format.");
            session.setAttribute("toastType", "error");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to add address: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + userId);
    }

    private void addressEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = request.getParameter("id");
        String addressId = request.getParameter("address_id");

        if (userId == null || userId.isEmpty() || addressId == null || addressId.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid account or address ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        Address address = addressRepo.findById(addressId);
        if (address == null) {
            session.setAttribute("toastMessage", "Address not found.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + userId);
            return;
        }

        String address1 = request.getParameter("address_1");
        String postcode = request.getParameter("postcode");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        String contactNo = request.getParameter("contact_no");

        if (address1 == null || address1.isEmpty() || postcode == null || postcode.isEmpty() ||
            state == null || state.isEmpty() || country == null || country.isEmpty() ||
            contactNo == null || contactNo.isEmpty()) {
            session.setAttribute("toastMessage", "Required address fields are missing.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + userId);
            return;
        }

        try {
            address.setName(request.getParameter("address_title"));
            address.setAddress_1(address1);
            address.setAddress_2(request.getParameter("address_2"));
            address.setAddress_3(request.getParameter("address_3"));
            address.setPostcode(Integer.parseInt(postcode));
            address.setState(state);
            address.setCountry(country);
            address.setContact_no(contactNo);
            address.setIsdefault(request.getParameter("isdefault") != null);

            addressRepo.update(address);
            session.setAttribute("toastMessage", "Address updated successfully.");
            session.setAttribute("toastType", "success");
        } catch (NumberFormatException e) {
            session.setAttribute("toastMessage", "Invalid postcode format.");
            session.setAttribute("toastType", "error");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to update address: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/control?action=view&id=" + userId);
    }

    private void deleteConfirmed(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = request.getParameter("id");

        if (userId == null || userId.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid account ID.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/control");
            return;
        }

        try {
            Account account = accountRepo.findAccountById(userId);
            if (account == null) {
                session.setAttribute("toastMessage", "Account not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/control");
                return;
            }

            accountRepo.delete(account);
            session.setAttribute("toastMessage", "Account deleted successfully.");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to delete account: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin/control");
    }
}