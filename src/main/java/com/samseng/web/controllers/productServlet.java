package com.samseng.web.controllers;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.*;

import com.samseng.web.models.*;
import com.samseng.web.repositories.Attribute.AttributeRepository;
import com.samseng.web.repositories.Comment.CommentRepository;
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



        try {
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
                
                // Get all available attributes for the dropdown
                List<Attribute> allAttributes = attributeRepository.findAll();
                request.setAttribute("allAttributes", allAttributes);

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
            } else if ("saveAttributeValues".equals(action)) {
                saveAttributeValue(request, response);
                return;
            } else if ("saveVariant".equals(action)) {
                saveVariant(request, response);
                return;
            } else if ("uploadImage".equals(action)) {
                uploadProductImage(request, response);
                return;
            } else if ("saveVariantAttributes".equals(action)) {
                saveVariantAttributes(request, response);
                return;
            } else if("replyComment".equals(action)) {
                replyComment(request, response);
                return;
            } else if("viewComment".equals(action)) {
                viewComment(request, response);

                return;
            }

            String productId = request.getParameter("productId");
            if (productId != null && !productId.isEmpty()) {
                Product product = productRepository.findById(productId);

                if (product == null) {
                    session.setAttribute("toastMessage", "Product not found.");
                    session.setAttribute("toastType", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
                    return;
                }

                request.setAttribute("images", product.getImageUrls());

                // Get all available attributes for the dropdown
                List<Attribute> allAttributes = attributeRepository.findAll();
                request.setAttribute("allAttributes", allAttributes);

                List<Attribute> attributeList = attributeRepository.findByProductId(productId);
                List<Variant> variantList = variantRepository.findByProductId(productId);
                variantList.sort(Comparator.comparing(Variant::getVariantName, String.CASE_INSENSITIVE_ORDER));
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

                request.setAttribute("attributeValuesMap", attributeValuesMap);
                request.setAttribute("imageSet", product.getImageUrls());
                request.setAttribute("variantAttrMap", variantAttrMap);
                request.setAttribute("attributeList", attributeList);
                request.setAttribute("variantList", variantList);
                request.setAttribute("product", product);
                request.getRequestDispatcher("/admin/productDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("/admin/productList.jsp");
            }
        } catch (Exception e) {
            log.error("Error processing request", e);
            session.setAttribute("toastMessage", "An unexpected error occurred. Please try again.");
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
        if (productId != null && !productId.isEmpty()) {
            try {
                List<Comment> comments = commentRepository.findByProductId(productId);
                request.setAttribute("commentsList", comments);
            } catch (Exception e) {
                log.error("Error viewing comments", e);
                session.setAttribute("toastMessage", "Error loading comments.");
                session.setAttribute("toastType", "error");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void replyComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        try {
            List<Comment> comment = commentRepository.findByProductId(productId);
            session.setAttribute("toastMessage", "Comment replied successfully.");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            log.error("Error replying to comment", e);
            session.setAttribute("toastMessage", "Error replying to comment.");
            session.setAttribute("toastType", "error");
        }
    }

    private void saveProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        boolean isNewProduct = (productId == null || productId.isEmpty());
        
        try {
            if (isNewProduct) {
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

            if (name == null || name.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Product name is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?action=create");
                return;
            }

            Product product = new Product();
            product.setId(productId);
            product.setName(name);
            product.setCategory(category);
            product.setDesc(desc);
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

                // Add default color attribute
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
                variantAttribute.setValue(""); // Empty value to be filled by user
                variantAttributeRepository.create(variantAttribute);

                session.setAttribute("toastMessage", "Product created successfully.");
                session.setAttribute("toastType", "success");
            } else {
                productRepository.update(product);
                session.setAttribute("toastMessage", "Product updated successfully.");
                session.setAttribute("toastType", "success");
            }

            response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
        } catch (Exception e) {
            log.error("Error saving product", e);
            session.setAttribute("toastMessage", "Error saving product. Please try again.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
        }
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

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        try {
            String productId = request.getParameter("productId");
            if (productId != null && !productId.isEmpty()) {
                Product product = productRepository.findById(productId);
                if (product != null) {
                    productRepository.delete(product);
                    session.setAttribute("toastMessage", "Product deleted successfully.");
                    session.setAttribute("toastType", "success");
                } else {
                    session.setAttribute("toastMessage", "Product not found.");
                    session.setAttribute("toastType", "error");
                }
            }
        } catch (Exception e) {
            log.error("Error deleting product", e);
            session.setAttribute("toastMessage", "Error deleting product.");
            session.setAttribute("toastType", "error");

        }
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
        try {
            if (productId == null || productId.isEmpty()) {
                session.setAttribute("toastMessage", "Product ID is required.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
                return;
            }

            Product product = productRepository.findById(productId);
            if (product == null) {
                session.setAttribute("toastMessage", "Product not found.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
                return;
            }

            Path uploadDir = Path.of("/var/www/data/uploads");
            Part filePart = request.getPart("imageFile");
            
            if (filePart == null || filePart.getSize() == 0) {
                session.setAttribute("toastMessage", "No file selected for upload.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
                return;
            }

            int nextNo = product.getImageUrls().size() + 1;
            String newFileName = productId + "-" + nextNo + ".png";
            Path uploadPath = uploadDir.resolve(newFileName);
            
            log.info("Receiving file upload for product: {}", productId);
            log.info("Saving to path: {}", uploadPath.toAbsolutePath());

            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, uploadPath, StandardCopyOption.REPLACE_EXISTING);
                log.info("Upload successful.");

                // Save filename to product imageUrls
                Set<String> urls = product.getImageUrls();
                urls.add(newFileName);
                product.setImageUrls(urls);
                productRepository.update(product);

                session.setAttribute("toastMessage", "Image uploaded successfully.");
                session.setAttribute("toastType", "success");
            }
        } catch (Exception e) {
            log.error("Error uploading image", e);
            session.setAttribute("toastMessage", "Error uploading image.");
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