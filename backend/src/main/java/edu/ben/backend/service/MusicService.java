package edu.ben.backend.service;

import edu.ben.backend.model.Music;
import edu.ben.backend.model.Review;
import edu.ben.backend.model.dto.MusicDTO;
import edu.ben.backend.repository.MusicRepository;
import edu.ben.backend.repository.ReviewRepository;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class MusicService {

    MusicRepository musicRepository;
    ReviewRepository reviewRepository;

    public MusicService(MusicRepository musicRepository, ReviewRepository reviewRepository) {
        this.musicRepository = musicRepository;
        this.reviewRepository = reviewRepository;
    }

    public List<MusicDTO> getAllMusic(String sortBy) {

        List<Music> musicResults = musicRepository.findAll();
        List<MusicDTO> musicDTOResults = new ArrayList();

        for (Music music : musicResults) {
            musicDTOResults.add(new MusicDTO(music.getId(), music.getDeezerUrl(), music.getIsSong(), music.getTitle(), music.getArtist(), music.getAverageRating()));
        }
        if (sortBy.equals("rating")) {
            musicDTOResults.sort(Comparator.comparing(MusicDTO::getAverageRating).reversed());
        } else {
            sortByPopularity(musicDTOResults);
        }
        System.out.println(musicDTOResults);
        return musicDTOResults;
    }


    public MusicDTO getMusicById(String musicId) {
        Long musicLong = Long.parseLong(musicId, 10);

        List<Music> musicResults = musicRepository.findAll();
        MusicDTO musicDTOResult = null;

        for (Music music : musicResults) {

            if (music.getId() == musicLong) {
                musicDTOResult = new MusicDTO(music.getId(), music.getDeezerUrl(), music.getIsSong(), music.getTitle(), music.getArtist(), music.getAverageRating());
            }
        }

        return musicDTOResult;
    }


    private void sortByPopularity(List<MusicDTO> musicDTOResults) {
        HashMap<Long, Integer> numReviews = new HashMap();
        List<Review> allReviews = reviewRepository.findAll();

        for (Review review : allReviews) {
            if (numReviews.containsKey(review.getMusicId())) {
                numReviews.put(review.getMusicId(), numReviews.get(review.getMusicId()) + 1);
            } else {
                numReviews.put(review.getMusicId(), 1);
            }
        }
        System.out.println("RES: " + musicDTOResults);
        for (MusicDTO musicDTO : musicDTOResults) {
            if (!numReviews.containsKey(musicDTO.getId())) {
                numReviews.put(musicDTO.getId(), 0);
            }
        }
        Collections.sort(musicDTOResults, new MapComparator(numReviews));
    }

    public List<MusicDTO> getSongsOnly() {
        List<Music> allMusic = musicRepository.findAll();
        List<MusicDTO> songList = new ArrayList();

        for (Music music : allMusic) {
            if (music.getIsSong()) {
                songList.add(new MusicDTO(music.getId(), music.getDeezerUrl(), music.getIsSong(), music.getTitle(), music.getArtist(), music.getAverageRating()));
            }
        }
        songList.sort(Comparator.comparing(MusicDTO::getAverageRating).reversed());
        return songList;
    }

    class MapComparator implements Comparator<MusicDTO> {

        HashMap<Long, Integer> map;

        public MapComparator(HashMap<Long, Integer> map) {
            this.map = map;
        }

        public int compare(MusicDTO a, MusicDTO b) {

            if (map.get(a.getId()) > map.get(b.getId())) {
                return -1;
            } else if (map.get(a.getId()) < map.get(b.getId())) {
                return 1;
            } else {
                return map.get(a.getId()).compareTo(map.get(b.getId()));
            }
        }

    }

    public List<MusicDTO> searchMusic(MusicDTO searchCriteria) {

        List<Music> musicResultsTitle = musicRepository.findAllByTitle(searchCriteria.getTitle());
        List<Music> musicResultsArtist = musicRepository.findAllByArtist(searchCriteria.getArtist());
        List<MusicDTO> musicDTOResults = new ArrayList();

        for (Music music : musicResultsTitle) {
            musicDTOResults.add(new MusicDTO(music.getId(), music.getDeezerUrl(), music.getIsSong(), music.getTitle(), music.getArtist(), music.getAverageRating()));
        }

        for (Music music : musicResultsArtist) {
            musicDTOResults.add(new MusicDTO(music.getId(), music.getDeezerUrl(), music.getIsSong(), music.getTitle(), music.getArtist(), music.getAverageRating()));
        }

        return musicDTOResults;
    }


}
