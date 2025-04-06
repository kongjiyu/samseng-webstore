package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NaturalId;

@Data
@Entity
@Table(name = "\"Product\"")
public class Product {

    @Id
    @GeneratedValue(generator = "prefix_id")
    @GenericGenerator(name = "prefix_id", strategy = "com.samseng.web.DummyData.PrefixIdGenerator")
    @Column(name="product_id", nullable = false, unique=true)
    private String id;

    @NaturalId
    @NotBlank
    @Column(name="product_name")
    private String name;

    @NotNull
    @Column(name="product_images")
    private String images;

    @Column(name="product_desc")
    private String desc;

    @NotNull
    @Column(name="product_category")
    private String category;
}
