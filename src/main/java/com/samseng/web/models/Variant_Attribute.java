package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Data;


@Data
@Entity
@Table(name = "\"Variant_Attribute\"")
public class Variant_Attribute {

    @Id
    @ManyToOne
    @JoinColumn(name="variant_id")
    private Variant variantID;

    @Id
    @ManyToOne
    @JoinColumn(name="user_id")
    private Attribute attributeID;

    @NotNull
    @Column(name="value",unique = true)
    private String value;
}
