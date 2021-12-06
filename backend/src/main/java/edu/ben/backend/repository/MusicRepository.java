package edu.ben.backend.repository;

import edu.ben.backend.model.Music;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface MusicRepository extends JpaRepository<Music, Long> {

     List<Music> findAllByTitleAndArtist(String title, String artist);
     List<Music> findAll();
     List<Music> findAllByTitle(String title);

     @Modifying
     @Transactional
     @Query("update Music m set m.averageRating = :updatedRating where m.id = :musicId")
     int updateAverageRating(Long musicId, Integer updatedRating);
}
