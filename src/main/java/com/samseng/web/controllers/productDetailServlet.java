//package com.samseng.web.controllers;
//
//import java.util.HashSet;
//import java.util.Set;
//
//import com.samseng.web.models.Product;
//import com.samseng.web.repositories.Product.ProductRepository;
//import jakarta.inject.Inject;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//
//@WebServlet(name = "productDetail", urlPatterns = {"/admin/productDetail"})
//public class productDetailServlet extends HttpServlet {
//
//    @Inject
//    private ProductRepository productRepository;
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String action = request.getParameter("action");
//
//        if ("update".equals(action)) {
//            String productId = request.getParameter("productId");
//            String name = request.getParameter("name");
//            String category = request.getParameter("category");
//            String desc = request.getParameter("desc");
//            String[] images = request.getParameterValues("image");
//            Set<String> imageSet = new HashSet<>();
//            if (images != null) {
//                for (String img : images) {
//                    imageSet.add(img);
//                }
//            }
//
//            Product product = productRepository.findById(productId);
//            if (product != null) {
//                product.setName(name);
//                product.setCategory(category);
//                product.setDesc(desc);
//                    product.setImages(imageSet);
//                productRepository.update(product);
//            }
//
//            response.sendRedirect(request.getContextPath() + "/admin/productDetail?id=" + productId);
//            return;
//        }
//
//        String productId = request.getParameter("id");
//        if (productId != null && !productId.isEmpty()) {
//            Product product = productRepository.findById(productId);
//            if (product != null) {
//                request.setAttribute("product", product);
//                request.getRequestDispatcher("/admin/productDetail.jsp").forward(request, response);
//                return;
//            }
//        }
//
//        response.sendRedirect("/admin/productList.jsp");
//    }
//}
//
