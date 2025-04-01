package com.samseng.web.repositories.Product;

import com.samseng.web.models.Product;

public interface ProductRepository {
    void create(Product product);

    void remove(Product product);

    void update(Product productId);

    Product findById(String id);

    Product findByName(String name);

}
