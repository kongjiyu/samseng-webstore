package com.samseng.web.controllers;

import com.samseng.web.models.Product;
import com.samseng.web.repositories.Product.ProductRepositoryImpl;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/productDetail")
public class productDetailServlet extends HttpServlet {

    @Inject
    private ProductRepositoryImpl productRepository;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("id");

        if (productId != null && !productId.isEmpty()) {
            Product product = productRepository.findById(productId);
            if (product != null) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("productDetail.jsp").forward(request, response);
                return;
            }
        }

        response.sendRedirect("productList.jsp"); // fallback if product not found
    }
}
