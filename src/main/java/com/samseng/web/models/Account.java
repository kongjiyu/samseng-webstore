package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NaturalId;

import java.time.LocalDate;

@Data
@Entity
@Table(name = "\"Account\"")


public class Account {
    @Id
    @Column(name = "user_id", unique = true, nullable = false)
    private String id;

    @NaturalId
    @NotBlank
    @Column(unique = true)
    private String username;

    @NaturalId
    @Email
    @Column(unique = true)
    private String email;

    @NotNull
    @Size(max = 60)
    private byte[] password;

    @Enumerated(EnumType.STRING)
    @ColumnDefault("USER")
    private Role role;


    @Past
    private LocalDate dob;

    public enum Role {
        USER, ADMIN, STAFF
    }

}
