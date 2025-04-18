package com.samseng.web.repositories.Attribute;

import com.samseng.web.models.Attribute;
import java.util.List;

public interface AttributeRepository {
    void create(Attribute attribute);

    void update(Attribute attribute);

    void delete(Attribute attributeId);

    Attribute findById(String id);

    Attribute findByName(String name);

    List<Attribute> findAll();

    List<Attribute> findByProductId(String productId);
}
