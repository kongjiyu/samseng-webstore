package com.samseng.web.repositories.Voucher;

import com.samseng.web.models.Voucher;
import java.util.List;

public interface VoucherRepository {
    void create(Voucher voucher);

    void update(Voucher voucher);

    void delete(Voucher voucher);

    Voucher findById(String id);

    List<Voucher> findByUserId(String userId);

    Voucher findByOrderId(String salesOrderId);

    List<Voucher> findAvailableAndNotExpiredByUserId(String userId);
}
