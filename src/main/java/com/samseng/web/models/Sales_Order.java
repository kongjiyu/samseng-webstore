package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.hibernate.annotations.GenericGenerator;

@Data
@Entity
@Table(name = "\"Sales_Order\"")
public class Sales_Order {

    @Id
    @GeneratedValue(generator = "prefix_id")
    @GenericGenerator(name = "prefix_id", strategy = "com.samseng.web.DummyData.PrefixIdGenerator")
    @Column(name = "order_id", unique = true)
    private String id;


    @ManyToOne
    @JoinColumn(name="addrerss_id")
    private Address address;

    @ManyToOne
    @JoinColumn(name="user_id")
    private Account user;

    @NotNull
    @Min(value=0)
    private double grossPrice;

    @NotNull
    @Min(value=0)
    private double taxCharge;

    @NotNull
    @Min(value=0)
    private double deliveryCharge;

    @NotNull
    @Min(value=0)
    private double netPrice;

    @NotNull
    private String status;

    @NotNull
    private String paymentMethod;

    @NotNull
    private String refNo;

}
