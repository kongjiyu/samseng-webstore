package com.samseng.web.controllers;

import com.samseng.web.Dao.AddressDao;
import com.samseng.web.models.Address;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteAddress")
public class DeleteAddressServlet extends HttpServlet {

    @Inject
    private AddressDao addressDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String addressId = request.getParameter("id");

        if (addressId != null && !addressId.isEmpty()) {
            Address address = addressDao.findById(addressId);
            if (address != null) {
                addressDao.delete(address);
            }
        }

        response.sendRedirect("addresses"); // Redirect to address list
    }
}
