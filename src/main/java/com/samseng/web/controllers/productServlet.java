package com.samseng.web.controllers;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.*;

import com.samseng.web.models.*;
import com.samseng.web.repositories.Attribute.AttributeRepository;
import com.samseng.web.repositories.Comment.CommentRepository;
import com.samseng.web.repositories.Reply.ReplyRepository;
import com.samseng.web.repositories.Variant.VariantRepository;
import com.samseng.web.repositories.Variant_Attribute.Variant_AttributeRepository;

import com.samseng.web.repositories.Product.ProductRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

import java.io.IOException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import lombok.extern.log4j.Log4j2;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Log4j2
@Transactional
@WebServlet("/admin/product")
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

    @Inject
    private CommentRepository commentRepository;

    @Inject
    private ReplyRepository replyRepository;

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
        String action = request.getParameter("action");
        String productId = request.getParameter("productId");

        try {
            // If action is null, default to product detail if productId exists
            if (action == null || action.trim().isEmpty()) {
                if (productId == null || productId.trim().isEmpty()) {
                    session.setAttribute("toastMessage", "No action or product ID specified");
                    session.setAttribute("toastType", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
                    return;
                }
                handleProductDetail(request, response);
                return;
            }

            switch (action.trim()) {
                case "update":
                    updateProduct(request, response);
                    break;
                case "list":
                    listProducts(request, response);
                    break;
                case "create":
                    createProduct(request, response);
                    break;
                case "save":
                    saveProduct(request, response);
                    break;
                case "saveAttribute":
                    saveAttribute(request, response);
                    break;
                case "saveAttributeValues":
                    saveAttributeValue(request, response);
                    break;
                case "saveVariant":
                    saveVariant(request, response);
                    break;
                case "uploadImage":
                    uploadProductImage(request, response);
                    break;
                case "saveVariantAttributes":
                    saveVariantAttributes(request, response);
                    break;
                case "replyComment":
                    replyComment(request, response);
                    break;
                case "viewComment":
                    viewComment(request, response);
                    break;
                case "deleteProduct":
                    deleteProductWithNull(request, response);
                    break;
                default:
                    handleProductDetail(request, response);
                    break;
            }
        } catch (Exception e) {
            log.error("Error processing request", e);
            session.setAttribute("toastMessage", "An unexpected error occurred. Please try again.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
        }
    }

    private void createProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Product emptyProduct = new Product();
            List<Attribute> allAttributes = attributeRepository.findAll();

            request.setAttribute("allAttributes", allAttributes);
            request.setAttribute("product", emptyProduct);
            request.setAttribute("variantList", Collections.emptyList());
            request.setAttribute("attributeList", Collections.emptyList());
            request.setAttribute("attributeValuesMap", new HashMap<>());
            request.setAttribute("variantAttrMap", new HashMap<>());
            request.setAttribute("imageSet", new HashSet<>());

            request.getRequestDispatcher("/admin/productDetail.jsp").forward(request, response);
        } catch (Exception e) {
            log.error("Error creating new product form", e);
            HttpSession session = request.getSession();
            session.setAttribute("toastMessage", "Error loading product creation form.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
        }
    }

    private void handleProductDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");

        if (productId == null || productId.trim().isEmpty()) {
            session.setAttribute("toastMessage", "Product ID is required.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
            return;
        }

        try {
            Product product = productRepository.findById(productId);
            if (product == null) {
                session.setAttribute("toastMessage", "Product not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
                return;
            }

            // Get all available attributes for the dropdown
            List<Attribute> allAttributes = attributeRepository.findAll();
            List<Attribute> attributeList = attributeRepository.findByProductId(productId);
            List<Variant> variantList = variantRepository.findByProductId(productId);
            variantList.sort(Comparator.comparing(Variant::getVariantName, String.CASE_INSENSITIVE_ORDER));

            // Prepare variant attributes map
            Map<String, Map<String, String>> variantAttrMap = new HashMap<>();
            for (Variant_Attribute va : variantAttributeRepository.findByProductId(productId)) {
                variantAttrMap
                        .computeIfAbsent(va.getVariant().getVariantId(), k -> new HashMap<>())
                        .put(va.getAttribute().getName(), va.getValue());
            }

            // Prepare attribute values map
            Map<String, Set<String>> attributeValuesMap = new HashMap<>();
            for (Variant_Attribute va : variantAttributeRepository.findByProductId(productId)) {
                attributeValuesMap
                        .computeIfAbsent(va.getAttribute().getName(), k -> new LinkedHashSet<>())
                        .add(va.getValue());
            }

            // Set all attributes in request
            request.setAttribute("images", product.getImageUrls());
            request.setAttribute("allAttributes", allAttributes);
            request.setAttribute("attributeValuesMap", attributeValuesMap);
            request.setAttribute("imageSet", product.getImageUrls());
            request.setAttribute("variantAttrMap", variantAttrMap);
            request.setAttribute("attributeList", attributeList);
            request.setAttribute("variantList", variantList);
            request.setAttribute("product", product);

            request.getRequestDispatcher("/admin/productDetail.jsp").forward(request, response);
        } catch (Exception e) {
            log.error("Error loading product details for ID: " + productId, e);
            session.setAttribute("toastMessage", "Error loading product details.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
        }
    }

    private void deleteProductWithNull(HttpServletRequest request, HttpServletResponse response) throws IOException{
        String productId = request.getParameter("productId");
        if (productId != null && !productId.isEmpty()) {
            Product product = productRepository.findById(productId);
            if (product == null) {
                request.setAttribute("errorMessage", "Product not found.");
            }
            else {
                productRepository.markAsDeleted(productId);
            }

        }
        response.sendRedirect(request.getContextPath() + "/admin/product?action=list");

    }

    private void viewComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");

        if (productId == null || productId.trim().isEmpty()) {
            session.setAttribute("toastMessage", "Product ID is required to view comments.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
            return;
        }

        try {
            List<Comment> comments = commentRepository.findByProductId(productId);
            if (comments.isEmpty()) {
                session.setAttribute("toastMessage", "No comments found for this product.");
                session.setAttribute("toastType", "info");
            }
            request.setAttribute("commentsList", comments);
        } catch (Exception e) {
            log.error("Error viewing comments for product: " + productId, e);
            session.setAttribute("toastMessage", "Error loading comments. Please try again.");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void replyComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String commentId = request.getParameter("commentId"); // 注意：应该传 commentId，而不是 orderId
        String replyText = request.getParameter("text");

        if (commentId != null && replyText != null && !replyText.trim().isEmpty()) {
            Comment comment = commentRepository.findById(commentId);
            if (comment != null) {
                Reply reply = new Reply();
                reply.setMessage(replyText);
                reply.setComment(comment);
                replyRepository.create(reply);
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/product?action=view&productId=" + request.getParameter("productId"));
    }

    private void saveProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        boolean isNewProduct = (productId == null || productId.trim().isEmpty());

        try {
            // Validate required fields
            String name = request.getParameter("productName");
            String category = request.getParameter("productCategory");
            String desc = request.getParameter("productDesc");

            if (name == null || name.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Product name is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + (isNewProduct ? "/admin/product?action=create" : "/admin/product?productId=" + productId));
                return;
            }

            if (category == null || category.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Product category is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + (isNewProduct ? "/admin/product?action=create" : "/admin/product?productId=" + productId));
                return;
            }

            // Process image URLs
            String[] images = request.getParameterValues("imageUrls");
            Set<String> imageSet = new HashSet<>();
            if (images != null) {
                Collections.addAll(imageSet, images);
            }

            // Create or update product
            Product product;
            if (isNewProduct) {
                productId = UUID.randomUUID().toString();
                product = new Product();
                product.setId(productId);
            } else {
                product = productRepository.findById(productId);
                if (product == null) {
                    session.setAttribute("toastMessage", "Product not found for update.");
                    session.setAttribute("toastType", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
                    return;
                }
            }

            // Update product fields
            product.setName(name.trim());
            product.setCategory(category.trim());
            product.setDesc(desc != null ? desc.trim() : "");
            product.setImageUrls(imageSet);

            if (isNewProduct) {
                productRepository.create(product);

                // Create default variant
                Variant defaultVariant = new Variant();
                defaultVariant.setVariantName("Default");
                defaultVariant.setProduct(product);
                defaultVariant.setPrice(0.0);
                defaultVariant.setAvailability(true);
                variantRepository.create(defaultVariant);

                // Add default color attribute if it doesn't exist
                Attribute colorAttribute = attributeRepository.findByName("Color");
                if (colorAttribute == null) {
                    colorAttribute = new Attribute();
                    colorAttribute.setName("Color");
                    attributeRepository.create(colorAttribute);
                }

                // Create variant attribute relationship
                Variant_Attribute variantAttribute = new Variant_Attribute();
                variantAttribute.setVariant(defaultVariant);
                variantAttribute.setAttribute(colorAttribute);
                variantAttribute.setValue("Default");
                variantAttributeRepository.create(variantAttribute);

                session.setAttribute("toastMessage", "Product created successfully with default variant.");
                session.setAttribute("toastType", "success");
                log.info("New product created: {} with ID: {}", name, productId);
            } else {
                productRepository.update(product);
                session.setAttribute("toastMessage", "Product updated successfully.");
                session.setAttribute("toastType", "success");
                log.info("Product updated: {} with ID: {}", name, productId);
            }
        } catch (Exception e) {
            log.error("Error saving product", e);
            session.setAttribute("toastMessage", "Error saving product. Please try again.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            List<Product> products = productRepository.findAll();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/admin/productList.jsp").forward(request, response);
        } catch (Exception e) {
            log.error("Error listing products", e);
            session.setAttribute("toastMessage", "Error loading products list.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/productList.jsp");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        try {
            String productId = request.getParameter("productId");
            String name = request.getParameter("productName");
            String category = request.getParameter("productCategory");
            String desc = request.getParameter("productDesc");

            if (name == null || name.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Product name is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
                return;
            }

            Product product = productRepository.findById(productId);
            if (product != null) {
                product.setName(name);
                product.setCategory(category);
                product.setDesc(desc);
                productRepository.update(product);
                session.setAttribute("toastMessage", "Product updated successfully.");
                session.setAttribute("toastType", "success");
            } else {
                session.setAttribute("toastMessage", "Product not found.");
                session.setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            log.error("Error updating product", e);
            session.setAttribute("toastMessage", "Error updating product.");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + request.getParameter("productId"));
    }

    private void saveAttribute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        try {
            String attributeId = request.getParameter("attributeId");
            String attributeValue = request.getParameter("attributeValue");

            if (attributeValue == null || attributeValue.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Attribute value is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
                return;
            }

            Product product = productRepository.findById(productId);
            Attribute attribute = attributeRepository.findById(attributeId);

            List<Variant> existingVariants = variantRepository.findByProductId(productId);
            if (existingVariants == null || existingVariants.isEmpty()) {
                // Create new variant for product
                Variant newVariant = new Variant();
                newVariant.setProduct(product);
                newVariant.setVariantName(product.getName() + " " + attributeValue);
                newVariant.setPrice(0.0);
                newVariant.setAvailability(false);
                variantRepository.create(newVariant);

                Variant_Attribute newVA = new Variant_Attribute();
                newVA.setVariant(newVariant);
                newVA.setAttribute(attribute);
                newVA.setValue(attributeValue);
                variantAttributeRepository.create(newVA);
            } else {
                for (Variant variant : existingVariants) {
                    variant.setVariantName(variant.getVariantName() + " " + attributeValue);
                    variantRepository.update(variant);

                    Variant_Attribute newVA = new Variant_Attribute();
                    newVA.setVariant(variant);
                    newVA.setAttribute(attribute);
                    newVA.setValue(attributeValue);
                    variantAttributeRepository.create(newVA);
                }
            }
            session.setAttribute("toastMessage", "Attribute saved successfully.");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            log.error("Error saving attribute", e);
            session.setAttribute("toastMessage", "Error saving attribute.");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void saveVariant(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        try {
            String[] variantIds = request.getParameterValues("variantId");
            String[] variantNames = request.getParameterValues("variantName");
            String[] variantPrices = request.getParameterValues("variantPrice");
            String[] variantAvailability = request.getParameterValues("variantAvailability");

            if (variantIds == null || variantIds.length == 0) {
                session.setAttribute("toastMessage", "No variants to save.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
                return;
            }

            // Convert array to Set for quick lookup
            Set<String> availableVariantIds = new HashSet<>();
            if (variantAvailability != null) {
                availableVariantIds.addAll(Arrays.asList(variantAvailability));
            }

            for(int i = 0; i < variantIds.length; i++) {
                try {
                    Variant variant = variantRepository.findById(variantIds[i]);
                    variant.setVariantName(variantNames[i]);
                    variant.setPrice(Double.parseDouble(variantPrices[i].replace("RM", "").trim()));
                    variant.setAvailability(availableVariantIds.contains(variantIds[i]));
                    variantRepository.update(variant);
                } catch (NumberFormatException e) {
                    session.setAttribute("toastMessage", "Invalid price format for variant: " + variantNames[i]);
                    session.setAttribute("toastType", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
                    return;
                }
            }
            session.setAttribute("toastMessage", "Variants saved successfully.");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            log.error("Error saving variants", e);
            session.setAttribute("toastMessage", "Error saving variants.");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void uploadProductImage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");

        if (productId == null || productId.trim().isEmpty()) {
            session.setAttribute("toastMessage", "Product ID is required for image upload.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
            return;
        }

        try {
            Product product = productRepository.findById(productId);
            if (product == null) {
                session.setAttribute("toastMessage", "Product not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
                return;
            }

            Part filePart = request.getPart("imageFile");
            if (filePart == null || filePart.getSize() == 0) {
                session.setAttribute("toastMessage", "Please select an image to upload.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
                return;
            }

            // Validate file type
            String contentType = filePart.getContentType();
            if (!contentType.startsWith("image/")) {
                session.setAttribute("toastMessage", "Only image files are allowed.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
                return;
            }

            Path uploadDir = Path.of("/var/www/uploads");
            if (!Files.exists(uploadDir)) {
                Files.createDirectories(uploadDir);
            }

            int nextNo = product.getImageUrls().size() + 1;
            String newFileName = productId + "-" + nextNo + ".png";
            Path uploadPath = uploadDir.resolve(newFileName);

            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, uploadPath, StandardCopyOption.REPLACE_EXISTING);

                Set<String> urls = product.getImageUrls();
                urls.add(newFileName);
                product.setImageUrls(urls);
                productRepository.update(product);

                session.setAttribute("toastMessage", "Image uploaded successfully.");
                session.setAttribute("toastType", "success");
                log.info("Image uploaded successfully for product: {}", productId);
            }
        } catch (Exception e) {
            log.error("Error uploading image for product: " + productId, e);
            session.setAttribute("toastMessage", "Error uploading image. Please try again.");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void saveVariantAttributes(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        try {
            String variantId = request.getParameter("variantId");

            if (productId != null && variantId != null) {
                Variant variant = variantRepository.findById(variantId);
                if (variant != null) {
                    // Get all attributes for this variant
                    List<Attribute> attributes = attributeRepository.findByProductId(productId);

                    for (Attribute attribute : attributes) {
                        String value = request.getParameter("attr_" + attribute.getId());
                        if (value != null && !value.trim().isEmpty()) {
                            // Find existing variant attribute or create new one
                            Variant_Attribute variantAttribute = variantAttributeRepository.findByVariantIdAndAttributeId(variantId, attribute.getId());
                            if (variantAttribute == null) {
                                variantAttribute = new Variant_Attribute();
                                variantAttribute.setVariant(variant);
                                variantAttribute.setAttribute(attribute);
                            }
                            variantAttribute.setValue(value);
                            variantAttributeRepository.create(variantAttribute);
                        }
                    }
                    session.setAttribute("toastMessage", "Variant attributes saved successfully.");
                    session.setAttribute("toastType", "success");
                } else {
                    session.setAttribute("toastMessage", "Variant not found.");
                    session.setAttribute("toastType", "error");
                }
            }
        } catch (Exception e) {
            log.error("Error saving variant attributes", e);
            session.setAttribute("toastMessage", "Error saving variant attributes.");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void saveAttributeValue(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        try {
            String[] attributeList = request.getParameterValues("attributeList");

            if (attributeList == null || attributeList.length == 0) {
                session.setAttribute("toastMessage", "No attributes to save.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
                return;
            }

            Product product = productRepository.findById(productId);

            List<Variant> existingVariants = variantRepository.findByProductId(productId);
            Map<String, Variant> variantNameMap = new HashMap<>();
            for (Variant v : existingVariants) {
                variantNameMap.put(v.getVariantName().toLowerCase(), v);
            }

            // Collect all attributes and their new values
            Map<String, List<String>> attributeMap = new LinkedHashMap<>();
            Map<String, Attribute> attrObjects = new HashMap<>();

            for (String attrName : attributeList) {
                String[] original = request.getParameterValues("attr-" + attrName);
                if (original != null && original.length > 0) {
                    Attribute attr = attributeRepository.findByName(attrName);
                    if (attr == null) continue;
                    attrObjects.put(attrName, attr);
                    List<String> filtered = new ArrayList<>();
                    for(String value : original) {
                        if(value != null && !value.isEmpty()){
                            filtered.add(value);
                        }
                    }
                    String [] result = filtered.toArray(new String[0]);
                    attributeMap.put(attrName, Arrays.asList(result));
                }
            }

            // Generate all combinations
            List<Map<String, String>> combinations = new ArrayList<>();
            generateCombinations(attributeMap, new LinkedHashMap<>(), new ArrayList<>(attributeMap.keySet()), combinations);

            for (Map<String, String> combo : combinations) {
                String variantName = product.getName() + " " + String.join(" ", combo.values());
                Variant variant = variantRepository.findVariantByAttributes(product.getId(), combo);

                if (variant == null) {
                    variant = new Variant();
                    variant.setVariantName(variantName);
                    variant.setProduct(product);
                    variant.setPrice(0.0);
                    variant.setAvailability(false);
                    variantRepository.create(variant);
                } else {
                    variant.setVariantName(variantName);
                    variant.setProduct(product);
                    variantRepository.update(variant);
                }

                for (Map.Entry<String, String> entry : combo.entrySet()) {
                    Attribute attr = attrObjects.get(entry.getKey());
                    Variant_Attribute va = variantAttributeRepository.findByVariantIdAndAttributeId(variant.getVariantId(), attr.getId());
                    if (va == null) {
                        va = new Variant_Attribute();
                        va.setVariant(variant);
                        va.setAttribute(attr);
                    }
                    va.setValue(entry.getValue());
                    variantAttributeRepository.create(va);
                }
            }
            session.setAttribute("toastMessage", "Attribute values saved successfully.");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            log.error("Error saving attribute values", e);
            session.setAttribute("toastMessage", "Error saving attribute values.");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void generateCombinations(Map<String, List<String>> attributeMap, Map<String, String> current,
                                      List<String> keys, List<Map<String, String>> result) {
        if (keys.isEmpty()) {
            result.add(new LinkedHashMap<>(current));
            return;
        }

        String key = keys.get(0);
        List<String> remainingKeys = keys.subList(1, keys.size());

        for (String val : attributeMap.get(key)) {
            current.put(key, val);
            generateCombinations(attributeMap, current, remainingKeys, result);
            current.remove(key);
        }
    }
}