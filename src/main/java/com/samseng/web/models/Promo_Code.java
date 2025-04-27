package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "\"promo_code\"")
public class Promo_Code {

    @Id
    @Column(name = "promo_code", unique = true, nullable = false)
    private String id;


    @NotNull
    private boolean availability;


    @NotNull
    @DecimalMin("0.0")
    @DecimalMax("1.0")
    @Column(name = "discount_rate")
    private double discount;

    @NotNull
    @Column(name = "promo_code_description")
    private String desc;

}
