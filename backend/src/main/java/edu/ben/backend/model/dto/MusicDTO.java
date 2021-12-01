package edu.ben.backend.model.dto;

import lombok.*;

@Data
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class MusicDTO {

    long id;
    String deezerUrl;
    boolean isSong; // otherwise album
    String title;
    String artist;
    int averageRating;
//    String albumTitle; could be single

    public MusicDTO(String deezerUrl, boolean isSong, String title, String artist, int averageRating) {
        this.deezerUrl = deezerUrl;
        this.isSong = isSong;
        this.title = title;
        this.artist = artist;
        this.averageRating = averageRating;
    }
}
