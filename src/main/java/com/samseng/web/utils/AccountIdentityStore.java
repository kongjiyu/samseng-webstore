package com.samseng.web.utils;

import com.samseng.web.repositories.Account.AccountRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;
import jakarta.transaction.Transactional;

import java.util.Set;

@ApplicationScoped
public class AccountIdentityStore implements IdentityStore {
    @Inject
    AccountRepository accountRepository;

    @SuppressWarnings("unused")
    @Transactional
    public CredentialValidationResult validate(UsernamePasswordCredential credential) {

        var account = accountRepository.findAccountByEmail(credential.getCaller());
        if (account == null) {
            return CredentialValidationResult.INVALID_RESULT;
        }

        if (!account.getPassword().equals(credential.getPasswordAsString())) {
            return CredentialValidationResult.INVALID_RESULT;
        }

        return  new CredentialValidationResult(
                credential.getCaller(),
                Set.of(account.getRole().name())
        );

    }
}
