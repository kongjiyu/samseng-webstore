package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "\"order_product\"")

public class Order_Product {
    @Id
    @ManyToOne
    @JoinColumn(name = "variant_id")
    private Variant variant;

    @Id
    @ManyToOne
    @JoinColumn(name = "order_id")
    private Sales_Order salesOrder;

    @Min(value=0)
    @NotNull
    private int quantity;

    @NotNull
    @Min(value = 0)
    @Column(name = "unit_price")
    private double price;



}

