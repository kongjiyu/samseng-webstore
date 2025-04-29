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
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import lombok.extern.log4j.Log4j2;

import java.io.IOException;
import java.util.*;

@Log4j2
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
        HttpSession session = request.getSession();
        
        try {
            String productId = request.getParameter("productId");
            
            if (productId == null || productId.trim().isEmpty()) {
                log.warn("Missing product ID in request");
                session.setAttribute("toastMessage", "Product ID is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/user/products");
                return;
            }

            log.info("Fetching product details for product ID: {}", productId);
            Product product = productRepository.findById(productId);

            if (product == null) {
                log.warn("Product not found: {}", productId);
                session.setAttribute("toastMessage", "Product not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/user/products");
                return;
            }

            try {
                // Get product images
                Set<String> images = product.getImageUrls();
                if (images == null || images.isEmpty()) {
                    log.warn("No images found for product: {}", productId);
                    images = new HashSet<>();
                }

                // Get attributes
                List<Attribute> attributeList = attributeRepository.findByProductId(productId);
                if (attributeList == null) {
                    log.warn("No attributes found for product: {}", productId);
                    attributeList = new ArrayList<>();
                }

                // Get variants
                List<Variant> variantList = variantRepository.findByProductId(productId);
                if (variantList == null) {
                    log.warn("No variants found for product: {}", productId);
                    variantList = new ArrayList<>();
                }

                // Get variant attributes
                Map<String, Map<String, String>> variantAttrMap = new HashMap<>();
                List<Variant_Attribute> variantAttributes = variantAttributeRepository.findByProductId(productId);
                
                if (variantAttributes != null) {
                    for (Variant_Attribute va : variantAttributes) {
                        try {
                            String variantId = va.getVariant().getVariantId();
                            String attrName = va.getAttribute().getName();
                            String value = va.getValue();

                            variantAttrMap
                                    .computeIfAbsent(variantId, k -> new HashMap<>())
                                    .put(attrName, value);
                        } catch (Exception e) {
                            log.error("Error processing variant attribute for product: {}", productId, e);
                        }
                    }
                }

                // Get attribute values
                Map<String, Set<String>> attributeValuesMap = new HashMap<>();
                if (variantAttributes != null) {
                    for (Variant_Attribute va : variantAttributes) {
                        try {
                            String attrName = va.getAttribute().getName();
                            attributeValuesMap
                                    .computeIfAbsent(attrName, k -> new LinkedHashSet<>())
                                    .add(va.getValue());
                        } catch (Exception e) {
                            log.error("Error processing attribute value for product: {}", productId, e);
                        }
                    }
                }

                // Get comments
                List<Comment> commentList = commentRepository.findByProductId(productId);
                if (commentList == null) {
                    log.warn("No comments found for product: {}", productId);
                    commentList = new ArrayList<>();
                }

                // Set request attributes
                request.setAttribute("attributeValuesMap", attributeValuesMap);
                request.setAttribute("imageSet", images);
                request.setAttribute("variantAttrMap", variantAttrMap);
                request.setAttribute("attributeList", attributeList);
                request.setAttribute("variantList", variantList);
                request.setAttribute("product", product);
                request.setAttribute("commentList", commentList);

                log.info("Successfully retrieved product details for product: {}", productId);
                request.getRequestDispatcher("/productDetail.jsp").forward(request, response);

            } catch (Exception e) {
                log.error("Error processing product details for product: {}", productId, e);
                session.setAttribute("toastMessage", "Error processing product details. Please try again.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/user/products");
            }

        } catch (Exception e) {
            log.error("Unexpected error in product detail processing", e);
            session.setAttribute("toastMessage", "An unexpected error occurred. Please try again.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/user/products");
        }
    }
}
