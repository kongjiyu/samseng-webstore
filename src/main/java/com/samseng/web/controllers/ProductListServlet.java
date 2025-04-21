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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // get user search query
        String nameQuery = req.getParameter("name");
        String[] categoryQuery = req.getParameterValues("category");

        Double minPrice = null, maxPrice = null;
        try {
            minPrice = Double.parseDouble(req.getParameter("minPrice"));
            maxPrice = Double.parseDouble(req.getParameter("maxPrice"));

            if (minPrice > maxPrice)
                minPrice = maxPrice;
        } catch (NullPointerException ignored) {
        }

        // Creating HashMap of attributes by trying to put all possible params in and removing the ones that are not attributes.
        var ignoreParams = List.of("name", "minPrice", "maxPrice", "category");
        var attributeFilters = new HashMap<>(req.getParameterMap());
        ignoreParams.forEach(attributeFilters::remove);


        // run the search thingy
        List<Product> products = search(nameQuery, minPrice, maxPrice, categoryQuery ,attributeFilters);

        // map output from database model into dto form
        List<ProductListingDTO> dtos = products.stream()
                .map(p -> {
                    double lowest = p.getVariants()
                            .stream()
                            .map(Variant::getPrice)
                            .sorted()
                            .findFirst()
                            .orElse(0.0);

                    return new ProductListingDTO(
                            p.getId(),
                            p.getName(),
                            p.getDesc(),
                            p.getImageUrls()
                                    .stream()
                                    .toList(),
                            lowest,
                            new RatingSummaryDTO(
                                    p.getAverageRating(),
                                    p.getTotalRatings()
                            )
                    );
                }).toList();

        // pass dto to jsp use
        req.setAttribute("products", dtos);

        // pass the next step to jsp
        RequestDispatcher view = req.getRequestDispatcher("/user/productPage.jsp");
        view.forward(req, resp);
    }


    // search thingy
    private List<Product> search(
            @Nullable String nameQuery,
            @Nullable Double minPrice,
            @Nullable Double maxPrice,
            String[] categoryQuery, Map<String, String[]> attributeFilters
    ) {
        /*
        AT0001 = [Blue, Black]
        AT0005 = [512 GB]

        SELECT DISTINCT product_id, v.variant_id
        FROM variant v
                 JOIN variant_attribute va1 ON v.variant_id = va1.variant_id AND va1.attribute_id = 'AT0001' AND va1.value IN ('blue')
                 JOIN variant_attribute va2 ON v.variant_id = va2.variant_id AND va2.attribute_id = 'AT0005' AND va2.value IN ('512gb')
        ORDER BY product_id, variant_id;
         */
        SessionFactory sf = emf.unwrap(SessionFactory.class);
        StatelessSession session = sf.openStatelessSession();
        HibernateCriteriaBuilder cb = sf.getCriteriaBuilder();

        CriteriaQuery<Product> criteria = cb.createQuery(Product.class);

        // creates the components of the criteria
        Root<Product> product = criteria.from(Product.class); //FROM product
        product.fetch(Product_.imageUrls, JoinType.LEFT);

        Join<Product, Variant> variant = product.join(Product_.variants);
        product.fetch(Product_.variants, JoinType.LEFT);

        //Join<Product, Comment> comment = product.join(Product_.comments);
        product.fetch(Product_.comments, JoinType.LEFT);

        Predicate where = cb.conjunction();

        /*
        build the conditions here
        */

        // WHERE name ILIKE '%{namePattern}%'
        if (nameQuery != null)
            where = cb.and(where, cb.ilike(product.get(Product_.name), "%" + nameQuery + "%"));

        if (minPrice != null && maxPrice != null)
            where = cb.and(where, cb.between(variant.get(Variant_.price), minPrice, maxPrice));

        if (categoryQuery != null)
            where = cb.and(where, cb.in(product.get(Product_.category), categoryQuery));

        // For every entry in the product table, apply attributeFilters.
        for (var entry : attributeFilters.entrySet()) {
            // JOIN variant_attribute ON variant_id = :variant_id
            //     AND attribute_name = :attributeName
            //     AND value IN :attributeValues
            Join<Variant, Variant_Attribute> variantAttribute = variant.join(Variant_.variant_attribute);
            Join<Variant_Attribute, Attribute> attribute = variantAttribute.join(Variant_Attribute_.attribute);
            variantAttribute.on(
                    cb.equal(attribute.get(Attribute_.name), entry.getKey()),
                    cb.in(variantAttribute.get(Variant_Attribute_.value), entry.getValue())
            );
        }

        // combines all the criteria
        criteria = criteria.select(product)
                .where(where);

        return session.createSelectionQuery(criteria)
                .getResultList();
    }
}
