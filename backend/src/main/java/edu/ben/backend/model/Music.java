package edu.ben.backend.model;

import lombok.*;

import javax.persistence.*;

@Entity
@Data
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(name = "music")
public class Music {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Long id;
    @Column(name = "deezer_url")
    String deezerUrl;
    @Column(name = "is_song")
    Boolean isSong;
    @Column(name = "title")
    String title;
    @Column(name = "artist")
    String artist;
    @Column(name = "average_rating")
    Integer averageRating;
}
