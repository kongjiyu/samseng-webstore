package com.samseng.web.repositories.Address;

import com.samseng.web.models.Address;

public interface AddressRepository {

    Address findByUserId(String user);
    Address findByAddressName(String addressname);
    void update(Address address);
    void delete(Address address);
    Address create(Address address);


}
