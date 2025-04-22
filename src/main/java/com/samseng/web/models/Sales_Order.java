package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "\"Sales_Order\"")
public class Sales_Order {

    @Id
    @GeneratedValue(generator = "prefix_id")
    @GenericGenerator(name = "prefix_id", strategy = "com.samseng.web.DummyData.PrefixIdGenerator")
    @Column(name = "order_id", unique = true)
    private String id;


    @ManyToOne
    @JoinColumn(name="address_id")
    private Address address;

    @ManyToOne
    @JoinColumn(name="user_id")
    private Account user;

    @ManyToOne
    @JoinColumn(name="promo_code")
    private Promo_Code promo_code;

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

    @Min(value=0)
    @Column(name = "discount_amount")
    private double discountAmount;

    @NotNull
    private String status;

    @NotNull
    private String paymentMethod;

    @NotNull
    private String refNo;

    @NotNull
    @Column(name = "order_date")
    private LocalDate orderedDate;

    @NotNull
    @Column(name = "deliver_date")
    private LocalDate deliverDate;

    @NotNull
    @Column(name = "pack_date")
    private LocalDate packDate;

    @NotNull
    @Column(name = "ship_date")
    private LocalDate shipDate;


}
