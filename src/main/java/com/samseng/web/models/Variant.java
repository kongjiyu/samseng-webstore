package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;
import lombok.Data;
import org.hibernate.annotations.NaturalId;

import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "\"Variant\"")
public class Variant {

    @Id
    @GeneratedValue(generator = "variant_id")
    @GenericGenerator(name = "variant_id", strategy = "com.samseng.web.DummyData.PrefixIdGenerator")
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

    @OneToMany(mappedBy = "variant", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Variant_Attribute> variant_attribute;

}
