package com.samseng.web.repositories.Attribute;


import com.samseng.web.models.Attribute;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class AttributeRepositoryImpl implements AttributeRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void create(Attribute attribute) {
        em.persist(attribute);
    }

    @Override
    public void delete(Attribute attribute) {
        em.remove(em.merge(attribute));
    }

    @Override
    public void update(Attribute attribute) {
        em.merge(attribute);
    }

    @Override
    public Attribute findById(String id) {
        return em.find(Attribute.class, id);
    }

    @Override
    public List<Attribute> findAll() {
        try {
            return em.createQuery("SELECT a FROM Attribute a", Attribute.class)
                    .getResultList();
        }catch(NoResultException e) {
            return null;
        }
    }

    @Override
    public Attribute findByName(String name){
        try {
            return em.createQuery("SELECT a FROM Attribute a WHERE a.name= :username ", Attribute.class)
                    .setParameter("username", name)
                    .getSingleResult();
        }catch(NoResultException e){
            return null;
        }

    }

    @Override
    public List<Attribute> findByProductId(String productId){
        try{
            return em.createQuery(
                    "SELECT DISTINCT va.attributeID FROM Variant_Attribute va WHERE va.variantID.product.id = :productId",
                    Attribute.class)
                    .setParameter("productId", productId)
                    .getResultList();
        }catch(NoResultException e){
            return null;
        }
    }
}
