package com.samseng.web.dto;

import java.io.Serializable;
import java.util.List;

/**
 * DTO for {@link com.samseng.web.models.Product}
 */

public record ProductListingDTO(
        String id,
        String name,
        String desc,
        List<String> imageUrls,
        double startingPrice,
        RatingSummaryDTO ratingSummary
) implements Serializable {
}