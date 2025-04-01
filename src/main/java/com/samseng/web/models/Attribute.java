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
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "attribute_id", unique = true, nullable = false)
    private String id;

    @NotNull
    private String name;
}
