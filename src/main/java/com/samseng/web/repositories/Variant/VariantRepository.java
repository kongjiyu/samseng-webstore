package com.samseng.web.repositories.Variant;

import com.samseng.web.models.Variant;
import java.util.List;

public interface VariantRepository {
    void create(Variant variant);

    void update(Variant variant);

    void delete(Variant variantId);

    List<Variant> findAll();

    Variant findById(String variantId);

    List<Variant> findByProductId(String id);
}
