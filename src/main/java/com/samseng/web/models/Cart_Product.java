package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "\"Cart_Product\"")

public class Cart_Product {


    @Id
    @ManyToOne
    @JoinColumn(name="product_id")
    private Product product;

    @Id
    @ManyToOne
    @JoinColumn(name="account_id")
    private Account account;

    @Min(value=0)
    @NotNull
    private int quantity;

}
