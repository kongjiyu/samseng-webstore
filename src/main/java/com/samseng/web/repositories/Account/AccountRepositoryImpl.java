package com.samseng.web.repositories.Account;

import com.samseng.web.models.Account;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@ApplicationScoped
@Transactional
public class AccountRepositoryImpl implements AccountRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Account findAccountByEmail(String email){
        try {
            return em.createQuery("SELECT a FROM Account a WHERE a.email = :email", Account.class)
                    .setParameter("email", email)
                    .getSingleResult();
        }catch(NoResultException e){
            return null;
        }

    }

    @Override
    public Account findAccountById(String username){
        try {
            return em.createQuery("SELECT a FROM Account a WHERE a.username = :username", Account.class)
                    .setParameter("username", username)
                    .getSingleResult();
        }catch(NoResultException e){
            return null;
        }
    }

    @Override
    public Account createAccount(Account account){
        return em.merge(account);
    }

    @Override
    public void updateAccount(Account account){
        em.merge(account);
    }

    @Override
    public void deleteAccount(Account account){
        em.remove(account);
    }


}
