package com.samseng.web.repositories.Account;


import com.samseng.web.models.Account;

public interface AccountRepository {

    Account findAccountByEmail(String email);

    Account findAccountById(String username);

    Account createAccount(Account account);

    void updateAccount(Account account);

    void deleteAccount(Account account);




}
