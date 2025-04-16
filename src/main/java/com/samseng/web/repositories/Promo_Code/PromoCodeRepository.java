package com.samseng.web.repositories.Promo_Code;

import com.samseng.web.models.Promo_Code;

import java.util.List;

public interface PromoCodeRepository {
    void create(Promo_Code promoCode);

    void update(Promo_Code promoCode);

    void delete(Promo_Code promoCode);

    Promo_Code findById(String id);


}
