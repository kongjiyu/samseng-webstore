package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "\"Variant_Attribute\"")
public class Variant_Attribute {

    @Id
    @ManyToOne
    @JoinColumn(name="variant_id")
    private Variant variant;

    @Id
    @ManyToOne
    @JoinColumn(name="attribute_id")
    private Attribute attribute;

    @NotNull
    @Column(name="value")
    private String value;
}
