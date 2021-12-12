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
@Table(name = "favorite")
public class Favorite {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Long id;
    @Column(name = "user_id")
    Long userId;
    @Column(name = "review_id")
    Long reviewId;
    @Column(name = "type")
    String type;

    public Favorite(Long userId, Long reviewId, String type) {
        this.userId = userId;
        this.reviewId = reviewId;
        this.type = type;
    }
}
