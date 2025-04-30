package com.samseng.web.repositories.Comment;

import com.samseng.web.models.Comment;
import com.samseng.web.models.Product;
import jakarta.ejb.Stateless;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;

@Stateless // can go ahead call no need to import the method
@Transactional
public class CommentRepositoryImpl implements CommentRepository {
    @PersistenceContext
    private EntityManager em;

    @Override
    public void create(Comment comment) {
        System.out.println(">> Persist called with comment: " + comment.getMessage());
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
    public List<Comment> findByProductId(String productId) {
        return em.createQuery(
                        "SELECT c FROM Comment c LEFT JOIN FETCH c.reply WHERE c.product.id = :productId",
                        Comment.class
                )
                .setParameter("productId", productId)
                .getResultList();
    }



    @Override
    public  Comment findByUserId(String user){

        return em.createQuery("SELECT c FROM  Comment c WHERE c.user = :user",   Comment.class)
                .setParameter("user", user)
                .getSingleResult();

    }

    @Override
    public boolean hasUserCommentedOnProduct(String userId, String productId) {
        try {
            Long count = em.createQuery(
                "SELECT COUNT(c) FROM Comment c WHERE c.user.id = :userId AND c.product.id = :productId",
                Long.class
            )
            .setParameter("userId", userId)
            .setParameter("productId", productId)
            .getSingleResult();
            return count != null && count > 0;
        } catch (Exception e) {
            return false;
        }
    }

}
