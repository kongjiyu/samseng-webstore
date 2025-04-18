package com.samseng.web.Dao;

import com.samseng.web.models.Address;
import com.samseng.web.repositories.Address.AddressRepositoryImpl;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;
@ApplicationScoped
public class AddressDao {

    @Inject
    private AddressRepositoryImpl addressRepository;

    public void create(Address address) {
        addressRepository.create(address);
    }

    public void update(Address address) {
        addressRepository.update(address);
    }

    public void delete(Address address) {
        addressRepository.delete(address);
    }

    public void unsetOtherDefaults(String userId, String currentAddressId) {
        addressRepository.unsetOtherDefaults(userId, currentAddressId);
    }

    public void clearDefaultForUser(String userId) {
        addressRepository.clearDefaultForUser(userId);
    }

    public List<Address> findByUserId(String id){
        return addressRepository.findByUserId(id);
    }

    public Address findById(String id) {
        return addressRepository.findById(id);
    }
}
