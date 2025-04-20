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


         if ("update".equals(action)) {
             update(request,response);
             return;
         }
         else if ("delete".equals(action)) {
             delete(request,response);
             return;
         }
         else if ("list".equals(action)) {
             list(request,response);
             return;
         }
        if ("addressEdit".equals(action)) {
            addressEdit(request,response);
            return;
        } else if ("addressAdd".equals(action)) {
            addressAdd(request,response);
            return;
        } else if ("addressDelete".equals(action)) {
            addressDelete(request,response);
            return;
        }


        Account accountProfile = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());
        List<Address> addressList = addressRepo.findByUserId(accountProfile.getId());
        request.setAttribute("profile", accountProfile);
        request.setAttribute("addresses", addressList);
        request.getRequestDispatcher("/user/userProfile.jsp").forward(request, response);
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       Account account = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());
        Account.Role newRole = account.getRole();
        LocalDate newDob = account.getDob();
        String newUsername = request.getParameter("username");
        String email = request.getParameter("email");
        if (account != null) {
            if(request.getParameter("username") == null) {
                String oldUsername = account.getUsername();
                account.setUsername(oldUsername);
                account.setEmail(email);
                account.setRole(newRole);
                account.setDob(newDob);
                account.setPassword(account.getPassword());
            }
            else if(request.getParameter("email") == null) {
                account.setUsername(newUsername);
                String oldEmail = account.getEmail();
                account.setEmail(oldEmail);
                account.setRole(newRole);
                account.setDob(newDob);
                account.setPassword(account.getPassword());
            }
            else {
                account.setUsername(newUsername);
                account.setEmail(email);
                account.setRole(newRole);
                account.setDob(newDob);
                account.setPassword(account.getPassword());
            }
            try {
                accountRepo.update(account);
                response.sendRedirect(request.getContextPath()+"/login-flow");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Failed to update profile.");
                request.getRequestDispatcher("/userProfile.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() +"/login-flow");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = accountRepo.findAccountByEmail(request.getUserPrincipal().getName());
        if (account != null) {
            try {
                accountRepo.delete(account);
                response.sendRedirect("loginRegisterForm.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Failed to delete account.");
                request.getRequestDispatcher("userProfile.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("loginRegisterForm.jsp");
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Account> users =  accountRepo.findAll();
        request.setAttribute("users", users);

        request.getRequestDispatcher("/userList.jsp").forward(request, response);
    }
    private void addressEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("address_id");
        Address address = addressRepo.findById(id);
        if (address != null) {
            address.setName(request.getParameter("address_title"));
            address.setContact_no(request.getParameter("contact_no"));
            address.setAddress_1(request.getParameter("address_1"));
            address.setAddress_2(request.getParameter("address_2"));
            address.setAddress_3(request.getParameter("address_3"));
            address.setPostcode(Integer.parseInt(request.getParameter("postcode")));
            address.setState(request.getParameter("state"));
            address.setCountry(request.getParameter("country"));
            address.setIsdefault(request.getParameter("isdefault") != null);
        }

        addressRepo.update(address);

        if (address.getIsdefault()) {
            addressRepo.unsetOtherDefaults(address.getUser().getId(), address.getId());
        }

        response.sendRedirect(request.getContextPath() + "/user/profile");
    }

    private void addressAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Principal principal = req.getUserPrincipal();

        if (principal == null) {
            resp.sendRedirect(req.getContextPath() + "/login-flow");
            return;
        }

        Account user = accountRepo.findAccountByEmail(principal.getName());

        if (user == null) {
            resp.sendRedirect("loginRegisterForm.jsp");
            return;
        }
        Address address = new Address();
        address.setUser(user);
        address.setName(req.getParameter("address_title"));
        address.setContact_no(req.getParameter("contact_no"));
        address.setAddress_1(req.getParameter("address_1"));
        address.setAddress_2(req.getParameter("address_2"));
        address.setAddress_3(req.getParameter("address_3"));
        address.setPostcode(Integer.parseInt(req.getParameter("postcode")));
        address.setState(req.getParameter("state"));
        address.setCountry(req.getParameter("country"));
        address.setIsdefault(req.getParameter("isdefault") != null);

        System.out.println("User ID: " + user.getId());
        System.out.println("Address user: " + address.getUser());
        System.out.println("Address user id: " + address.getUser().getId());

        addressRepo.create(address);

        if (address.getIsdefault()) {
            addressRepo.unsetOtherDefaults(user.getId(), address.getId());
        }

        resp.sendRedirect(req.getContextPath() + "/user/profile");
    }
    private void addressDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String addressId = request.getParameter("id");

        if (addressId != null && !addressId.isEmpty()) {
            Address address = addressRepo.findById(addressId);
            if (address != null) {
                addressRepo.delete(address);
            }
        }

        response.sendRedirect(request.getContextPath() + "/user/profile"); // Redirect to address list
    }



}


