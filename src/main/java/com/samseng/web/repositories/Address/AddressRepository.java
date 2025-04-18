package com.samseng.web.repositories.Address;

import com.samseng.web.models.Address;
import java.util.List;

public interface AddressRepository {
    void create(Address address);

    void update(Address address);

    void delete(Address addressId);

    List<Address> findByUserId(String user);

    //Find the default address for the user
    Address findDefaultByUserId(String user);

    List<Address> findByAddressName(String addressName);


}
