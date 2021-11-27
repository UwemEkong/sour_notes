package edu.ben.backend.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode
@AllArgsConstructor
public class Review {
//    `idReviews` INT NOT NULL,
//            `userID` INT NOT NULL,
//            `content` VARCHAR(450) NULL,
//  `rating` INT NOT NULL,
//            `Type` VARCHAR(45) NOT NULL,
//  `SongID` VARCHAR(45) NULL,
//  `AlbumID` VARCHAR(45) NULL,
//  `Favorites` INT NULL,

    long id;
    long userId;
    String content;
    int rating;
    long songId;
    long albumId;
    int favorites;

}
