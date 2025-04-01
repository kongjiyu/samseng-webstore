package com.samseng.web.repositories.Reply;

import com.samseng.web.models.Reply;
import java.util.List;

public interface ReplyRepository {
    void create(Reply reply);

    void update(Reply reply);

    void delete(Reply replyId);

    List<Reply> findByCommentId(String id);

    Reply findById(String id);
}
