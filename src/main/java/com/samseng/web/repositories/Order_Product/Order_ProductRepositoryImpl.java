package com.samseng.web.repositories.Order_Product;

import com.samseng.web.models.Order_Product;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class Order_ProductRepositoryImpl implements Order_ProductRepository {
    @PersistenceContext
    private EntityManager em;

    @Override
    public void create(Order_Product order_product) {
        em.persist(order_product);
    }

    @Override
    public void delete(Order_Product order_product) {
        em.remove(order_product);
    }

    @Override
    public void update(Order_Product order_product) {
        em.merge(order_product);
    }

    @Override
    public List<Order_Product>  findByProductId(String product) {
        return em.createQuery("SELECT o FROM Order_Product o WHERE o.product =:product ", Order_Product.class)
                .setParameter("product", product)
                .getResultList();
    }

    @Override
    public List<Order_Product> findByOrderId(String salesOrder) {
        return em.createQuery("SELECT o FROM Order_Product o WHERE o.salesOrder =:salesOrder ", Order_Product.class)
                .setParameter("salesOrder", salesOrder)
                .getResultList();
    }

    @Override
    public List<Order_Product> findByOrderIdAndProductId(String salesOrder, String product) {
        return em.createQuery("SELECT o FROM Order_Product o WHERE o.salesOrder =:salesOrder AND o.product=:product", Order_Product.class)
                .setParameter("salesOrder", salesOrder)
                .setParameter("product", product)
                .getResultList();
    }

    @Override
    public List<Object[]> getTopSellingProducts() {
        return em.createQuery(
                        "SELECT p.name, SUM(op.quantity) " +
                                "FROM Order_Product op JOIN op.product p " +
                                "GROUP BY p.name ORDER BY SUM(op.quantity) DESC", Object[].class)
                .setMaxResults(5)
                .getResultList();
    }

    @Override
    public List<Object[]> getMonthlySales() {
        return em.createQuery(
                "SELECT FUNCTION('TO_CHAR', o.createdAt, 'Mon'), SUM(op.unitPrice * op.quantity) " +
                "FROM Order_Product op JOIN op.salesOrder o " +
                "GROUP BY FUNCTION('TO_CHAR', o.createdAt, 'Mon') " +
                "ORDER BY MIN(o.createdAt)", Object[].class)
            .getResultList();
    }
}


