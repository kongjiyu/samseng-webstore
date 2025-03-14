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
@Table(name = "\"Products\"")
public class Products {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name="products_id", nullable = false, unique=true) // 保证字段一致
    private String id;

    @NaturalId
    @NotBlank
    @Column(name="products_name")
    private String name;

    @NotNull
    @Column(name="products_images")
    private String images;

    @Max(value=1)
    @Column(name="products_desc")
    private double desc;

    @NotNull
    @Column(name="products_quantity")
    private int quantity;

    @NotNull
    @Column(name="products_price")
    private double price;

    @NotNull
    @Column(name="products_category")
    private String category;
}
