package edu.ben.backend.repository;

import edu.ben.backend.model.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface FavoriteRepository extends JpaRepository<Favorite, Long> {
    Favorite findFavoriteByUserIdAndReviewId(Long userId, Long reviewId);

    @Modifying
    @Transactional
    @Query("update Favorite f set f.type = :updatedType where f.id = :favoriteId")
    int updateFavorites(Long favoriteId, String updatedType);
}

