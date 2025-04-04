package com.samseng.web.repositories.Voucher;

import com.samseng.web.models.Voucher;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class VoucherRepositoryImpl implements VoucherRepository {

    @PersistenceContext
    private EntityManager em;

    public void create(Voucher voucher) {
        em.persist(voucher);
    }

    public void update(Voucher voucher) {
        em.merge(voucher);
    }

    public void delete(Voucher voucher) {
        em.remove(em.find(Voucher.class, voucher.getId()));
    }

    public Voucher findById(String id) {
        return em.find(Voucher.class, id);
    }
    public List<Voucher> findByUserId(String userId){
        return em.createQuery("SELECT v FROM Voucher v WHERE v.user.id = :userId", Voucher.class)
                .setParameter("userId", userId)
                .getResultList();
    }


    public Voucher findByOrderId(String salesOrderId) {
        return em.createQuery("SELECT v FROM Voucher v WHERE v.salesOrder.id = :salesOrderId", Voucher.class)
                .setParameter("salesOrderId", salesOrderId)
                .getSingleResult();
    }


    public List<Voucher> findAvailableAndNotExpiredByUserId(String userId) {
        return em.createQuery(
                        "SELECT v FROM Voucher v WHERE v.user.id = :userId AND v.availability = 'Y' AND v.expiredOn > CURRENT_TIMESTAMP",
                        Voucher.class)
                .setParameter("userId", userId)
                .getResultList();
    }


}
