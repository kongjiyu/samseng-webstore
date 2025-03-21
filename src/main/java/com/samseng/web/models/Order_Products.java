package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;

@Data
@Entity
@Table(name = "\"Order_Products\"")

public class Order_Products {
    @Id
    @ManyToOne
    private Products products;

    @Id
    @ManyToOne
    private Sales_Order salesOrder;

    @Min(value=0)
    @NotNull
    private int quantity;

    @NotNull
    @Min(value = 0)
    @Column(name = "unit_price")
    private double price;

    @NotBlank
    @Size(min=0,max=50)
    private String status;


}
