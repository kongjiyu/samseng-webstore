package com.samseng.web.repositories.Comment;

import com.samseng.web.models.Comment;

import java.util.List;

public interface CommentRepository {
    void create(Comment comment);

    void update(Comment comment);

    void delete(Comment commentId);

    List<Comment> findAll();

    Comment findById(String id);

    Comment findByProductId(String productId);

    Comment findByUserId(String userId);
}
