package com.samseng.web.repositories.Products;
import com.samseng.web.models.Address;
import com.samseng.web.models.Products;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional

public class ProductsRepositoryImpl implements ProductsRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void save(Products products) {
        em.persist(products);
    }
    @Override
    public Products findById(String id) {
        return em.find(Products.class, id);
    }

    @Override
    public Products findByName(String name) {
        try {
            return em.createQuery("SELECT p FROM Products p WHERE p.name = :name", Products.class)
                    .setParameter("name", name)
                    .getSingleResult();
        }catch(NoResultException e) {
            return null;
        }
    }

    @Override
    public void remove(Products products) {
        em.remove(products);
    }

    @Override
    public void update(Products products) {
        em.persist(products);
    }



}
