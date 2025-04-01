package com.samseng.web.repositories.Address;


import com.samseng.web.models.Address;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class AddressRepositoryImpl implements  AddressRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Address create(Address address) {
        return em.merge(address);
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
    public Address findByAddressName(String addressname) {
        try {
            return em.createQuery("SELECT a FROM Address a WHERE a.name = :name", Address.class)
                    .setParameter("name", addressname)
                    .getSingleResult();
        }catch(NoResultException e) {
            return null;
        }
    }



    public Address findByUserId(String user) {
        try {
            return em.createQuery("SELECT a FROM Address a WHERE a.user = :user", Address.class)
                    .setParameter("user", user)
                    .getSingleResult();
        }catch(NoResultException e) {
            return null;
        }
    }



}
