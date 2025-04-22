package com.samseng.web.utils;

import com.samseng.web.models.Account;
import com.samseng.web.repositories.Account.AccountRepository;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

@WebFilter("/*")
public class UserSessionFilter implements Filter {
    @Inject
    AccountRepository accountRepository;

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        if (request.getUserPrincipal() != null &&
                request.getSession().getAttribute("profile") == null) {

            String email = request.getUserPrincipal().getName();
            Account account = accountRepository.findAccountByEmail(email);
            if (account != null) {
                request.getSession().setAttribute("profile", account);
            }
        }
        chain.doFilter(req, res);
    }
}
