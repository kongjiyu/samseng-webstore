package com.samseng.web.controllers;

import com.samseng.web.dto.ProductListingDTO;
import com.samseng.web.models.*;
import jakarta.persistence.EntityGraph;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.persistence.Subgraph;
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
        String queryName = req.getParameter("query");
        Map<String, String[]> attributeFilters = new HashMap<>();
        attributeFilters.put("AT0001", new String[]{"Blue", "Black"});
        attributeFilters.put("AT0005", new String[]{"256gb"});

        // run the search thingy
        List<Product> products = search(queryName, attributeFilters);

        // map output from database model into dto form ay macarena
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
                            lowest
                    );
                }).toList();

        // pass dto to jsp use
        req.setAttribute("products", dtos);

        // pass the next step to jsp
        RequestDispatcher view = req.getRequestDispatcher("/user/productPage.jsp");
        view.forward(req, resp);
    }

    private List<Product> search(String queryName, Map<String, String[]> attributeFilters) {
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
        product.fetch(Product_.imageUrls);

        Join<Product, Variant> variant = product.join(Product_.variants);
        product.fetch(Product_.variants);

        Predicate where = cb.conjunction();
        /*
        build the conditions here
        */
        if (queryName != null)
            // WHERE name ILIKE '%{namePattern}%'
            where = cb.and(where, cb.ilike(product.get(Product_.name), "%" + queryName + "%"));

        for (var entry : attributeFilters.entrySet()) {
            // JOIN variant_attribute ON variant_id = :variant_id
            //     AND attribute_id = :attributeId
            //     AND value IN :attributeValues
            Join<Variant, Variant_Attribute> variantAttribute = variant.join(Variant_.attributes);
            Join<Variant_Attribute, Attribute> attribute = variantAttribute.join(Variant_Attribute_.attributeID);

            variantAttribute.on(
                    cb.equal(attribute.get(Attribute_.id), entry.getKey()),
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
