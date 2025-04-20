package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NaturalId;
import org.hibernate.validator.constraints.URL;

import java.util.HashSet;
import java.util.Set;

import static org.hibernate.Length.LONG32;

@Getter
@Setter
@Entity
@Table(name = "\"product\"")
public class Product {

    @Id
    @Column(name="product_id", nullable = false, unique=true)
    private String id;

    @NaturalId
    @NotBlank
    @Column(name="product_name")
    private String name;

    @ElementCollection
    @CollectionTable(
            name = "product_images",
            joinColumns = @JoinColumn(name = "product_id")
    )
    @Column(name = "image_url")
    private Set<String> imageUrls = new HashSet<>();

    @Column(name="product_desc", length = LONG32)
    private String desc;

    @NotNull
    @Column(name="product_category")
    private String category;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<Variant> variants = new HashSet<>();
}
