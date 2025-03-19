package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;

@Data
@Entity
@Table(name = "\"Cart_Products\"")
public class Cart_Products {


    @Id
    @ManyToOne
    @JoinColumn(name="products_id")
    private Products products;

    @Id
    @ManyToOne
    @JoinColumn(name="user_id")
    private Account user;

    @Min(value=0)
    @NotNull
    private int quantity;

}
