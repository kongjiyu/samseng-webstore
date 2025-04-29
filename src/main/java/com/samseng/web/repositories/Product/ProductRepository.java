package com.samseng.web.repositories.Product;

import com.samseng.web.models.Product;
import jakarta.transaction.Transactional;

import java.util.List;
@Transactional
public interface ProductRepository {
    void create(Product product);

    void delete(Product product);

    void update(Product productId);

    List<Product> findAll();

    Product findById(String id);

    Product findByName(String name);

    long count();

    void markAsDeleted(String productId);

}
