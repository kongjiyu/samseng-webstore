package com.samseng.web.repositories.Account;

import com.samseng.web.models.Account;
import com.samseng.web.models.Product;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
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

    public List<Account> searchAllFields(String keyword) {
        String lowerKeyword = keyword.toLowerCase();
        StringBuilder jpql = new StringBuilder("SELECT a FROM Account a WHERE ");
        boolean isFirst = true;

        // Check if keyword looks like an ID
        if (keyword.toUpperCase().startsWith("AC")) {
            jpql.append("CAST(a.id AS string) LIKE :idKw");
            isFirst = false;
        }

        // Check if keyword contains @
        if (keyword.contains("@")) {
            if (!isFirst) jpql.append(" OR ");
            jpql.append("LOWER(a.email) LIKE :emailKw");
            isFirst = false;
        }

        if (lowerKeyword.equals("user") || lowerKeyword.equals("admin") || lowerKeyword.equals("staff")) {
            if (!isFirst) jpql.append(" OR ");
            jpql.append("UPPER(a.role) = :roleKw");
            isFirst = false;
        }

        if (!isFirst) jpql.append(" OR ");
        jpql.append("LOWER(a.username) LIKE :usernameKw");

        TypedQuery<Account> query = em.createQuery(jpql.toString(), Account.class);

        if (keyword.toUpperCase().startsWith("AC")) {
            query.setParameter("idKw", keyword + "%");
        }
        if (keyword.contains("@")) {
            query.setParameter("emailKw", "%" + lowerKeyword + "%");
        }
        if (lowerKeyword.equals("user") || lowerKeyword.equals("admin") || lowerKeyword.equals("staff")) {
            query.setParameter("roleKw", lowerKeyword);
        }

        query.setParameter("usernameKw", "%" + lowerKeyword + "%");

        return query.getResultList();
    }

    @Override
    public long count() {
        return em.createQuery("SELECT COUNT(a) FROM Account a", Long.class)
                .getSingleResult();
    }

    @Override
    public List<Account> findPaged(int page, int pageSize) {
        return em.createQuery("SELECT a FROM Account a ORDER BY a.id", Account.class)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();
    }


}
