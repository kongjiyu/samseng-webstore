package com.samseng.web.controllers;

import com.samseng.web.models.Product;
import com.samseng.web.repositories.Product.ProductRepository;
import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class HeaderSearchServlet {

    @Inject
    private ProductRepository productRepository;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = productRepository.findAll();
        req.setAttribute("products", products);

        RequestDispatcher view = req.getRequestDispatcher("/general/userHeader.jsp");
        view.forward(req, resp);
    }
}
