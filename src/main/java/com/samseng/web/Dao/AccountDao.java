package com.samseng.web.Dao;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepositoryImpl;
import jakarta.inject.Inject;

import java.util.List;

public class AccountDao {

    @Inject
    private AccountRepositoryImpl accountRepo;

    public Account findAccountByEmail(String email) {
        return accountRepo.findAccountByEmail(email);
    }

    public List<Account> findAccountByUsername(String username) {
        return accountRepo.findAccountByUsername(username);
    }

    public List<Account> findAll() {
        return accountRepo.findAll();
    }

    public Account findAccountById(String id) {
        return accountRepo.findAccountById(id);
    }

    public List<Account> findAccountByRole(Account.Role role) {
        return accountRepo.findAccountByRole(role);
    }

    public void create(Account account) {
        accountRepo.create(account);
    }

    public void update(Account account) {
        accountRepo.update(account);
    }

    public void delete(Account account) {
        accountRepo.delete(account);
    }

}
