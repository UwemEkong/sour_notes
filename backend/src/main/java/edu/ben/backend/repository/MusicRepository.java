package edu.ben.backend.repository;

import edu.ben.backend.model.Music;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MusicRepository extends JpaRepository<Music, Long> {

     List<Music> findAllByTitleAndArtist(String title, String artist);
     List<Music> findAll();
     List<Music> findAllByTitle(String title);
}
