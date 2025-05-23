package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.constraints.Range;

@Getter
@Setter
@Entity
@Table(name = "\"address\"")
@NoArgsConstructor
@AllArgsConstructor
public class Address {
    @Id
    @GeneratedValue(generator = "prefix_id")
    @GenericGenerator(name = "prefix_id", strategy = "com.samseng.web.DummyData.PrefixIdGenerator")
    private String id;

    @ManyToOne
    @JoinColumn(name="user_id")
    private Account user;

    @NotBlank
    @Column(name="address_name")
    private String name;

    @Pattern(regexp = "^\\+?[0-9]{10,15}$")
    @NotNull
    private String contact_no;

    @NotNull
    private String address_1;

    @NotNull
    private String address_2;

    private String address_3;

    @NotNull
    private int postcode;

    @NotNull
    private String state;

    @NotNull
    private String country;

    @Column(name = "is_default",columnDefinition = "BOOLEAN DEFAULT false")//Tells the database that if no value is specified, the default is false
    private Boolean isdefault;



}
