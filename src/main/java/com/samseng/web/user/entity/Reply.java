package com.samseng.web.user.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NaturalId;
import org.hibernate.validator.constraints.Range;

@Data
@Entity
@Table(name = "\"Reply\"")
public class Reply {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
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
