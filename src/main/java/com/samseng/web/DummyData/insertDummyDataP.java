//package com.samseng.web.DummyData;
//
//import com.samseng.web.models.*;
//import com.samseng.web.models.Product;
//import com.samseng.web.repositories.Account.AccountRepository;
//
//import com.samseng.web.repositories.Address.AddressRepository;
//import com.samseng.web.repositories.Attribute.AttributeRepository;
//import com.samseng.web.repositories.Attribute.AttributeRepositoryImpl;
//import com.samseng.web.repositories.Product.ProductRepository;
//import com.samseng.web.repositories.Variant.VariantRepository;
//import jakarta.annotation.PostConstruct;
//import jakarta.ejb.Singleton;
//import jakarta.ejb.Startup;
//import jakarta.inject.Inject;
//import jakarta.enterprise.context.ApplicationScoped;
//import jakarta.persistence.EntityManager;
//import jakarta.transaction.Transactional;
//import org.jboss.logging.annotations.Signature;
//
//import javax.swing.*;
//import java.math.BigDecimal;
//import java.time.LocalDate;
//import java.util.Set;
//
//
//@Startup
//@Singleton
//@Transactional
//public class insertDummyDataP {
//
//    @Inject
//    AttributeRepository attributeRepository;
//    @PostConstruct
//    public void insertTest() {
//        int num=5;
//        for (int i=0;i<num;i++) {
//            Attribute attribute=new Attribute();
//            if(i==0) {
//                attribute.setName("Color");
//            }
//            else if (i==1) {
//                attribute.setName("Length");
//            }
//            else if (i==2) {
//                attribute.setName("Capacity");
//            }
//            else if (i==3) {
//                attribute.setName("Size");
//            }
//            else {
//                attribute.setName("Storage");
//            }
//            attributeRepository.create(attribute);
//        }
//    }
//}
