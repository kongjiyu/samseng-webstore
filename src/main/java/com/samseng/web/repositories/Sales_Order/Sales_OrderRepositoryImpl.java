package com.samseng.web.repositories.Sales_Order;

import com.samseng.web.models.Sales_Order;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class Sales_OrderRepositoryImpl implements Sales_OrderRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void create(Sales_Order salesOrder) {
        em.persist(salesOrder);
    }

    @Override
    public void delete(Sales_Order salesOrder) {
        em.remove(salesOrder);
    }

    @Override
    public void update(Sales_Order salesOrder) {
        em.merge(salesOrder);
    }

    @Override
    public Sales_Order findById(String id) {
        return em.find(Sales_Order.class, id);
    }

    @Override
    public List<Sales_Order> findByUserId(String user) {
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.user = :user",  Sales_Order.class)
                .setParameter("user", user)
                .getResultList();

    }


    @Override
    public Sales_Order findByRefNo(String refNo){
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.refNo = :refNo",  Sales_Order.class)
                .setParameter("refNo",refNo)
                .getSingleResult();

    }

    @Override
    public List<Sales_Order> findPaged(int page, int pageSize) {
        return em.createQuery("SELECT o FROM Sales_Order o ORDER BY o.id", Sales_Order.class)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();
    }

    @Override
    public List<Sales_Order> findByUserIdPaged(String userId, int page, int pageSize) {
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.user.id = :userId",  Sales_Order.class)
                .setParameter("userId", userId)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();

    }

    @Override
    public long count() {
        return em.createQuery("SELECT COUNT(o) FROM Sales_Order o", Long.class)
                .getSingleResult();
    }

    public void updateStatus(String orderId, String newStatus) {
        Sales_Order o = em.find(Sales_Order.class, orderId);
        if (o != null) {
            o.setStatus(newStatus);
            em.merge(o);
        }
    }


}
