package com.samseng.web.dto;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * DTO for {@link com.samseng.web.models.Sales_Order}
 */

public record OrderListingDTO(
        String id,
        double netPrice,
        String status,
        LocalDate orderedDate,
        String username,
        String email
) implements Serializable {
}