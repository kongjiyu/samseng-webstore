package com.samseng.web.repositories.Sales_Order;

import com.samseng.web.models.Promo_Code;
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
    public List<Sales_Order> findAll() {
        try{
            return em.createQuery("select o from Sales_Order o", Sales_Order.class)
                    .getResultList();
        }catch(Exception e){
            return null;
        }
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
    public List<Sales_Order> findByUserIdPaged(String user, int page, int pageSize) {
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.user.id = :user",  Sales_Order.class)
                .setParameter("user", user)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();

    }

    @Override
    public List<Sales_Order> findByOrderIdPaged(String id, int page, int pageSize) {
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.id = :id",  Sales_Order.class)
                .setParameter("id", id)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();

    }

    @Override
    public List<Sales_Order> findPagedByQuery(String query, int page, int pageSize) {
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.id ILIKE :query",  Sales_Order.class)
                .setParameter("query", query)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();

    }


    @Override
    public long count() {
        return em.createQuery("SELECT COUNT(o) FROM Sales_Order o", Long.class)
                .getSingleResult();
    }

    @Override
    public long countByUserId(String user) {
        return em.createQuery("SELECT COUNT(o) FROM Sales_Order o WHERE o.user.id= :user", Long.class)
                .setParameter("user", user)
                .getSingleResult();
    }

    @Override
    public long countByQuery(String query) {
        return em.createQuery("SELECT COUNT(o) FROM Sales_Order o WHERE o.id ILIKE :query", Long.class)
                .setParameter("query", query)
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
