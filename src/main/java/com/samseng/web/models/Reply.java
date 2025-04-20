package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;

@Getter
@Setter
@Entity
@Table(name = "\"Reply\"")
public class Reply {

    @Id
    @GeneratedValue(generator = "prefix_id")
    @GenericGenerator(name = "prefix_id", strategy = "com.samseng.web.DummyData.PrefixIdGenerator")
    @Column(name = "reply_id", unique = true, nullable = false)
    private String id;

    @NotNull
    @Size(min=1,max = 200)
    @Column(name="reply_message")
    private String message;

    @ManyToOne
    @JoinColumn(name="comment_id")
    private Comment comment;

}
