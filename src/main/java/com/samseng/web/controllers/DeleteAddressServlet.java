package com.samseng.web.controllers;

import com.samseng.web.models.Address;
import com.samseng.web.repositories.Address.AddressRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteAddress")
public class DeleteAddressServlet extends HttpServlet {

    @Inject
    private AddressRepository addressRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String addressId = request.getParameter("id");

        if (addressId != null && !addressId.isEmpty()) {
            Address address = addressRepo.findById(addressId);
            if (address != null) {
                addressRepo.delete(address);
            }
        }

        response.sendRedirect("addresses"); // Redirect to address list
    }
}
