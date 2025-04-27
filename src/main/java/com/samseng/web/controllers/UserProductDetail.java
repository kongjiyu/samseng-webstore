package com.samseng.web.controllers;

import com.samseng.web.models.*;
import com.samseng.web.repositories.Attribute.AttributeRepository;
import com.samseng.web.repositories.Comment.CommentRepository;
import com.samseng.web.repositories.Product.ProductRepository;
import com.samseng.web.repositories.Variant.VariantRepository;
import com.samseng.web.repositories.Variant_Attribute.Variant_AttributeRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.util.*;

@Transactional
@WebServlet("/product")
@MultipartConfig
public class UserProductDetail extends HttpServlet {
    @Inject
    private ProductRepository productRepository;

    @Inject
    private AttributeRepository attributeRepository;

    @Inject
    private Variant_AttributeRepository variantAttributeRepository;

    @Inject
    private VariantRepository variantRepository;

    @Inject
    private CommentRepository commentRepository;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        if (productId != null && !productId.isEmpty()) {
            Product product = productRepository.findById(productId);

            if (product == null) {
                request.setAttribute("errorMessage", "Product not found.");
                request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                return;
            }

            request.setAttribute("images", product.getImageUrls());
            List<Attribute> attributeList = attributeRepository.findByProductId(productId);
            List<Variant> variantList = variantRepository.findByProductId(productId);
            Map<String, Map<String, String>> variantAttrMap = new HashMap<>();

            for (Variant_Attribute va : variantAttributeRepository.findByProductId(productId)) {
                String variantId = va.getVariant().getVariantId();
                String attrName = va.getAttribute().getName();
                String value = va.getValue();

                variantAttrMap
                        .computeIfAbsent(variantId, k -> new HashMap<>())
                        .put(attrName, value);
            }

            Map<String, Set<String>> attributeValuesMap = new HashMap<>();

            for (Variant_Attribute va : variantAttributeRepository.findByProductId(productId)) {
                String attrName = va.getAttribute().getName();
                attributeValuesMap
                        .computeIfAbsent(attrName, k -> new LinkedHashSet<>())
                        .add(va.getValue());
            }

            List<Comment> commentList = commentRepository.findByProductId(productId);


            request.setAttribute("attributeValuesMap", attributeValuesMap);
            request.setAttribute("imageSet", product.getImageUrls());
            request.setAttribute("variantAttrMap", variantAttrMap);
            request.setAttribute("attributeList", attributeList);
            request.setAttribute("variantList", variantList);
            request.setAttribute("product", product);
            request.setAttribute("commentList", commentList);
            request.getRequestDispatcher("/productDetail.jsp").forward(request, response);
        }else{
            response.sendRedirect("/user/products");
        }

    }
}
