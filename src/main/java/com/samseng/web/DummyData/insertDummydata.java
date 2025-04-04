package com.samseng.web.DummyData;

import com.samseng.web.models.Account;
import com.samseng.web.models.Address;
import com.samseng.web.repositories.Account.AccountRepository;

import com.samseng.web.repositories.Address.AddressRepository;
import jakarta.annotation.PostConstruct;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.inject.Inject;
import jakarta.enterprise.context.ApplicationScoped;
import org.jboss.logging.annotations.Signature;

import javax.swing.*;
import java.time.LocalDate;


@Startup
@Singleton
public class insertDummydata {

    @Inject
    AccountRepository accountRepository;
    @Inject
    AddressRepository addressRepository;


    @PostConstruct
    public void insertTestAccount() {

        int num =10;
        try {
                for (int i=0 ; i<num;i++) {
                    Account account = new Account();

                    String name1 = "tester" + i;
                    String email = "test" + i + "@test.com";
                    String password1 = "123456";

                    account.setUsername(name1);
                    account.setEmail(email);
                    account.setDob(LocalDate.of(2004, 6, 12));
                    account.setPassword(password1.getBytes());

                    if (i == 0) {
                        account.setRole(Account.Role.USER);
                    } else if (i % 2 == 0) {
                        account.setRole(Account.Role.ADMIN);
                    } else if (i % 3 == 0) {
                        account.setRole(Account.Role.STAFF);
                    } else {
                        account.setRole(Account.Role.USER);
                    }

                    accountRepository.create(account);
                    System.out.println("✅ Account inserted!");
                }



        }catch (Exception e) {
            e.printStackTrace();
        }





    }
    private String getRandomStreetName() {
        String[] streets = {"Imbi", "Bukit Bintang", "Pudu", "Changkat", "Raja Chulan",
                "Sultan Ismail", "Ampang", "Bintang", "Alor", "Petaling"};
        return streets[(int)(Math.random() * streets.length)];
    }


    private String getRandomMalaysianState() {
        String[] states = {"Johor", "Kedah", "Kelantan", "Malacca", "Negeri Sembilan",
                "Pahang", "Penang", "Perak", "Perlis", "Sabah",
                "Sarawak", "Selangor", "Terengganu", "Kuala Lumpur", "Labuan"};
        return states[(int)(Math.random() * states.length)];
    }



}
