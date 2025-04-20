package com.samseng.web.repositories.Account;

import com.samseng.web.models.Account;
import java.util.List;

public interface AccountRepository {
    void create(Account account);

    void update(Account account);

    void delete(Account account);

    List<Account> findAll();

    Account findAccountById(String id);

    List<Account> findAccountByUsername(String username);

    Account findAccountByEmail(String email);

    List<Account> findAccountByRole(Account.Role role);

    List<Account> searchAllFields(String keyword);
}
