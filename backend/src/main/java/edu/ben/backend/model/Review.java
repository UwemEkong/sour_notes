package edu.ben.backend.model;

import lombok.*;

import javax.persistence.*;

@Entity
@Data
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "review")
public class Review {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Long id;
    @Column(name = "user_id")
    Long userId;
    @Column(name = "content")
    String content;
    @Column(name = "rating")
    Integer rating;
    @Column(name = "song_id")
    Long songId;
    @Column(name = "album_id")
    Long albumId;
    @Column(name = "favorites")
    Integer favorites;

}
