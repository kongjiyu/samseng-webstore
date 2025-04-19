package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.hibernate.annotations.NaturalId;

import java.util.Set;

@Data
@Entity
@Table(name = "\"Variant\"")
public class Variant {

    @Id
    @Column(name = "variant_id", unique = true, nullable = false)
    private String variantId;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @NaturalId
    @NotBlank
    @Column(name = "variant_name")
    private String variantName;

    @NotNull
    @Column(name = "variant_price")
    private double price;

    @NotNull
    @Column(name = "variant_availability")
    private boolean availability;

    @OneToMany(mappedBy = Variant_Attribute_.VARIANT_ID, fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<Variant_Attribute> attributes;

}
