package com.samseng.web.repositories.Address;


import com.samseng.web.models.Address;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class AddressRepositoryImpl implements  AddressRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void create(Address address) {
       em.persist(address);
    }

    @Override
    public void delete(Address address) {
        em.remove(address);
    }

    @Override
    public void update(Address address) {
        em.merge(address);
    }


    @Override
    public List<Address> findByAddressName(String addressname) {
        try {
            return em.createQuery("SELECT a FROM Address a WHERE a.name = :name", Address.class)
                    .setParameter("name", addressname)
                    .getResultList();
        }catch(NoResultException e) {
            return null;
        }
    }

    public Address findDefaultByUserId(String user){
        try {
            return em.createQuery("SELECT a FROM Address a WHERE a.user = :user AND a.isdefault = true", Address.class)
                    .setParameter("user", user)
                    .getSingleResult();
        }catch(NoResultException e) {
            return null;
        }

    }

    public List<Address> findByUserId(String id) {
        return em.createQuery("SELECT a FROM Address a WHERE a.user.id = :userId", Address.class)
                .setParameter("userId", id)
                .getResultList();
    }

    public void unsetOtherDefaults(String userId, String currentAddressId) {
        em.getTransaction().begin();
        em.createQuery("UPDATE Address a SET a.isdefault = false WHERE a.user.id = :userId AND a.id != :currentId")
                .setParameter("userId", userId)
                .setParameter("currentId", currentAddressId)
                .executeUpdate();
        em.getTransaction().commit();
    }

    public void clearDefaultForUser(String userId) {
        em.getTransaction().begin();
        em.createQuery("UPDATE Address a SET a.isdefault = false WHERE a.user.id = :userId")
                .setParameter("userId", userId)
                .executeUpdate();
        em.getTransaction().commit();
    }

    public Address findById(String id) {
        return em.find(Address.class, id);
    }

}
