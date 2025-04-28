package com.samseng.web.repositories.Sales_Order;

import com.samseng.web.models.Sales_Order;

import java.math.BigDecimal;
import java.util.List;

public interface Sales_OrderRepository {
    void create(Sales_Order salesOrder);

    void update(Sales_Order salesOrder);

    void delete(Sales_Order salesOrderId);

    List<Sales_Order> findAll();

    Sales_Order findById(String id);

    List<Sales_Order> findByUserId(String userId);

    Sales_Order findByRefNo(String refNo);

    List<Sales_Order> findPaged(int page, int pageSize);

    List<Sales_Order> findByOrderIdPaged(String id, int page, int pageSize);

    List<Sales_Order> findPagedByQuery(String query, int page, int pageSize);

    long count();

    long countByUserId(String user);

    List<Sales_Order> findByUserIdPaged(String user, int page, int pageSize);

    long countByQuery(String query);

    List<Object[]> findRevenueLast12Months();

    long getTotalOrdersThisMonth();

    long getTotalOrdersLastMonth();

    BigDecimal getRevenueThisMonth();

    BigDecimal getRevenueLastMonth();

    BigDecimal getAvgOrderValueThisMonth();

    BigDecimal getAvgOrderValueLastMonth();

    long getTodayOrders();

    long getYesterdayOrders();
}
