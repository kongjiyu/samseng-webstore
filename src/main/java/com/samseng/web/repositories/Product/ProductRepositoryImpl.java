package com.samseng.web.repositories.Product;
import com.samseng.web.models.Product;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

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
    public void remove(Product product) {
        em.remove(product);
    }

    @Override
    public void update(Product product) {
        em.persist(product);
    }



}
