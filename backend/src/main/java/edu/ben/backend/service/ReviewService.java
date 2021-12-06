package edu.ben.backend.service;

import edu.ben.backend.model.Review;
import edu.ben.backend.model.dto.ReviewDTO;
import edu.ben.backend.repository.ReviewRepository;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ReviewService {
    ReviewRepository reviewRepository;

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    public List<ReviewDTO> getAllReviewsForSongOrAlbum(Long musicId) {

        List<Review> reviewResults = reviewRepository.findAllByMusicId(musicId);
        List<ReviewDTO> reviewDTOResults = new ArrayList();
        for (Review review: reviewResults) {
            reviewDTOResults.add(new ReviewDTO(review.getId(), review.getUserId(), review.getContent(), review.getRating(), review.getMusicId(), review.getFavorites()));
        }

        return reviewDTOResults;
    }

}

