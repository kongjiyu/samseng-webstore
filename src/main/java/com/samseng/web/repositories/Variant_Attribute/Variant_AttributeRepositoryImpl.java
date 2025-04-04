package com.samseng.web.repositories.Variant_Attribute;

import com.samseng.web.models.Variant_Attribute;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class Variant_AttributeRepositoryImpl implements Variant_AttributeRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void create(Variant_Attribute variant_attribute) {
        em.persist(variant_attribute);
    }

    @Override
    public void update(Variant_Attribute variant_attribute) {
        em.merge(variant_attribute);
    }

    @Override
    public void delete(Variant_Attribute variant_attribute) {
        em.remove(variant_attribute);
    }

    @Override
    public  List<Variant_Attribute> findAll(){
        return em.createQuery("SELECT v FROM Variant v ", Variant_Attribute.class).getResultList();
    }

    @Override
    public List<Variant_Attribute> findByVariantId(String variantID){
        return em.createQuery("SELECT v FROM Variant_Attribute v WHERE v.variantID=:variantID", Variant_Attribute.class)
                .setParameter("variantID", variantID)
                .getResultList();

    }

    @Override
    public List<Variant_Attribute> findByAttributeId(String attributeID){
        return em.createQuery("SELECT v FROM Variant_Attribute v WHERE v.attributeID=:attributeID", Variant_Attribute.class)
                .setParameter("attributeID", attributeID)
                .getResultList();

    }

    @Override
    public Variant_Attribute findByVariantIdAndAttributeId(String variantID, String attributeID){
        return em.createQuery("SELECT v FROM Variant_Attribute v WHERE v.attributeID=:attributeID AND v.variantID=:variantID", Variant_Attribute.class)
                .setParameter("attributeID", attributeID)
                .setParameter("variantID", variantID)
                .getSingleResult();

    }
}
