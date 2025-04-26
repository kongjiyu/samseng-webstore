package com.samseng.web.repositories.Order_Product;

import com.samseng.web.models.Order_Product;
import java.util.List;

public interface Order_ProductRepository {
    void create(Order_Product order_product);

    void update(Order_Product order_product);

    void delete(Order_Product order_productId);

    List<Order_Product> findByProductId(String id);

    List<Order_Product> findByOrderId(String id);

    List<Order_Product> findByOrderIdAndProductId(String orderId, String productId);

    List<Object[]> getTopSellingProducts();

    List<String> findTop5ProductIdsInLast6Months();

    List<Object[]> findMonthlySalesForTopProducts(List<String> productIds);

    List<Object[]> findRevenueByProductCategory();
}
