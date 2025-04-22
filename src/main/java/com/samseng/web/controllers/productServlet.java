package com.samseng.web.controllers;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
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
import lombok.extern.log4j.Log4j2;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Log4j2
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

            // Get all available attributes for the dropdown
            List<Attribute> allAttributes = attributeRepository.findAll();
            request.setAttribute("allAttributes", allAttributes);

            List<Attribute> attributeList = attributeRepository.findByProductId(productId);
            List<Variant> variantList = variantRepository.findByProductId(productId);
            variantList.sort(Comparator.comparing(Variant::getVariantName, String.CASE_INSENSITIVE_ORDER));            Map<String, Map<String, String>> variantAttrMap = new HashMap<>();

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
        }else{
            response.sendRedirect("/admin/productList.jsp");
        }
    }

    private void saveProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productId = request.getParameter("productId");
        boolean isNewProduct = (productId == null || productId.isEmpty());
        
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

        response.sendRedirect(request.getContextPath() + "/admin/product?productId=" + productId);
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


        Path uploadDir = Path.of("/var/www/data/uploads"); // or your actual folder in server
        Part filePart = request.getPart("imageFile");
        int nextNo = product.getImageUrls().size()+1;

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

            // Save filename to product imageUrls
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
}