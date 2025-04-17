package com.samseng.web.controllers;

import java.util.*;

import com.samseng.web.models.Attribute;
import com.samseng.web.models.Variant;
import com.samseng.web.models.Variant_Attribute;
import com.samseng.web.repositories.Attribute.AttributeRepository;
import com.samseng.web.repositories.Attribute.AttributeRepositoryImpl;
import com.samseng.web.repositories.Variant.VariantRepository;
import com.samseng.web.repositories.Variant_Attribute.Variant_AttributeRepository;

import com.samseng.web.models.Product;
import com.samseng.web.repositories.Product.ProductRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;

@Transactional
@WebServlet(name = "productDetail", urlPatterns = {"/admin/productDetail"})
public class productDetailServlet extends HttpServlet {

    @Inject
    private ProductRepository productRepository;

    @Inject
    private AttributeRepository attributeRepository;

    @Inject
    private Variant_AttributeRepository variantAttributeRepository;

    @Inject
    private VariantRepository variantRepository;
    @Inject
    private AttributeRepositoryImpl attributeRepositoryImpl;

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
            String productId = request.getParameter("productId");
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String desc = request.getParameter("desc");
            String[] images = request.getParameterValues("imageUrls");
            Set<String> imageSet = new HashSet<>();
            if (images != null) {
                for (String img : images) {
                    imageSet.add(img);
                }
            }

            Product product = productRepository.findById(productId);
            if (product != null) {
                product.setName(name);
                product.setCategory(category);
                product.setDesc(desc);
                product.setImageUrls(imageSet);
                productRepository.update(product);
            }

            response.sendRedirect(request.getContextPath() + "/admin/productDetail?id=" + productId);
            return;
        } else if ("list".equals(action)) {
            int page = 1;
            int pageSize = 10;

            String pageParam = request.getParameter("page");
            if (pageParam != null && pageParam.matches("\\d+")) {
                page = Integer.parseInt(pageParam);
            }

            long totalCount = productRepository.count();
            int totalPages = (int) Math.ceil((double) totalCount / pageSize);
            int startItem = (page - 1) * pageSize + 1;
            int endItem = Math.min(page * pageSize, (int) totalCount);

            List<Product> products = productRepository.findPaged(page, pageSize);

            request.setAttribute("products", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalItems", totalCount);
            request.setAttribute("startItem", startItem);
            request.setAttribute("endItem", endItem);

            request.getRequestDispatcher("/admin/productList.jsp").forward(request, response);
            return;
        }

        String productId = request.getParameter("id");
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
                String variantId = va.getVariantID().getVariantId();
                String attrName = va.getAttributeID().getName();
                String value = va.getValue();

                variantAttrMap
                        .computeIfAbsent(variantId, k -> new HashMap<>())
                        .put(attrName, value);
            }

            Map<String, Set<String>> attributeValuesMap = new HashMap<>();

            for (Variant_Attribute va : variantAttributeRepository.findByProductId(productId)) {
                String attrName = va.getAttributeID().getName();
                attributeValuesMap
                        .computeIfAbsent(attrName, k -> new LinkedHashSet<>())
                        .add(va.getValue());
            }

            request.setAttribute("attributeValuesMap", attributeValuesMap);
            request.setAttribute("imageSet", product.getImageUrls());
            request.setAttribute("variantAttrMap", variantAttrMap);
            request.setAttribute("attributeList", attributeList);
            request.setAttribute("variantList", variantList);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/admin/productDetail.jsp").forward(request, response);
        }

        response.sendRedirect("/admin/productList.jsp");
    }
}
