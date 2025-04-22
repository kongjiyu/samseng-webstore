package com.samseng.web.repositories.Cart_Product;

import com.samseng.web.dto.CartItemDTO;
import com.samseng.web.models.Cart_Product;
import com.samseng.web.models.Product;
import com.samseng.web.models.Variant;

import java.util.List;
import java.util.Map;

public interface Cart_ProductRepository {
    void create(Cart_Product cart_product);

    void update(Cart_Product cart_product);

    void delete(Cart_Product cart_productId);

    List<CartItemDTO> findByAccountId(String accountId);

    void addOrUpdate(String accountId, String productId, int quantity);

    void remove(String accountId, String productId);

    void updateQuantity(String accountId, String productId, int quantity);
}
