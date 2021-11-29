package edu.ben.backend.model.dto;

import lombok.*;

@Data
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class ReviewDTO {

    Long id;
    Long userId;
    String content;
    Integer rating;
    Long songId;
    Long albumId;
    Integer favorites;

    public ReviewDTO(Long userId, String content, int rating, Long songId, Long albumId, int favorites) {
        this.userId = userId;
        this.content = content;
        this.rating = rating;
        this.songId = songId;
        this.albumId = albumId;
        this.favorites = favorites;
    }
}
