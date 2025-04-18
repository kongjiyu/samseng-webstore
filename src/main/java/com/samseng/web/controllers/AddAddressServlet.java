package com.samseng.web.controllers;

import com.samseng.web.Dao.AddressDao;
import com.samseng.web.models.Account;
import com.samseng.web.models.Address;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/create")
public class AddAddressServlet extends HttpServlet {
    @Inject
    private AddressDao addressDao;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Address address = new Address();

        HttpSession session = req.getSession();
        Account user = (Account) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("loginRegisterForm.jsp");
            return;
        }
        address.setUser(user);
        address.setName(req.getParameter("name"));
        address.setContact_no(req.getParameter("contact_no"));
        address.setAddress_1(req.getParameter("address_1"));
        address.setAddress_2(req.getParameter("address_2"));
        address.setAddress_3(req.getParameter("address_3"));
        address.setPostcode(Integer.parseInt(req.getParameter("postcode")));
        address.setState(req.getParameter("state"));
        address.setCountry(req.getParameter("country"));
        address.setIsdefault(req.getParameter("isdefault") != null);

        addressDao.create(address);

        if (address.getIsdefault()) {
            addressDao.unsetOtherDefaults(user.getId(), address.getId());
        }

        resp.sendRedirect("addresses");
    }
}
