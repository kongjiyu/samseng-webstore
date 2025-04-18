package com.samseng.web.DummyData;

import com.samseng.web.models.Account;
import com.samseng.web.models.Address;
import com.samseng.web.models.Product;
import com.samseng.web.models.Variant;
import com.samseng.web.repositories.Account.AccountRepository;

import com.samseng.web.repositories.Address.AddressRepository;
import com.samseng.web.repositories.Product.ProductRepository;
import com.samseng.web.repositories.Variant.VariantRepository;
import jakarta.annotation.PostConstruct;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.inject.Inject;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import org.jboss.logging.annotations.Signature;

import javax.swing.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Set;


@Startup
@Singleton
@Transactional
public class insertDummydata {

    @Inject
    AccountRepository accountRepository;
    @Inject
    AddressRepository addressRepository;



    @PostConstruct
    public void insertTestAccount() {

        int num = 10;
        try {
            for (int i = 0; i < num; i++) {
                Account account = new Account();

                String name1 = "tester" + i;
                String email = "test" + i + "@test.com";
                String password1 = "123456";

                account.setUsername(name1);
                account.setEmail(email);
                account.setDob(LocalDate.of(2004, 6, 12));
                account.setPassword(password1);

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

                int addressCount = (i % 3) + 1;
                for (int j = 0; j < addressCount; j++) {
                    Address address = new Address();
                    address.setUser(account);
                    address.setName(account.getUsername() + " Address " + (j + 1));
                    address.setContact_no("+6012" + (1000000 + i * 100 + j));
                    address.setAddress_1("No " + (j + 1) + ", Jalan " + getRandomStreetName());
                    address.setAddress_2("Apt " + (i + 1) + "-" + (j + 1));
                    address.setAddress_3((j % 2 == 0) ? "Block " + (char) ('A' + j) : null);
                    int num1 = i + 1;
                    address.setPostcode(50000 + (num1 * 100) + j);
                    address.setState(getRandomMalaysianState());
                    address.setCountry("Malaysia");
                    address.setIsdefault(j == 0);

                    addressRepository.create(address);
                }

                System.out.println("✅ Account + Address inserted: " + account.getUsername());
            }


            System.out.println("✅ All variants inserted successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    private String getRandomStreetName() {
        String[] streets = {"Imbi", "Bukit Bintang", "Pudu", "Changkat", "Raja Chulan",
                "Sultan Ismail", "Ampang", "Bintang", "Alor", "Petaling"};
        return streets[(int) (Math.random() * streets.length)];
    }


    private String getRandomMalaysianState() {
        String[] states = {"Johor", "Kedah", "Kelantan", "Malacca", "Negeri Sembilan",
                "Pahang", "Penang", "Perak", "Perlis", "Sabah",
                "Sarawak", "Selangor", "Terengganu", "Kuala Lumpur", "Labuan"};
        return states[(int) (Math.random() * states.length)];
    }

}
