package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.hibernate.annotations.GenericGenerator;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "\"Voucher\"")
public class Voucher {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "voucher_id", unique = true, nullable = false)
    private String id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private Account user;

    @OneToOne
    @JoinColumn(name="order_Id")
    private Sales_Order order;

    @NotNull
    private String availability;

    @NotNull
    @Pattern(regexp = "^(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[0-2])-(19|20)\\d\\d$", message = "Invalid date format. Please use dd-MM-yyyy.")
    private String date;

    @NotNull
    private LocalDateTime expiredOn;

    @NotNull
    @Size(min=0,max=1)
    @Column(name = "voucher_desc")
    private double descount;

}
