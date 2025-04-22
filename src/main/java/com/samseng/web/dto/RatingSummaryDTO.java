package com.samseng.web.dto;

import java.util.Map;

public record RatingSummaryDTO (
        double avgRating,
        Map<Integer, Integer> ratingTotals
){
}
