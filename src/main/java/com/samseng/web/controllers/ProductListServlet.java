package com.samseng.web.controllers;

import com.samseng.web.dto.ProductListingDTO;
import com.samseng.web.dto.RatingSummaryDTO;
import com.samseng.web.models.*;
import jakarta.annotation.Nullable;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.persistence.criteria.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.hibernate.SessionFactory;
import org.hibernate.StatelessSession;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            // Get user search query
            String nameQuery = request.getParameter("name");
            String[] categoryQuery = request.getParameterValues("category");

            Double minPrice = null, maxPrice = null;
            String minParam = request.getParameter("minPrice");
            String maxParam = request.getParameter("maxPrice");

            // Validate and parse price parameters
            try {
                if (minParam != null && !minParam.isEmpty()) {
                    minPrice = Double.parseDouble(minParam);
                    if (minPrice < 0) {
                        session.setAttribute("toastMessage", "Minimum price cannot be negative.");
                        session.setAttribute("toastType", "error");
                        response.sendRedirect(request.getContextPath() + "/productPage.jsp");
                        return;
                    }
                }
                if (maxParam != null && !maxParam.isEmpty()) {
                    maxPrice = Double.parseDouble(maxParam);
                    if (maxPrice < 0) {
                        session.setAttribute("toastMessage", "Maximum price cannot be negative.");
                        session.setAttribute("toastType", "error");
                        response.sendRedirect(request.getContextPath() + "/productPage.jsp");
                        return;
                    }
                }

                if (minPrice != null && maxPrice != null && minPrice > maxPrice) {
                    session.setAttribute("toastMessage", "Minimum price cannot be greater than maximum price.");
                    session.setAttribute("toastType", "error");
                    response.sendRedirect(request.getContextPath() + "/productPage.jsp");
                    return;
                }
            } catch (NumberFormatException e) {
                session.setAttribute("toastMessage", "Invalid price format. Please enter valid numbers.");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/productPage.jsp");
                return;
            }

            // Creating HashMap of attributes by trying to put all possible params in and removing the ones that are not attributes.
            var ignoreParams = List.of("name", "minPrice", "maxPrice", "category");
            var attributeFilters = new HashMap<>(request.getParameterMap());
            ignoreParams.forEach(attributeFilters::remove);

            // Run the search
            List<Product> products = search(nameQuery, minPrice, maxPrice, categoryQuery, attributeFilters);

            if (products.isEmpty()) {
                session.setAttribute("toastMessage", "No products found matching your criteria.");
                session.setAttribute("toastType", "info");
            }

            // Map output from database model into dto form
            List<ProductListingDTO> dtos = products.stream()
                    .map(p -> {
                        try {
                            double lowest = p.getVariants()
                                    .stream()
                                    .mapToDouble(Variant::getPrice)
                                    .sorted()
                                    .findFirst()
                                    .orElse(0.0);

                            double highest = p.getVariants()
                                    .stream()
                                    .mapToDouble(Variant::getPrice)
                                    .sorted()
                                    .reduce((first, second) -> second)
                                    .orElse(0.0);

                            return new ProductListingDTO(
                                    p.getId(),
                                    p.getName(),
                                    p.getDesc(),
                                    p.getImageUrls()
                                            .stream()
                                            .toList(),
                                    lowest,
                                    highest,
                                    new RatingSummaryDTO(
                                            p.getAverageRating(),
                                            p.getTotalRatings()
                                    )
                            );
                        } catch (Exception e) {
                            session.setAttribute("toastMessage", "Error processing product: " + p.getName());
                            session.setAttribute("toastType", "error");
                            return null;
                        }
                    })
                    .filter(dto -> dto != null)
                    .toList();

            // Pass dto to jsp use
            request.setAttribute("products", dtos);

            // Pass the next step to jsp
            RequestDispatcher view = request.getRequestDispatcher("/productPage.jsp");
            view.forward(request, response);

        } catch (Exception e) {
            session.setAttribute("toastMessage", "An error occurred while searching for products.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/productPage.jsp");
        }
    }

    private List<Product> search(
            @Nullable String nameQuery,
            @Nullable Double minPrice,
            @Nullable Double maxPrice,
            String[] categoryQuery, 
            Map<String, String[]> attributeFilters
    ) {
        SessionFactory sf = emf.unwrap(SessionFactory.class);
        try (StatelessSession session = sf.openStatelessSession()) {
            HibernateCriteriaBuilder cb = sf.getCriteriaBuilder();

            CriteriaQuery<Product> criteria = cb.createQuery(Product.class);

            // Creates the components of the criteria
            Root<Product> product = criteria.from(Product.class);
            product.fetch(Product_.imageUrls, JoinType.LEFT);

            Join<Product, Variant> variant = product.join(Product_.variants);
            product.fetch(Product_.variants, JoinType.LEFT);

            product.fetch(Product_.comments, JoinType.LEFT);

            // WHERE 1=1
            Predicate where = cb.conjunction();
            where = cb.and(where, cb.isFalse(product.get(Product_.deleted)));

            // Build the conditions

            if (nameQuery != null)
                where = cb.and(where, cb.ilike(product.get(Product_.name), "%" + nameQuery + "%"));

            if (minPrice != null && maxPrice != null)
                where = cb.and(where, cb.between(variant.get(Variant_.price), minPrice, maxPrice));

            if (categoryQuery != null)
                where = cb.and(where, cb.in(product.get(Product_.category), categoryQuery));

            // For every entry in the product table, apply attributeFilters
            for (var entry : attributeFilters.entrySet()) {
                Join<Variant, Variant_Attribute> variantAttribute = variant.join(Variant_.variant_attribute);
                Join<Variant_Attribute, Attribute> attribute = variantAttribute.join(Variant_Attribute_.attribute);
                variantAttribute.on(
                        cb.equal(attribute.get(Attribute_.name), entry.getKey()),
                        cb.in(variantAttribute.get(Variant_Attribute_.value), entry.getValue())
                );
            }

            // Combine all the criteria
            criteria = criteria.select(product)
                    .where(where);

            return session.createSelectionQuery(criteria)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Error executing product search", e);
        }
    }
}
