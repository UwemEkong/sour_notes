package edu.ben.backend.service;

import edu.ben.backend.model.dto.ReviewDTO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReviewService {

    public Map<Long, ReviewDTO> reviewTableInit =
            Map.of(1L, new ReviewDTO(1L,1L,"Lit",5,2L,null,2),
                    2L, new ReviewDTO(2L,2L,"So good I cant even",5,2L,null,3),
                    3L, new ReviewDTO(3L,3L,"Free iphone give away - send credit card number to urrealhomie@aol.com",3,2L,null,1));
    //long userId, string content, int rating, Long songId, Long albumId, int favorites
    public HashMap<Long, ReviewDTO> reviewTable = new HashMap<Long, ReviewDTO>(reviewTableInit);

    public List<ReviewDTO> getAllReviewsForSong(long songId){

        List<ReviewDTO> results = new ArrayList<ReviewDTO>();

        for (Long key: reviewTable.keySet()) {
            if(reviewTable.get(key).getSongId() != null && reviewTable.get(key).getSongId() == songId){
                results.add(reviewTable.get(key));
            }

        }



        return results;

    }

}
