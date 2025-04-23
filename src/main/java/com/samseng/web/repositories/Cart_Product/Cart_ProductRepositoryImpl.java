package com.samseng.web.repositories.Cart_Product;

import com.samseng.web.models.Cart_Product;
import com.samseng.web.models.Variant;
import com.samseng.web.dto.CartItemDTO;
import java.util.ArrayList;
import com.samseng.web.repositories.Account.AccountRepository;
import com.samseng.web.repositories.Product.ProductRepository;
import com.samseng.web.repositories.Variant.VariantRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.List;
@ApplicationScoped // can go ahead call no need to import the method
@Transactional
public class Cart_ProductRepositoryImpl implements Cart_ProductRepository {
    @PersistenceContext
    private EntityManager em;

    @Inject
    AccountRepository accountRepository;

    @Inject
    ProductRepository productRepository;

    @Inject
    VariantRepository variantRepository;

    @Override
    public void create(Cart_Product cart_product) {
        em.persist(cart_product);
    }

    @Override
    public void update(Cart_Product cart_product) {
        em.merge(cart_product);
    }

    @Override
    public void delete(Cart_Product cart_product) {
        em.remove(cart_product);
    }

    @Override
    public List<CartItemDTO> findByAccountId(String accountId) {
        List<Cart_Product> cartList = em.createQuery("SELECT c FROM Cart_Product c WHERE c.account.id= :account", Cart_Product.class)
                .setParameter("account", accountId)
                .getResultList();
        List<CartItemDTO> dtoList = new ArrayList<>();
        for (Cart_Product cart_product : cartList) {
            Variant variant = cart_product.getVariant();
            String imageUrl = variant.getProduct().getImageUrls().stream().findFirst().orElse(null);
            int quantity = cart_product.getQuantity();
            dtoList.add(new CartItemDTO(variant, imageUrl, quantity));
        }
        return dtoList;
    }

    @Override
    public void addOrUpdate(String accountId, String variantId, int quantity) {
        Cart_Product existing = em.createQuery("SELECT c FROM Cart_Product c WHERE c.account.id = :accountId AND c.variant.id = :variantId", Cart_Product.class)
                .setParameter("accountId", accountId)
                .setParameter("variantId", variantId)
                .getResultStream()
                .findFirst()
                .orElse(null);

        if (existing != null) {
            existing.setQuantity(existing.getQuantity() + quantity);
            em.merge(existing);
        } else {
            Cart_Product newCartProduct = new Cart_Product();
            newCartProduct.setAccount(accountRepository.findAccountById(accountId)); // assumes account is stored as a String or handle conversion
            newCartProduct.setVariant(variantRepository.findById(variantId)); // assumes variant ID can be set this way or retrieve variant entity first
            newCartProduct.setQuantity(quantity);
            em.persist(newCartProduct);
        }
    }

    @Override
    public void remove(String accountId, String variantId) {
        Cart_Product existing = em.createQuery("SELECT c FROM Cart_Product c WHERE c.account.id = :accountId AND c.variant.id = :variantId", Cart_Product.class)
                .setParameter("accountId", accountId)
                .setParameter("variantId", variantId)
                .getResultStream()
                .findFirst()
                .orElse(null);
        if (existing != null) {
            em.remove(existing);
        }
    }

    @Override
    public void updateQuantity(String accountId, String variantId, int quantity) {
        Cart_Product existing = em.createQuery("SELECT c FROM Cart_Product c WHERE c.account.id = :accountId AND c.variant.id = :variantId", Cart_Product.class)
                .setParameter("accountId", accountId)
                .setParameter("variantId", variantId)
                .getResultStream()
                .findFirst()
                .orElse(null);
        if (existing != null) {
            existing.setQuantity(quantity);
            em.merge(existing);
        }
    }
}