package edu.ben.backend.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode
@AllArgsConstructor
public class Song {
    long id;
    String deezerUrl;
    String title;
    String artist;
    int averageRating;
    //album title
}
