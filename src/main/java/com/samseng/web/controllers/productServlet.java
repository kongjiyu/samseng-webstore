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
import jakarta.transaction.Transactional;

import java.io.IOException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import lombok.extern.log4j.Log4j2;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.http.HttpSession;

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

        if (action == null || action.trim().isEmpty()) {
            session.setAttribute("toastMessage", "Invalid action specified.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
            return;
        }

        try {
            switch (action) {
                case "update":
                    updateProduct(request, response);
                    break;
                case "list":
                    listProducts(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
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
        HttpSession session = request.getSession();
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

            // Get comments for the product
            List<Comment> comments = commentRepository.findByProductId(productId);

            // Set all attributes in request
            request.setAttribute("images", product.getImageUrls());
            request.setAttribute("allAttributes", allAttributes);
            request.setAttribute("attributeValuesMap", attributeValuesMap);
            request.setAttribute("imageSet", product.getImageUrls());
            request.setAttribute("variantAttrMap", variantAttrMap);
            request.setAttribute("attributeList", attributeList);
            request.setAttribute("variantList", variantList);
            request.setAttribute("product", product);
            request.setAttribute("commentsList", comments);

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
    private void replyComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        String commentId = request.getParameter("commentId");
        String replyText = request.getParameter("replyText");

        if (productId == null || commentId == null || replyText == null || replyText.trim().isEmpty()) {
            session.setAttribute("toastMessage", "Comment ID and reply text are required.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
            return;
        }

        try {
            Comment comment = commentRepository.findById(commentId);
            if (comment == null) {
                session.setAttribute("toastMessage", "Comment not found.");
                session.setAttribute("toastType", "error");
            } else {
                comment.setReply(replyText);
                comment.setReplyDate(new Date());
                commentRepository.update(comment);
                session.setAttribute("toastMessage", "Reply posted successfully.");
                session.setAttribute("toastType", "success");
            }
        } catch (Exception e) {
            log.error("Error replying to comment: " + commentId, e);
            session.setAttribute("toastMessage", "Error posting reply. Please try again.");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
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


        response.sendRedirect(request.getContextPath() + "/admin/product?action=view&productId=" + request.getParameter("productId"));
    }


    private void saveProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        boolean isNewProduct = (productId == null || productId.isEmpty());

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

        try {
            if (isNewProduct) {
                productId = UUID.randomUUID().toString();
            }

            Set<String> imageSet = new HashSet<>();
            String[] images = request.getParameterValues("imageUrls");
            if (images != null) {
                Collections.addAll(imageSet, images);
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
            } else {
                productRepository.update(product);
            }

            session.setAttribute("toastMessage", isNewProduct ? "Product created successfully." : "Product updated successfully.");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            log.error("Error saving product", e);
            session.setAttribute("toastMessage", "Error saving product. Please try again.");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productRepository.findAll(); // Fetch all products

        request.setAttribute("products", products);

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
        try {
            if (productId != null && !productId.isEmpty()) {
                Product product = productRepository.findById(productId);
                if (product != null) {
                    log.info("Trying to delete product: {}", product.getId());
                    productRepository.delete(product);
                    log.info("Deleted product: {}", product.getId());
                } else {
                    log.warn("Product not found: {}", productId);
                }
            } else {
                log.warn("No productId provided for delete.");
            }

            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");

        } catch (Exception e) {
            log.error("Error during deleteProduct", e); // <<< 强制打印异常
            response.sendRedirect(request.getContextPath() + "/errorPage.jsp");
        }
        response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
    }


    private void saveAttribute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productId = request.getParameter("productId");
        String attributeId = request.getParameter("attributeId");
        String attributeValue = request.getParameter("attributeValue");

        try {
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
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId + "&error=1");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void saveVariant(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productId = request.getParameter("productId");
        String[] variantIds = request.getParameterValues("variantId");
        String[] variantNames = request.getParameterValues("variantName");
        String[] variantPrices = request.getParameterValues("variantPrice");
        String[] variantAvailability = request.getParameterValues("variantAvailability");

        // Convert array to Set for quick lookup
        Set<String> availableVariantIds = new HashSet<>();
        if (variantAvailability != null) {
            availableVariantIds.addAll(Arrays.asList(variantAvailability));
        }

        for(int i = 0; i < variantIds.length; i++) {
            Variant variant = variantRepository.findById(variantIds[i]);
            variant.setVariantName(variantNames[i]);
            variant.setPrice(Double.parseDouble(variantPrices[i].replace("RM", "").trim()));
            variant.setAvailability(availableVariantIds.contains(variantIds[i]));
            variantRepository.update(variant);
        }

        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void uploadProductImage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String productId = request.getParameter("productId");

        if (productId == null || productId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required.");
            return;
        }
        Product product = productRepository.findById(productId);

            Part filePart = request.getPart("imageFile");
            if (filePart == null || filePart.getSize() == 0) {
                session.setAttribute("toastMessage", "Please select an image to upload.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
                return;
            }


        String newFileName = productId + "-" + nextNo + ".png";
        Path uploadPath = uploadDir.resolve(newFileName);
        log.info("Receiving file upload for product: {}", productId);
        log.info("Saving to path: {}", uploadPath.toAbsolutePath());

        if (filePart != null && filePart.getSize() > 0) {
            log.info("File part received: {} ({} bytes)", filePart.getSubmittedFileName(), filePart.getSize());
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, uploadPath, StandardCopyOption.REPLACE_EXISTING);

                log.info("Upload successful.");
            } catch (IOException e) {
                log.error("Upload failed", e);
            }
                Set<String> urls = product.getImageUrls();
                urls.add(newFileName);
                product.setImageUrls(urls);
                productRepository.update(product);


        }

        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void saveVariantAttributes(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productId = request.getParameter("productId");
        String variantId = request.getParameter("variantId");
        
        if (productId != null && variantId != null) {
            Variant variant = variantRepository.findById(variantId);
            if (variant != null) {
                // Get all attributes for this variant
                List<Attribute> attributes = attributeRepository.findByProductId(productId);
                
                for (Attribute attribute : attributes) {
                    String value = request.getParameter("attr_" + attribute.getId());
                    if (value != null) {
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
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
    }

    private void saveAttributeValue(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productId = request.getParameter("productId");
        String[] attributeList = request.getParameterValues("attributeList");

        try {
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

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId + "&error=1");
            return;
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
}