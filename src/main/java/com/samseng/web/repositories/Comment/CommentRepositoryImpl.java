package com.samseng.web.repositories.Comment;

import com.samseng.web.models.Comment;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class CommentRepositoryImpl implements CommentRepository {
    @PersistenceContext
    private EntityManager em;

    @Override
    public void create(Comment comment) {
        em.persist(comment);
    }

    @Override
    public void delete(Comment comment) {
        em.remove(comment);
    }
    @Override
    public void update(Comment comment) {
        em.merge(comment);
    }

    @Override
   public Comment findById(String id) {
        return em.find(Comment.class, id);
   }

    @Override
    public List<Comment> findAll() {
        try {
            return em.createQuery("SELECT c FROM  Comment c", Comment.class)
                    .getResultList();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public  Comment findByProductId(String product){

        return em.createQuery("SELECT c FROM  Comment c WHERE c.product = :product",   Comment.class)
                .setParameter("product", product)
                .getSingleResult();

    }

    @Override
    public  Comment findByUserId(String user){

        return em.createQuery("SELECT c FROM  Comment c WHERE c.user = :user",   Comment.class)
                .setParameter("user", user)
                .getSingleResult();

    }


}
