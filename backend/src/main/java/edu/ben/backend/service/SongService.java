package edu.ben.backend.service;

import edu.ben.backend.model.dto.SongDTO;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class SongService {

    public Map<Long, SongDTO> songTableInit =
            Map.of(
                    1L, new SongDTO("https://api.deezer.com/track/1109731", "Lose Yourself", "Eminem", 3),
                    2L, new SongDTO("https://api.deezer.com/track/655877592", "3005", "Childish Gambino",5),
                    3L, new SongDTO("https://api.deezer.com/track/448121722", "Never Gonna Give You Up", "Rick Astley", 1),
                    4L, new SongDTO("https://api.deezer.com/track/7667065","Runaway","Kanye West", 5),
                    5L, new SongDTO("https://api.deezer.com/track/482883032","Baby Shark", "Foozlebots", 2));
    public HashMap<Long, SongDTO> songTable = new HashMap<Long, SongDTO>(songTableInit);

    public List<SongDTO> getAllSongs(){

        List<SongDTO> results = new ArrayList<SongDTO>();

        for (Long key: songTable.keySet()) {
            results.add(songTable.get(key));
        }

        return results;

    }

    public List<SongDTO> searchSongs(SongDTO searchCriteria){

        List<SongDTO> searchResults = new ArrayList<SongDTO>();

        for (Long key: songTable.keySet()) {
            // Match Title
            if(songTable.get(key).getTitle().toLowerCase().contains(
                    searchCriteria.getTitle().toLowerCase())){
                searchResults.add(songTable.get(key));
            }

            // Match Artist
            else if(songTable.get(key).getArtist().toLowerCase().contains(
                    searchCriteria.getArtist().toLowerCase())){
                searchResults.add(songTable.get(key));
            }

        }

        return searchResults;

    }

}
