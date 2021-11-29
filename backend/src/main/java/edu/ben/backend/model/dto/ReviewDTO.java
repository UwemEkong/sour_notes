package edu.ben.backend.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode
@AllArgsConstructor
public class ReviewDTO {

    long id;
    long userId;
    String content;
    int rating;
    Long songId;
    Long albumId;
    int favorites;

    public ReviewDTO(long userId, String content, int rating, Long songId, Long albumId, int favorites) {
        this.userId = userId;
        this.content = content;
        this.rating = rating;
        this.songId = songId;
        this.albumId = albumId;
        this.favorites = favorites;
    }
}
