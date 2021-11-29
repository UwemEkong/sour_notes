package edu.ben.backend.service;

import edu.ben.backend.model.Song;
import edu.ben.backend.model.dto.SongDTO;
import edu.ben.backend.repository.SongRepository;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class SongService {

    SongRepository songRepository;
    public SongService(SongRepository songRepository) {
        this.songRepository = songRepository;
    }

    public List<SongDTO> getAllSongs(){

        List<Song> songResults = songRepository.findAll();
        List<SongDTO> songDTOResults = new ArrayList();

        for (Song song: songResults) {
            songDTOResults.add(new SongDTO(song.getId(), song.getDeezerUrl(), song.getTitle(), song.getArtist(), song.getAverageRating()));
        }
        return songDTOResults;
    }

    public List<SongDTO> searchSongs(SongDTO searchCriteria){

        List<Song> songResults = songRepository.findAllByTitleAndArtist(searchCriteria.getTitle(), searchCriteria.getArtist());
        List<SongDTO> songDTOResults = new ArrayList();

        for (Song song: songResults) {
            songDTOResults.add(new SongDTO(song.getId(), song.getDeezerUrl(), song.getTitle(), song.getArtist(), song.getAverageRating()));
        }
        return songDTOResults;
    }

}
