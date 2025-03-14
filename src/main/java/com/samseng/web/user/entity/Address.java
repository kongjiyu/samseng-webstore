package com.samseng.web.user.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.constraints.Range;

@Data
@Entity
@Table(name = "\"Addrerss\"")
public class Address {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "addrerss_id", unique = true, nullable = false)
    private String id;

    @ManyToOne
    @JoinColumn(name="user_id")
    private Account user;

    @Size(min=1, max=30)
    @NotBlank
    @Column(name="address_name")
    private String name;

    @Pattern(regexp = "^\\+?[0-9]{10,15}$")
    @NotNull
    private String contact_no;

    @NotNull
    @Size(min=1, max=30)
    private String address_1;

    @NotNull
    @Size(min=1, max=30)
    private String address_2;

    @Size(min=1, max=30)
    private String address_3;

    @NotNull
    @Range(min=5,max=6)
    private int postcode;

    @NotNull
    private String state;

    @NotNull
    private String country;

    @Column(name = "is_default",columnDefinition = "BOOLEAN DEFAULT false")//Tells the database that if no value is specified, the default is false
    private Boolean isdefault;



}
