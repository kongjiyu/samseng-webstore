package com.samseng.web.repositories.Promo_Code;

import com.samseng.web.models.Promo_Code;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class PromoCodeRepositoryImpl implements PromoCodeRepository {

    @PersistenceContext
    private EntityManager em;

    public void create(Promo_Code promoCode) {
        em.persist(promoCode);
    }

    public void update(Promo_Code promoCode) {
        em.merge(promoCode);
    }

    public void delete(Promo_Code promoCode) {
        em.remove(em.find(Promo_Code.class, promoCode.getId()));
    }

    public Promo_Code findById(String id) {
        return em.find(Promo_Code.class, id);
    }

}
