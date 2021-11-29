package edu.ben.backend.service;

import edu.ben.backend.model.Review;
import edu.ben.backend.model.dto.ReviewDTO;
import edu.ben.backend.repository.ReviewRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReviewService {

    ReviewRepository reviewRepository;
    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    public List<ReviewDTO> getAllReviewsForSong(Long songId) {

        List<Review> reviewResults = reviewRepository.findAllBySongId(songId);
        List<ReviewDTO> reviewDTOResults = new ArrayList();

        for (Review review: reviewResults) {
            reviewDTOResults.add(new ReviewDTO(review.getId(), review.getUserId(), review.getContent(), review.getRating(), review.getSongId(), review.getAlbumId(), review.getFavorites()));
        }
        return reviewDTOResults;
    }

}
