package com.samseng.web.controllers;

import com.samseng.web.Dao.AddressDao;
import com.samseng.web.models.Address;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/editAddress")
public class EditAddressServlet extends HttpServlet {
    @Inject
    private AddressDao addressDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        List<Address> address = addressDao.findByUserId(id);
        req.setAttribute("address", address);
        req.getRequestDispatcher("/userProfile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Address address = addressDao.findById(req.getParameter("id"));        address.setName(req.getParameter("name"));
        address.setContact_no(req.getParameter("contact_no"));
        address.setAddress_1(req.getParameter("address_1"));
        address.setAddress_2(req.getParameter("address_2"));
        address.setAddress_3(req.getParameter("address_3"));
        address.setPostcode(Integer.parseInt(req.getParameter("postcode")));
        address.setState(req.getParameter("state"));
        address.setCountry(req.getParameter("country"));
        address.setIsdefault(req.getParameter("isdefault") != null);

        addressDao.update(address);

        if (address.getIsdefault()) {
            addressDao.unsetOtherDefaults(address.getUser().getId(), address.getId());
        }

        resp.sendRedirect("addresses");
    }
}
