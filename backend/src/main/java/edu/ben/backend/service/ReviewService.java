package edu.ben.backend.service;

import edu.ben.backend.model.Music;
import edu.ben.backend.model.Review;
import edu.ben.backend.model.dto.ReviewDTO;
import edu.ben.backend.repository.MusicRepository;
import edu.ben.backend.repository.ReviewRepository;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ReviewService {
    ReviewRepository reviewRepository;
    AuthenticationService authenticationService;
    MusicRepository musicRepository;

    public ReviewService(ReviewRepository reviewRepository, AuthenticationService authenticationService, MusicRepository musicRepository) {
        this.reviewRepository = reviewRepository;
        this.authenticationService = authenticationService;
        this.musicRepository = musicRepository;
    }

    public List<ReviewDTO> getAllReviewsForSongOrAlbum(Long musicId) {

        List<Review> reviewResults = reviewRepository.findAllByMusicId(musicId);
        List<ReviewDTO> reviewDTOResults = new ArrayList();
        for (Review review: reviewResults) {
            reviewDTOResults.add(new ReviewDTO(review.getId(), review.getUserId(), review.getContent(), review.getRating(), review.getMusicId(), review.getFavorites()));
        }

        return reviewDTOResults;
    }

    public void createReview(ReviewDTO reviewDTO) {
        System.out.println("CREATED REVIEW");
        reviewRepository.save(new Review(authenticationService.loggedInUser.getId(), reviewDTO.getContent(), reviewDTO.getRating(), reviewDTO.getMusicId(), reviewDTO.getFavorites()));
        List<Review> allReviews = reviewRepository.findAllByMusicId(reviewDTO.getMusicId());
        Integer ratingTotal = reviewDTO.getRating();
        Integer numRatings = allReviews.size() + 1;
        for (Review review: allReviews) {
            ratingTotal+=review.getRating();
        }
        Integer finalRating = ratingTotal / numRatings;
        musicRepository.updateAverageRating(reviewDTO.getMusicId(), finalRating);
    }

    public void deleteReview(Long reviewId) {
        System.out.println("Deleting Review");
        Review review = reviewRepository.getById(reviewId);
        ReviewDTO reviewDTO = new ReviewDTO (review.getId(),review.getMusicId(), review.getContent(), review.getRating(), review.getUserId(), review.getFavorites());
         reviewRepository.deleteById(reviewId);

        List<Review> updatedReviews = reviewRepository.findAllByMusicId(reviewDTO.getMusicId());
        Integer ratingTotal = reviewDTO.getRating();
        Integer numRatings = updatedReviews.size() + 1;
        for (Review reviews: updatedReviews) {
            ratingTotal+=reviews.getRating();
        }
        Integer finalRating = ratingTotal / numRatings;
        musicRepository.updateAverageRating(reviewDTO.getMusicId(), finalRating);

    }
}

