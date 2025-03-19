package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.hibernate.annotations.GenericGenerator;

@Data
@Entity
@Table(name = "\"Comment\"")

public class Comment {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "comment_id", unique = true, nullable = false)
    private String id;

    @NotNull
    private double rating;

    @NotBlank
    @Size(min=1,max = 200)
    private String message;

    @ManyToOne
    @JoinColumn(name="products_id")
    private Products products;

    @ManyToOne
    @JoinColumn(name="user_id")
    private Account user;



}
