package com.samseng.web.models;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.hibernate.annotations.GenericGenerator;
import lombok.Data;
import org.hibernate.annotations.NaturalId;


@Data
@Entity
@Table(name = "\"Attribute\"")
public class Attribute {
    @Id
    @GeneratedValue(generator = "prefix_id")
    @GenericGenerator(name = "prefix_id", strategy = "com.samseng.web.DummyData.PrefixIdGenerator")
    @Column(name = "attribute_id", unique = true, nullable = false)
    private String id;

    @NotNull
    private String name;
}
