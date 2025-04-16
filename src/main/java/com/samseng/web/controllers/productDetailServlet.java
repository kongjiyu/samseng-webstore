package com.samseng.web.controllers;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Map;
import java.util.HashMap;
import com.samseng.web.models.Attribute;
import com.samseng.web.models.Variant;
import com.samseng.web.models.Variant_Attribute;
import com.samseng.web.repositories.Attribute.AttributeRepository;
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

            List<Product> products = productRepository.findPaged(page, pageSize);
            long totalCount = productRepository.count();
            int totalPages = (int) Math.ceil((double) totalCount / pageSize);

            request.setAttribute("products", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("/admin/productList.jsp").forward(request, response);
            return;
        }

        String productId = request.getParameter("id");
        if (productId != null && !productId.isEmpty()) {
            Product product = productRepository.findById(productId);
            List<Attribute> dynamicAttributes = attributeRepository.findAll();
            List<Variant_Attribute> variantAttributes = variantAttributeRepository.findByProductId(productId);

            Map<String, Map<String, String>> variantAttrMap = new HashMap<>();
            for (Variant_Attribute va : variantAttributes) {
                String variantId = va.getVariantID().getVariantId();
                String attrName = va.getAttributeID().getName();
                String value = va.getValue();
                variantAttrMap.computeIfAbsent(variantId, k -> new HashMap<>()).put(attrName, value);
            }
            request.setAttribute("variantAttrMap", variantAttrMap);

            List<Variant> variants = variantRepository.findByProductId(productId);
            request.setAttribute("variantList", variants);
            Set<String> imageSet = new HashSet<>(product.getImageUrls());
            if (product != null) {
                request.setAttribute("imageSet", imageSet);
                request.setAttribute("product", product);
                request.setAttribute("dynamicAttributes", dynamicAttributes);
                request.setAttribute("variantAttributes", variantAttributes);
                request.getRequestDispatcher("/admin/productDetail.jsp").forward(request, response);
                return;
            }
        }

        response.sendRedirect("/admin/productList.jsp");
    }
}
