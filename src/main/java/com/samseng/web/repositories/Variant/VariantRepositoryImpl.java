package com.samseng.web.repositories.Variant;


import com.samseng.web.models.Variant;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

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
            return em.createQuery("SELECT v FROM  Variant v WHERE v.product=:product",Variant.class)
                    .setParameter("product", product)
                    .getResultList();
        } catch (NoResultException e) {
            return null;
        }

    }

}
