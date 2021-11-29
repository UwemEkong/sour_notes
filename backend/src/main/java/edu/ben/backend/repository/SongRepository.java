package edu.ben.backend.repository;

import edu.ben.backend.model.Song;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SongRepository extends JpaRepository<Song, Long> {

     List<Song> findAllByTitleAndArtist(String title, String artist);
}
