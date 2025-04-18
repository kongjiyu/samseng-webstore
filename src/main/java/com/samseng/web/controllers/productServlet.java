package com.samseng.web.controllers;

import java.io.File;
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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Transactional
@WebServlet(name = "product", urlPatterns = {"/admin/product"})
@MultipartConfig
public class productServlet extends HttpServlet {

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
            updateProduct(request, response);
            return;
        } else if ("list".equals(action)) {
            listProducts(request, response);
            return;
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
            return;
        } else if ("create".equals(action)) {
            Product emptyProduct = new Product();

            request.setAttribute("product", emptyProduct);
            request.setAttribute("variantList", Collections.emptyList());
            request.setAttribute("attributeList", Collections.emptyList());
            request.setAttribute("attributeValuesMap", new HashMap<>());
            request.setAttribute("variantAttrMap", new HashMap<>());
            request.setAttribute("imageSet", new HashSet<>());
            request.getRequestDispatcher("/admin/productDetail.jsp").forward(request, response);
            return;
        } else if ("save".equals(action)) {
            saveProduct(request, response);
            return;
        } else if ("saveAttribute".equals(action)) {
            saveAttribute(request, response);
            return;
        } else if ("saveVariant".equals(action)) {
            saveVariant(request, response);
            return;
        } else if ("uploadImage".equals(action)) {
            uploadProductImage(request, response);
            return;
        }

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

    private void saveProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productId = request.getParameter("productId");
        if (productId == null || productId.isEmpty()) {
            productId = UUID.randomUUID().toString();
        }

        String name = request.getParameter("productName");
        String category = request.getParameter("productCategory");
        String desc = request.getParameter("productDesc");
        String[] images = request.getParameterValues("imageUrls");
        Set<String> imageSet = new HashSet<>();
        if (images != null) {
            Collections.addAll(imageSet, images);
        }

        Product product = new Product();
        product.setId(productId);
        product.setName(name);
        product.setCategory(category);
        product.setDesc(desc);
        product.setImageUrls(imageSet);

        productRepository.create(product);

        response.sendRedirect(request.getContextPath() + "/admin/product?id=" + productId);
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productId = request.getParameter("productId");
        String name = request.getParameter("productName");
        String category = request.getParameter("productCategory");
        String desc = request.getParameter("productDesc");

        Product product = productRepository.findById(productId);
        if (product != null) {
            product.setName(name);
            product.setCategory(category);
            product.setDesc(desc);
            productRepository.update(product);
        }

        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productId = request.getParameter("productId");
        if (productId != null && !productId.isEmpty()) {
            Product product = productRepository.findById(productId);
            if (product != null) {
                productRepository.delete(product); // Hibernate deletes product + orphans
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
    }

    private void saveAttribute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productId = request.getParameter("productId");
        String attrName = request.getParameter("attributeName");

        if (productId != null && attrName != null && !attrName.trim().isEmpty()) {
            Attribute attribute = new Attribute();
            attribute.setName(attrName);
            attributeRepository.create(attribute);
        }

        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void saveVariant(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productId = request.getParameter("productId");
        String variantId = request.getParameter("variantId");
        String variantName = request.getParameter("variantName");
        String priceStr = request.getParameter("variantPrice");

        if (productId != null && variantId != null && variantName != null && priceStr != null) {
            try {
                double price = Double.parseDouble(priceStr);
                Variant variant = new Variant();
                variant.setVariantId(variantId);
                variant.setVariantName(variantName);
                variant.setPrice(price);
                variant.setProduct(productRepository.findById(productId));
                variantRepository.create(variant);
            } catch (NumberFormatException e) {
                // Log or handle invalid price
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void uploadProductImage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String productId = request.getParameter("productId");
        if (productId == null || productId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required.");
            return;
        }

        // Absolute path on disk where images are saved (match reverse proxy setup)
        String uploadDir = "/var/www/data/uploads"; // or your actual folder in server
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) uploadFolder.mkdirs();

        // Find next image number
        File[] existing = uploadFolder.listFiles((dir, name) ->
                name.startsWith(productId + "-") && name.endsWith(".png"));
        int max = 0;
        if (existing != null) {
            for (File file : existing) {
                String name = file.getName();
                try {
                    int num = Integer.parseInt(name.substring((productId + "-").length(), name.length() - 4));
                    if (num > max) max = num;
                } catch (NumberFormatException ignored) {}
            }
        }

        int nextNo = max + 1;
        String newFileName = productId + "-" + nextNo + ".png";
        Part filePart = request.getPart("imageFile");

        if (filePart != null && filePart.getSize() > 0) {
            File outputFile = new File(uploadFolder, newFileName);
            filePart.write(outputFile.getAbsolutePath());
            System.out.println("Saving to: " + outputFile.getAbsolutePath());

            // Save filename to product imageUrls
            Product product = productRepository.findById(productId);
            if (product != null) {
                Set<String> urls = product.getImageUrls();
                urls.add(newFileName);
                product.setImageUrls(urls);
                productRepository.update(product);
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }
}
