package com.samseng.web.repositories.Product;
import com.samseng.web.models.Product;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional

public class ProductRepositoryImpl implements ProductRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void create(Product product) {
        em.persist(product);
    }

    @Override
    public Product findById(String id) {
        return em.find(Product.class, id);
    }

    @Override
    public Product findByName(String name) {
        try {
            return em.createQuery("SELECT p FROM Product p WHERE p.name = :name", Product.class)
                    .setParameter("name", name)
                    .getSingleResult();
        }catch(NoResultException e) {
            return null;
        }
    }

    @Override
    public List<Product> findAll(){
        try{
            return em.createQuery("SELECT p FROM Product p", Product.class).
                    getResultList();
        }catch(NoResultException e) {
            return null;
        }
    }

    @Override
    public void remove(Product product) {
        em.remove(product);
    }

    @Override
    public void update(Product product) {
        em.merge(product);
    }

    @Override
    public List<Product> findPaged(int page, int pageSize) {
        return em.createQuery("SELECT p FROM Product p ORDER BY p.name", Product.class)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();
    }

    @Override
    public long count() {
        return em.createQuery("SELECT COUNT(p) FROM Product p", Long.class)
                .getSingleResult();
    }
}
