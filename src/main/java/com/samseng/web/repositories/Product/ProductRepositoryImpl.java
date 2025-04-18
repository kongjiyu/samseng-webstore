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
    public void delete(Product product) {
        try {
            String productId = product.getId();
            
            // First, delete any Variant_Attribute entries related to variants of this product
            em.createNativeQuery("DELETE FROM variant_attribute va WHERE EXISTS " +
                                "(SELECT 1 FROM variant v WHERE v.variant_id = va.variant_id AND v.product_id = :productId)")
                .setParameter("productId", productId)
                .executeUpdate();
            
            // Delete related records from product_images table
            em.createNativeQuery("DELETE FROM product_images WHERE product_id = :productId")
                .setParameter("productId", productId)
                .executeUpdate();
            
            // Delete any variants of this product
            em.createNativeQuery("DELETE FROM variant WHERE product_id = :productId")
                .setParameter("productId", productId)
                .executeUpdate();
            
            // Finally delete the product itself
            em.createNativeQuery("DELETE FROM product WHERE product_id = :productId")
                .setParameter("productId", productId)
                .executeUpdate();
            
            // Flush to ensure all operations are executed
            em.flush();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
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
