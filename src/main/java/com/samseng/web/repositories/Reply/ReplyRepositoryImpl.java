package com.samseng.web.repositories.Reply;

import com.samseng.web.models.Reply;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.NoResultException;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped // can go ahead call no need to import the method
@Transactional

public class ReplyRepositoryImpl implements ReplyRepository {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void create(Reply reply) {
        em.persist(reply);
    }

    @Override
    public void delete(Reply reply) {
        em.remove(reply);
    }

    @Override
    public void update(Reply reply) {
        em.merge(reply);
    }

    @Override
    public Reply findById(String id) {
        return em.find(Reply.class, id);
    }

    @Override
    public List<Reply>findByCommentId(String comment) {
        return em.createQuery("SELECT r FROM Reply r WHERE r.comment=:comment",Reply.class)
                .setParameter("comment",comment)
                .getResultList();

    }
}
