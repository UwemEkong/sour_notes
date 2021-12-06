package edu.ben.backend.service;

import edu.ben.backend.model.Music;
import edu.ben.backend.model.dto.MusicDTO;
import edu.ben.backend.repository.MusicRepository;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class MusicService {

    MusicRepository musicRepository;
    public MusicService(MusicRepository musicRepository) {
        this.musicRepository = musicRepository;
    }

    public List<MusicDTO> getAllMusic(){

        List<Music> musicResults = musicRepository.findAll();
        List<MusicDTO> musicDTOResults = new ArrayList();

        for (Music music: musicResults) {
            musicDTOResults.add(new MusicDTO(music.getId(), music.getDeezerUrl(), music.getIsSong(),music.getTitle(), music.getArtist(), music.getAverageRating()));
        }
        musicDTOResults.sort(Comparator.comparing(MusicDTO::getAverageRating).reversed());
        return musicDTOResults;
    }

    public List<MusicDTO> searchMusic(MusicDTO searchCriteria){

        List<Music> musicResults = musicRepository.findAllByTitle(searchCriteria.getTitle());
        List<MusicDTO> musicDTOResults = new ArrayList();

        for (Music music: musicResults) {
            musicDTOResults.add(new MusicDTO(music.getId(), music.getDeezerUrl(), music.getIsSong(),music.getTitle(), music.getArtist(), music.getAverageRating()));
        }
        return musicDTOResults;
    }


}
