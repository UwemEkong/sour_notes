package edu.ben.backend.repository;

import edu.ben.backend.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findAllByMusicId(Long musicId);
    List<Review> findAllByUserId(Long userId);
}
