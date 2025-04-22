package com.samseng.web.repositories.Variant;


import com.samseng.web.models.Variant;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;
import java.util.Map;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class VariantRepositoryImpl implements  VariantRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void create(Variant variant) {
        em.persist(variant);
    }

    @Override
    public void update(Variant variant) {
        em.merge(variant);
    }

    @Override
    public void delete(Variant variant) {
        em.remove(variant);
    }

    @Override
    public List<Variant> findAll() {
        try {
            return em.createQuery("SELECT v FROM  Variant v",Variant.class)
                    .getResultList();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public Variant findById(String variantId) {
         return em.find(Variant.class, variantId);
    }

    @Override
    public List<Variant> findByProductId(String product) {
        try {
            return em.createQuery("SELECT v FROM  Variant v WHERE v.product.id=:product",Variant.class)
                    .setParameter("product", product)
                    .getResultList();
        } catch (NoResultException e) {
            return null;
        }

    }

    @Override
    public Variant findVariantByAttributes(String productId, Map<String, String> attributeValues) {
    try {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT v FROM Variant v ")
          .append("JOIN v.variant_attribute va ")
          .append("JOIN va.attribute a ")
          .append("WHERE v.product.id = :productId ");

        int index = 0;
        for (Map.Entry<String, String> entry : attributeValues.entrySet()) {
            sb.append("AND EXISTS (")
              .append("SELECT 1 FROM Variant_Attribute va")
              .append(index)
              .append(" JOIN va")
              .append(index)
              .append(".attribute a")
              .append(index)
              .append(" WHERE va")
              .append(index)
              .append(".variant = v ")
              .append("AND a")
              .append(index)
              .append(".name = :attrName")
              .append(index)
              .append(" AND va")
              .append(index)
              .append(".value = :attrValue")
              .append(index)
              .append(") ");
            index++;
        }

        var query = em.createQuery(sb.toString(), Variant.class);
        query.setParameter("productId", productId);

        index = 0;
        for (Map.Entry<String, String> entry : attributeValues.entrySet()) {
            query.setParameter("attrName" + index, entry.getKey());
            query.setParameter("attrValue" + index, entry.getValue());
            index++;
        }

        return query.getSingleResult();
    } catch (NoResultException e) {
        return null;
    }
}

}
