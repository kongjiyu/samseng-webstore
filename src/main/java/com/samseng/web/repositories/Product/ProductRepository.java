package com.samseng.web.repositories.Product;

import com.samseng.web.models.Product;

import java.util.List;

public interface ProductRepository {
    void create(Product product);

    void remove(Product product);

    void update(Product productId);

    List<Product> findAll();

    Product findById(String id);

    Product findByName(String name);

}
