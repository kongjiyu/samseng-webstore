package com.samseng.web.repositories.Cart_Product;

import com.samseng.web.models.Cart_Product;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;
@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class Cart_ProductRepositoryImpl implements Cart_ProductRepository {
    @PersistenceContext
    private EntityManager em;

    public void create(Cart_Product cart_product){
        em.persist(cart_product);
    }

    public void update(Cart_Product cart_product){
        em.merge(cart_product);
    }

    public void delete(Cart_Product cart_product){
        em.remove(cart_product);
    }

    public List<Cart_Product> findByAccountId(String account){
        return em.createQuery("SELECT c FROM Cart_Product c WHERE c.account= :account ",Cart_Product.class)
                .setParameter("account",account)
                .getResultList();
    }

}