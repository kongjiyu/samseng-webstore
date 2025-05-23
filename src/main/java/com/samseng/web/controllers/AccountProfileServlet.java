package com.samseng.web.controllers;

import com.samseng.web.models.Account;
import com.samseng.web.models.Address;
import com.samseng.web.repositories.Account.AccountRepository;
import com.samseng.web.repositories.Address.AddressRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDate;
import java.util.List;

@Transactional
@WebServlet(name = "profile", urlPatterns = {"/user/profile"})
@MultipartConfig
public class AccountProfileServlet extends HttpServlet {

    @Inject
    private AccountRepository accountRepo;

    @Inject
    AddressRepository addressRepo;

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

        if ("changePassword".equals(action)) {
            updatePassword(request, response);
            return;
        }

        if ("update".equals(action)) {
            update(request, response);
            return;
        } else if ("delete".equals(action)) {
            delete(request, response);
            return;
        } else if ("list".equals(action)) {
            list(request, response);
            return;
        }
        if ("addressEdit".equals(action)) {
            addressEdit(request, response);
            return;
        } else if ("addressAdd".equals(action)) {
            addressAdd(request, response);
            return;
        } else if ("addressDelete".equals(action)) {
            addressDelete(request, response);
            return;
        } else if ("deleteConfirmed".equals(action)) {
            deleteConfirmed(request, response);
            return;
        }

        try {
            Account accountProfile = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());
            List<Address> addressList = addressRepo.findByUserId(accountProfile.getId());
            request.setAttribute("addresses", addressList);
            request.getRequestDispatcher("/user/userProfile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/user/userProfile.jsp").forward(request, response);
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());
        Account.Role newRole = account.getRole();
        LocalDate newDob = account.getDob();
        String password = account.getPassword();
        String newUsername = request.getParameter("username");
        String email = request.getParameter("email");

        if (account != null) {
            account.setUsername(newUsername);
            // Check if email has changed before updating
            boolean emailChanged = !account.getEmail().equals(email);
            account.setRole(newRole);
            account.setDob(newDob);
            account.setPassword(password);
            if (emailChanged) {
                account.setEmail(email);
                try {
                    accountRepo.update(account);
                    request.getSession().setAttribute("toastType", "success");
                    request.getSession().setAttribute("toastMessage", "Email updated. Please log in again.");
                    response.sendRedirect(request.getContextPath() + "/logout");
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    request.getSession().setAttribute("toastType", "error");
                    request.getSession().setAttribute("toastMessage", "Failed to update profile.");
                    request.setAttribute("error", "Failed to update profile.");
                    request.getRequestDispatcher("/userProfile.jsp").forward(request, response);
                    return;
                }
            } else {
                account.setEmail(email);
                try {
                    accountRepo.update(account);
                    request.getSession().setAttribute("profile", account);
                    request.getSession().setAttribute("toastType", "success");
                    request.getSession().setAttribute("toastMessage", "Profile updated successfully.");
                    response.sendRedirect(request.getContextPath() + "/login-flow");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.getSession().setAttribute("toastType", "error");
                    request.getSession().setAttribute("toastMessage", "Failed to update profile.");
                    request.setAttribute("error", "Failed to update profile.");
                    request.getRequestDispatcher("/userProfile.jsp").forward(request, response);
                }
            }
        } else {
            request.getSession().setAttribute("toastType", "error");
            request.getSession().setAttribute("toastMessage", "Failed to update profile.");
            response.sendRedirect(request.getContextPath() + "/login-flow");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());
        if (account != null) {
            try {
                accountRepo.delete(account);
                request.getSession().setAttribute("toastType", "success");
                request.getSession().setAttribute("toastMessage", "Account deleted successfully.");
                response.sendRedirect("loginRegisterForm.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("toastType", "error");
                request.getSession().setAttribute("toastMessage", "Failed to delete account.");
                request.setAttribute("error", "Failed to delete account.");
                request.getRequestDispatcher("userProfile.jsp").forward(request, response);
            }
        } else {
            request.getSession().setAttribute("toastType", "error");
            request.getSession().setAttribute("toastMessage", "Failed to delete account.");
            response.sendRedirect("loginRegisterForm.jsp");
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Account> users = accountRepo.findAll();
        request.setAttribute("users", users);
        request.getSession().setAttribute("toastType", "info");
        request.getSession().setAttribute("toastMessage", "Listing all users.");
        request.getRequestDispatcher("/userList.jsp").forward(request, response);
    }

    private void addressEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("address_id");
        Address address = addressRepo.findById(id);

        if (address != null) {
            String name = request.getParameter("address_title");
            String contactNo = request.getParameter("contact_no");
            String address1 = request.getParameter("address_1");
            String postcodeStr = request.getParameter("postcode");
            String state = request.getParameter("state");
            String country = request.getParameter("country");

            Account accountProfile = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());
            List<Address> addressList = addressRepo.findByUserId(accountProfile.getId());

            if (name == null || name.isBlank() || contactNo == null || contactNo.isBlank() ||
                    address1 == null || address1.isBlank() || postcodeStr == null || postcodeStr.isBlank() ||
                    state == null || state.isBlank() || country == null || country.isBlank()) {
                request.getSession().setAttribute("toastType", "error");
                request.getSession().setAttribute("toastMessage", "All required fields must be filled.");
                response.sendRedirect(request.getContextPath() + "/user/profile");
                return;
            }

            if (!contactNo.matches("^(\\+?60)?1[0-9]{8,9}$")  && !contactNo.matches("^01[0-9]{8,9}")) {
                request.getSession().setAttribute("toastType", "error");
                request.getSession().setAttribute("toastMessage", "Invalid Malaysian phone number.");
                response.sendRedirect(request.getContextPath() + "/user/profile");
                return;
            }

            if (!postcodeStr.matches("^[0-9]{5}$")) {
                request.getSession().setAttribute("toastType", "error");
                request.getSession().setAttribute("toastMessage", "Postcode must be a valid 5-digit Malaysia postcode.");
                response.sendRedirect(request.getContextPath() + "/user/profile");
                return;
            }

            int postcode;
            try {
                postcode = Integer.parseInt(postcodeStr);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("toastType", "error");
                request.getSession().setAttribute("toastMessage", "Postcode must be a number.");
                response.sendRedirect(request.getContextPath() + "/user/profile");
                return;
            }

            address.setName(name);
            address.setContact_no(contactNo);
            address.setAddress_1(address1);
            address.setAddress_2(request.getParameter("address_2"));
            address.setAddress_3(request.getParameter("address_3"));
            address.setPostcode(postcode);
            address.setState(state);
            address.setCountry(country);
            if (request.getParameter("isdefault") != null) {
                // Unset other defaults first
                addressRepo.unsetOtherDefaults(address.getUser().getId(), address.getId());
                address.setIsdefault(true);
            } else {
                address.setIsdefault(false);
            }
            addressRepo.update(address);

            addressList = addressRepo.findByUserId(address.getUser().getId());
            request.setAttribute("addresses", addressList);

            request.getSession().setAttribute("toastType", "success");
            request.getSession().setAttribute("toastMessage", "Successfully updated address.");
            response.sendRedirect(request.getContextPath() + "/user/profile");
        } else {
            request.getSession().setAttribute("toastType", "error");
            request.getSession().setAttribute("toastMessage", "Address not found.");
            response.sendRedirect(request.getContextPath() + "/user/profile");
        }
    }

    private void addressAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Principal principal = req.getUserPrincipal();

        if (principal == null) {
            resp.sendRedirect(req.getContextPath() + "/login-flow");
            return;
        }

        Account user = accountRepo.findAccountByEmail(principal.getName());

        if (user == null) {
            resp.sendRedirect("/login-flow");
            return;
        }

        // Validation logic
        String name = req.getParameter("address_title");
        String contactNo = req.getParameter("contact_no");
        String address1 = req.getParameter("address_1");
        String postcodeStr = req.getParameter("postcode");
        String state = req.getParameter("state");
        String country = req.getParameter("country");

        // Retrieve addresses for request attribute (needed for all forwards)
        Account accountProfile = accountRepo.findAccountByEmail(req.getUserPrincipal().getName());
        List<Address> addressList = addressRepo.findByUserId(accountProfile.getId());

        req.setAttribute("addresses", addressList);

        if (name == null || name.isBlank() || contactNo == null || contactNo.isBlank() ||
                address1 == null || address1.isBlank() || postcodeStr == null || postcodeStr.isBlank() ||
                state == null || state.isBlank() || country == null || country.isBlank()) {
            req.getSession().setAttribute("toastType", "error");
            req.getSession().setAttribute("toastMessage", "All required fields must be filled.");
            resp.sendRedirect(req.getContextPath() + "/user/profile");
            return;
        }

        // Malaysian phone number validation
        if (!contactNo.matches("^(\\+?60)?1[0-9]{8,9}$") && !contactNo.matches("^01[0-9]{8,9}") ) {
            req.getSession().setAttribute("toastType", "error");
            req.getSession().setAttribute("toastMessage", "Invalid Malaysian phone number.");
            try {
                req.getRequestDispatcher("/user/userProfile.jsp").forward(req, resp);
            } catch (ServletException e) {
                throw new IOException(e);
            }
            return;
        }

        if (!postcodeStr.matches("^[0-9]{5}$")) {
            req.getSession().setAttribute("toastType", "error");
            req.getSession().setAttribute("toastMessage", "Postcode must be a valid 5-digit Malaysia postcode.");
            try {
                req.getRequestDispatcher("/user/userProfile.jsp").forward(req, resp);
            } catch (ServletException e) {
                throw new IOException(e);
            }
            return;
        }

        int postcode;
        try {
            postcode = Integer.parseInt(postcodeStr);
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("toastType", "error");
            req.getSession().setAttribute("toastMessage", "Postcode must be a number.");
            try {
                req.getRequestDispatcher("/user/userProfile.jsp").forward(req, resp);
            } catch (ServletException ex) {
                throw new IOException(ex);
            }
            return;
        }

        Address address = new Address();
        address.setUser(user);
        address.setName(name);
        address.setContact_no(contactNo);
        address.setAddress_1(address1);
        address.setAddress_2(req.getParameter("address_2"));
        address.setAddress_3(req.getParameter("address_3"));
        address.setPostcode(postcode);
        address.setState(state);
        address.setCountry(country);
        List<Address> existingAddresses = addressRepo.findByUserId(user.getId());
        boolean hasDefault = false;
        for (Address a : existingAddresses) {
            if (a.getIsdefault()) {
                hasDefault = true;
                break;
            }
        }
        address.setIsdefault(!hasDefault || req.getParameter("isdefault") != null);

        System.out.println("User ID: " + user.getId());
        System.out.println("Address user: " + address.getUser());
        System.out.println("Address user id: " + address.getUser().getId());

        addressRepo.create(address);

        if (address.getIsdefault()) {
            addressRepo.unsetOtherDefaults(user.getId(), address.getId());
        }

        // refresh addresses after add
        List<Address> updatedAddressList = addressRepo.findByUserId(user.getId());
        req.setAttribute("addresses", updatedAddressList);
        req.getSession().setAttribute("toastType", "success");
        req.getSession().setAttribute("toastMessage", "Address added successfully.");
        resp.sendRedirect(req.getContextPath() + "/user/profile");
        return;
    }

    private void addressDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String addressId = request.getParameter("id");
        boolean deleted = false;
        if (addressId != null && !addressId.isEmpty()) {
            Address address = addressRepo.findById(addressId);
            if (address != null) {
                addressRepo.delete(address);
                deleted = true;
            }
        }
        if (deleted) {
            request.getSession().setAttribute("toastType", "success");
            request.getSession().setAttribute("toastMessage", "Address deleted successfully.");
        }
        response.sendRedirect(request.getContextPath() + "/user/profile"); // Redirect to address list
    }


    private void updatePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());

        Account accountProfile = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());
        List<Address> addressList = addressRepo.findByUserId(accountProfile.getId());
        request.setAttribute("addresses", addressList);

        // Validate current password before checking new/confirm password fields
        String currentPassword = request.getParameter("current_password");

        if (currentPassword == null || currentPassword.isBlank()) {
            request.getSession().setAttribute("toastType", "error");
            request.getSession().setAttribute("toastMessage", "Current password is required.");
            request.getRequestDispatcher("/user/userProfile.jsp").forward(request, response);
            return;
        }

        if (!account.getPassword().equals(currentPassword)) {
            request.getSession().setAttribute("toastType", "error");
            request.getSession().setAttribute("toastMessage", "Current password is incorrect.");
            request.getRequestDispatcher("/user/userProfile.jsp").forward(request, response);
            return;
        }

        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        if (newPassword == null || confirmPassword == null || newPassword.isBlank() || confirmPassword.isBlank()) {
            request.getSession().setAttribute("toastType", "error");
            request.getSession().setAttribute("toastMessage", "Both password fields are required.");
            request.getRequestDispatcher("/user/userProfile.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.getSession().setAttribute("toastType", "error");
            request.getSession().setAttribute("toastMessage", "Passwords do not match.");
            request.getRequestDispatcher("/user/userProfile.jsp").forward(request, response);
            return;
        }

        try {
            account.setPassword(newPassword);
            accountRepo.update(account);
            request.getSession().setAttribute("toastType", "success");
            request.getSession().setAttribute("toastMessage", "Password updated successfully.");
        } catch (Exception e) {
            request.getSession().setAttribute("toastType", "error");
            request.getSession().setAttribute("toastMessage", "Failed to update password.");
        }

        request.getRequestDispatcher("/user/userProfile.jsp").forward(request, response);
    }

    private void deleteConfirmed(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());
        if (account != null) {
            try {
                accountRepo.softDelete(account.getId());

                request.getSession().setAttribute("toastType", "success");
                request.getSession().setAttribute("toastMessage", "Account deleted successfully.");
                response.sendRedirect(request.getContextPath() + "/logout");
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("toastType", "error");
                request.getSession().setAttribute("toastMessage", "Failed to delete account.");
                request.setAttribute("error", "Failed to delete account.");
                request.getRequestDispatcher("/user/userProfile.jsp").forward(request, response);
            }
        } else {
            request.getSession().setAttribute("toastType", "error");
            request.getSession().setAttribute("toastMessage", "Failed to delete account.");
            response.sendRedirect("loginRegisterForm.jsp");
        }
    }
}