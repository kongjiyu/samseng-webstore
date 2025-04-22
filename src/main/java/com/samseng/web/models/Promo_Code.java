package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;

@Getter
@Setter
@Entity
@Table(name = "\"promo_code\"")
public class Promo_Code {

    @Id
    @GeneratedValue(generator = "prefix_id")
    @GenericGenerator(name = "prefix_id", strategy = "com.samseng.web.DummyData.PrefixIdGenerator")
    @Column(name = "promo_code", unique = true, nullable = false)
    private String id;


    @NotNull
    private String availability;


    @NotNull
    @Size(min=0,max=1)
    @Column(name = "discount_rate")
    private double discount;

}
