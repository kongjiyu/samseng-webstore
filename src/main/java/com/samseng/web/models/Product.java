package com.samseng.web.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.NaturalId;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import static org.hibernate.Length.LONG32;

@Getter
@Setter
@Entity
@Table(name = "\"product\"")
public class Product {

    @Id
    @Column(name = "product_id", nullable = false, unique = true)
    private String id;

    @NaturalId
    @NotBlank
    @Column(name = "product_name")
    private String name;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(
            name = "product_images",
            joinColumns = @JoinColumn(name = "product_id")
    )
    @Column(name = "image_url")
    private Set<String> imageUrls = new HashSet<>();

    @Column(name = "product_desc", length = LONG32)
    private String desc;

    @NotNull
    @Column(name = "product_category")
    private String category;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<Variant> variants = new HashSet<>();

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<Comment> comments = new HashSet<>();

    /*
     null: total
     1: total_for_one_star
     2: total_for_two_star
     3: total_for_three_star
     4: total_for_four_star
     5: total_for_five_star
     */
    public Map<Integer, Integer> getTotalRatings() {
        var ratings = new HashMap<Integer, Integer>();

        comments.stream()
                .mapToInt(Comment::getRating)
                .forEach(rating -> {
                    ratings.merge(rating, 1, Integer::sum);
                    ratings.merge(null, 1, Integer::sum);
                });

        return ratings;
    }

    public double getAverageRating() {
        return comments.stream()
                .mapToInt(Comment::getRating)
                .average()
                .orElse(0.0);
    }
}
