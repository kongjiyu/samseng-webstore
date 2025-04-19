package com.samseng.web.controllers;

import com.samseng.web.models.*;
import com.samseng.web.dto.ProductListingDTO;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.persistence.Query;
import jakarta.persistence.criteria.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.SessionFactory;
import org.hibernate.StatelessSession;
import org.hibernate.query.SelectionQuery;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {
    @PersistenceUnit
    private SessionFactory sf;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // get user search query
        String namePattern = req.getParameter("namePattern");
        Map<String, Object[]> attributeFilters = new HashMap<>();
        attributeFilters.put("AT0001", new Object[]{"Blue", "Red"});
        attributeFilters.put("AT0005", new Object[]{"512gb"});
        /*
        AT0001 = [blue, red]
        AT0005 = [512 GB]

        SELECT DISTINCT product_id, v.variant_id
        FROM variant v
                 JOIN variant_attribute va1 ON v.variant_id = va1.variant_id AND va1.attribute_id = 'AT0001' AND va1.value IN ('blue')
                 JOIN variant_attribute va2 ON v.variant_id = va2.variant_id AND va2.attribute_id = 'AT0005' AND va2.value IN ('512gb')
        ORDER BY product_id, variant_id;
         */

        HibernateCriteriaBuilder cb = sf.getCriteriaBuilder();

        CriteriaQuery<Product> criteria = cb.createQuery(Product.class);

        // creates the components of the criteria
        Root<Product> product = criteria.from(Product.class); //FROM product
        Join<Product, Variant> variant = product.join(Product_.variants);
        Predicate where = cb.conjunction();

        /*
        build the conditions here
        */
        if (namePattern != null)
            // WHERE name ILIKE '%{namePattern}%'
            where = cb.and(where, cb.ilike(product.get(Product_.name), "%" + namePattern + "%"));

        for (var entry : attributeFilters.entrySet()) {
            // JOIN variant_attribute ON variant_id = :variant_id
            //     AND attribute_id = :attributeId
            //     AND value IN :attributeValues
            Join<Variant, Variant_Attribute> variantAttribute = variant.join(Variant_.attributes);
            variantAttribute.on(
                    cb.equal(variantAttribute.get(Variant_Attribute_.attributeID), entry.getKey()),
                    cb.in(variantAttribute.get(Variant_Attribute_.value), entry.getValue())
            );
        }

        // combines all the criteria
        criteria = criteria.select(product)
                .where(where)
                .orderBy();

        StatelessSession session = sf.openStatelessSession();
        SelectionQuery<Product> query = session.createSelectionQuery(criteria);

        List<Product> products = query.getResultList();



        req.setAttribute("products", products);
    }


}
