package com.samseng.web.repositories.Order_Product;

import com.samseng.web.models.Order_Product;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.time.LocalDate;
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
        return em.createQuery("SELECT o FROM Order_Product o WHERE o.variant.product =:product ", Order_Product.class)
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
        return em.createQuery("SELECT o FROM Order_Product o WHERE o.salesOrder =:salesOrder AND o.variant.product=:product", Order_Product.class)
                .setParameter("salesOrder", salesOrder)
                .setParameter("product", product)
                .getResultList();
    }

    @Override
    public List<Object[]> getTopSellingProducts() {
        return em.createQuery(
                        "SELECT p.name, SUM(op.quantity) " +
                                "FROM Order_Product op JOIN op.variant.product p " +
                                "GROUP BY p.name ORDER BY SUM(op.quantity) DESC", Object[].class)
                .setMaxResults(5)
                .getResultList();
    }

    public List<String> findTop5ProductIdsInLast6Months() {
        String jpql = "SELECT op.variant.product.id " +
                "FROM Order_Product op " +
                "WHERE op.salesOrder.orderedDate >= :startDate " +
                "GROUP BY op.variant.product.id " +
                "ORDER BY SUM(op.quantity) DESC";

        return em.createQuery(jpql, String.class)
                .setParameter("startDate", LocalDate.now().minusMonths(6))
                .setMaxResults(5)
                .getResultList();
    }

    public List<Object[]> findMonthlySalesForTopProducts(List<String> productIds) {
        String jpql = "SELECT op.variant.product.id, " +
                "       FUNCTION('TO_CHAR', op.salesOrder.orderedDate, 'YYYY-MM') AS month, " +
                "       SUM(op.quantity) " +
                "FROM Order_Product op " +
                "WHERE op.salesOrder.orderedDate >= :startDate " +
                "AND op.variant.product.id IN :productIds " +
                "GROUP BY op.variant.product.id, month " +
                "ORDER BY FUNCTION('TO_CHAR', op.salesOrder.orderedDate, 'YYYY-MM') ASC";

        return em.createQuery(jpql, Object[].class)
                .setParameter("startDate", LocalDate.now().minusMonths(6))
                .setParameter("productIds", productIds)
                .getResultList();
    }

    // Find revenue by product category in the last 6 months
    public List<Object[]> findRevenueByProductCategory() {
        String jpql = "SELECT p.category, SUM(op.quantity * v.price) " +
                      "FROM Order_Product op " +
                      "JOIN op.variant.product p " +
                      "JOIN Variant v ON v.product = p " +
                      "WHERE op.salesOrder.orderedDate >= :startDate " +
                      "GROUP BY p.category " +
                      "ORDER BY SUM(op.quantity * v.price) DESC";

        return em.createQuery(jpql, Object[].class)
                 .setParameter("startDate", LocalDate.now().minusMonths(6))
                 .getResultList();
    }
}


