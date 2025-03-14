package com.samseng.web.user;

import com.samseng.web.user.entity.Account;
import jakarta.annotation.Nullable;
import jakarta.data.repository.*;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

@Transactional
@Repository
public interface UserRepository {
    @Find
    List<Account> findAll();

    @Find
    @Nullable
    Account findByUsername(@NotBlank String username);

    @Find
    @Nullable
    Account findByEmail(@Email String email);

    @Insert
    void insert(@Valid Account user);

    @Save
    void save(@Valid Account user);

    @Delete
    void delete(@Valid Account user);
}
