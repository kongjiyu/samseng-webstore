package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.hibernate.annotations.GenericGenerator;
import lombok.Data;
import org.hibernate.annotations.NaturalId;

@Data
@Entity
@Table(name = "\"Variant\"")
public class Variant {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "variant_id", unique = true, nullable = false)
    private String variantId;

    @ManyToOne
    @JoinColumn(name="product_id")
    private Product product;

    @NaturalId
    @NotBlank
    @Column(name="variant_name",unique = true)
    private String variantName;

    @NotNull
    @Column(name="variant_price",unique = true)
    private double price;


}
