package com.samseng.web.repositories.Account;


import com.samseng.web.models.Account;

public interface AccountRepository {

    Account findAccountByEmail(String email);

    List<Account> findAccountByRole(Account.Role role);
}
