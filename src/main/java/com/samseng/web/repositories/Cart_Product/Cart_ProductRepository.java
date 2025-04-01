package com.samseng.web.repositories.Cart_Product;

import com.samseng.web.models.Cart_Product;
import java.util.List;

public interface Cart_ProductRepository {
    void create(Cart_Product cart_product);

    void update(Cart_Product cart_product);

    void delete(Cart_Product cart_productId);

    List<Cart_Product> findByAccountId(String account);
}
