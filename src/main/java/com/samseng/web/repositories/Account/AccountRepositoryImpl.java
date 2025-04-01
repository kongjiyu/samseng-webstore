package com.samseng.web.repositories.Account;

import com.samseng.web.models.Account;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

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
    public   List<Account> findAccountByUsername(String username){

            return em.createQuery("SELECT a FROM Account a WHERE a.username = :username", Account.class)
                    .setParameter("username", username)
                    .getResultList();

    }

    @Override
    public List<Account> findAll() {
        return em.createQuery("SELECT a FROM Account a", Account.class)
                .getResultList();
    }

    @Override
    public Account findAccountById(String id) {
        return em.find(Account.class, id);
    }

    public List<Account> findAccountByRole(Account.Role role){
        return em.createQuery("SELECT a FROM Account a WHERE a.role = :role", Account.class)
                .setParameter("role", role)
                .getResultList();

    }

    @Override
    public void create(Account account){
        em.persist(account);
    }

    @Override
    public void update(Account account){
        em.merge(account);
    }

    @Override
    public void delete(Account account){
        em.remove(account);
    }


}
