package com.samseng.web.repositories.Variant_Attribute;

import com.samseng.web.models.Variant_Attribute;
import java.util.List;

public interface Variant_AttributeRepository {
    void create(Variant_Attribute variant_attribute);

    void update(Variant_Attribute variant_attribute);

    void delete(Variant_Attribute variant_attributeId);

    List<Variant_Attribute> findAll();

    List<Variant_Attribute> findByVariantId(String variantID);

    List<Variant_Attribute> findByProductId(String productID);

    List<Variant_Attribute> findByAttributeId(String  attributeID);

    Variant_Attribute findByVariantIdAndAttributeId(String variantId, String attributeId);
}
