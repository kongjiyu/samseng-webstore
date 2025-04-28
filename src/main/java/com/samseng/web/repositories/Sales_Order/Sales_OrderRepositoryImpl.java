package com.samseng.web.repositories.Sales_Order;
import java.math.BigDecimal;
import java.time.LocalDate;

import com.samseng.web.models.Promo_Code;
import com.samseng.web.models.Sales_Order;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.time.YearMonth;
import java.util.List;
import java.util.Optional;

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
        try {
            return em.createQuery("select o from Sales_Order o", Sales_Order.class)
                    .getResultList();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Sales_Order findById(String id) {
        return em.find(Sales_Order.class, id);
    }

    @Override
    public List<Sales_Order> findByUserId(String user) {
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.user = :user", Sales_Order.class)
                .setParameter("user", user)
                .getResultList();

    }


    @Override
    public Sales_Order findByRefNo(String refNo) {
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.refNo = :refNo", Sales_Order.class)
                .setParameter("refNo", refNo)
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
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.user.id = :user", Sales_Order.class)
                .setParameter("user", user)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();

    }

    @Override
    public List<Sales_Order> findByOrderIdPaged(String id, int page, int pageSize) {
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.id = :id", Sales_Order.class)
                .setParameter("id", id)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();

    }

    @Override
    public List<Sales_Order> findPagedByQuery(String query, int page, int pageSize) {
        return em.createQuery("SELECT s FROM  Sales_Order s WHERE s.id ILIKE :query", Sales_Order.class)
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

    @Override
    public void updateStatusAndDateById(String orderId, String nextStatus, String dateField, java.time.LocalDate nowDate) {
        em.createQuery("UPDATE Sales_Order o SET o.status = :status, o." + dateField + " = :nowDate WHERE o.id = :id")
                .setParameter("status", nextStatus)
                .setParameter("nowDate", nowDate)
                .setParameter("id", orderId)
                .executeUpdate();
    }



    public List<Object[]> findRevenueLast12Months() {
        String jpql = "SELECT FUNCTION('TO_CHAR', o.packDate, 'YYYY-MM') AS month, SUM(o.netPrice) " +
                "FROM Sales_Order o " +
                "WHERE o.packDate >= :startDate " +
                "GROUP BY month " +
                "ORDER BY FUNCTION('TO_CHAR', o.packDate, 'YYYY-MM') ASC";

        return em.createQuery(jpql, Object[].class)
                .setParameter("startDate", LocalDate.now().minusMonths(12))
                .getResultList();
    }

    // Total Orders This Month
    public long getTotalOrdersThisMonth() {
        LocalDate startOfMonth = YearMonth.now().atDay(1);
        return em.createQuery("SELECT COUNT(o) FROM Sales_Order o WHERE o.orderedDate >= :startOfMonth", Long.class)
                .setParameter("startOfMonth", startOfMonth)
                .getSingleResult();
    }

    // Total Orders Last Month
    public long getTotalOrdersLastMonth() {
        YearMonth lastMonth = YearMonth.now().minusMonths(1);
        LocalDate startOfLastMonth = lastMonth.atDay(1);
        LocalDate endOfLastMonth = lastMonth.atEndOfMonth();
        return em.createQuery("SELECT COUNT(o) FROM Sales_Order o WHERE o.orderedDate BETWEEN :start AND :end", Long.class)
                .setParameter("start", startOfLastMonth)
                .setParameter("end", endOfLastMonth)
                .getSingleResult();
    }

    // Revenue This Month
    public BigDecimal getRevenueThisMonth() {
        LocalDate startOfMonth = YearMonth.now().atDay(1);
        Double revenue =  Optional.ofNullable(
                em.createQuery("SELECT SUM(o.grossPrice) FROM Sales_Order o WHERE o.orderedDate >= :startOfMonth", Double.class)
                        .setParameter("startOfMonth", startOfMonth)
                        .getSingleResult()
        ).orElse(0.0);
        return BigDecimal.valueOf(revenue);
    }

    // Revenue Last Month
    public BigDecimal getRevenueLastMonth() {
        YearMonth lastMonth = YearMonth.now().minusMonths(1);
        LocalDate startOfLastMonth = lastMonth.atDay(1);
        LocalDate endOfLastMonth = lastMonth.atEndOfMonth();
        Double revenue =  Optional.ofNullable(
                em.createQuery("SELECT SUM(o.grossPrice) FROM Sales_Order o WHERE o.orderedDate BETWEEN :start AND :end", Double.class)
                        .setParameter("start", startOfLastMonth)
                        .setParameter("end", endOfLastMonth)
                        .getSingleResult()
        ).orElse(0.0);
        return BigDecimal.valueOf(revenue);
    }

    // Average Order Value This Month
    public BigDecimal getAvgOrderValueThisMonth() {
        BigDecimal revenue = getRevenueThisMonth();
        long totalOrders = getTotalOrdersThisMonth();
        if (totalOrders == 0) return BigDecimal.ZERO;
        return revenue.divide(BigDecimal.valueOf(totalOrders), 2, BigDecimal.ROUND_HALF_UP);
    }

    // Average Order Value Last Month
    public BigDecimal getAvgOrderValueLastMonth() {
        BigDecimal revenue = getRevenueLastMonth();
        long totalOrders = getTotalOrdersLastMonth();
        if (totalOrders == 0) return BigDecimal.ZERO;
        return revenue.divide(BigDecimal.valueOf(totalOrders), 2, BigDecimal.ROUND_HALF_UP);
    }

    // Today's Orders
    public long getTodayOrders() {
        LocalDate today = LocalDate.now();
        return em.createQuery("SELECT COUNT(o) FROM Sales_Order o WHERE o.orderedDate = :today", Long.class)
                .setParameter("today", today)
                .getSingleResult();
    }

    // Yesterday's Orders
    public long getYesterdayOrders() {
        LocalDate yesterday = LocalDate.now().minusDays(1);
        return em.createQuery("SELECT COUNT(o) FROM Sales_Order o WHERE o.orderedDate = :yesterday", Long.class)
                .setParameter("yesterday", yesterday)
                .getSingleResult();
    }

}