package com.samseng.web.repositories.Variant;

import com.samseng.web.models.Variant;
import java.util.List;
import java.util.Map;

public interface VariantRepository {
    void create(Variant variant);

    void update(Variant variant);

    void delete(Variant variant);

    List<Variant> findAll();

    Variant findById(String variantId);

    List<Variant> findByProductId(String id);

    Variant findVariantByAttributes(String productId, Map<String, String> attributeValues);
}
