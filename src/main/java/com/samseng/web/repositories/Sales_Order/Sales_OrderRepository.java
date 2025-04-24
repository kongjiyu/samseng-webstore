package com.samseng.web.repositories.Sales_Order;

import com.samseng.web.models.Sales_Order;
import java.util.List;

public interface Sales_OrderRepository {
    void create(Sales_Order salesOrder);

    void update(Sales_Order salesOrder);

    void delete(Sales_Order salesOrderId);

    Sales_Order findById(String id);

    List<Sales_Order> findByUserId(String userId);

    Sales_Order findByRefNo(String refNo);

    List<Sales_Order> findPaged(int page, int pageSize);

    long count();

    List<Sales_Order> findByUserIdPaged(String user, int page, int pageSize);
}
