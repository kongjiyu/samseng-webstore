package com.samseng.web.dto;

import com.samseng.web.models.Variant;

import java.io.Serializable;

public record CartItemDTO(
        Variant variant,
        String imageUrl,
        int quantity
) implements Serializable {
}