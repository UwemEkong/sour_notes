package edu.ben.backend.model.dto;

import lombok.*;

@Data
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class SongDTO {

    long id;
    String deezerUrl;
    String title;
    String artist;
    int averageRating;
//    String albumTitle; could be single

    public SongDTO(String deezerUrl, String title, String artist, int averageRating) {
        this.deezerUrl = deezerUrl;
        this.title = title;
        this.artist = artist;
        this.averageRating = averageRating;
    }
}
