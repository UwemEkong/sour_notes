package edu.ben.backend.repository;

import edu.ben.backend.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findAllByMusicId(Long musicId);
    List<Review> findAllByUserId(Long userId);

    @Modifying
    @Transactional
    @Query("update Review r set r.favorites = :updatedFavorites where r.id = :reviewId")
    int updateFavorites(Long reviewId, Integer updatedFavorites);
}
