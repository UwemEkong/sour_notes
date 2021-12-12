package edu.ben.backend.service;

import edu.ben.backend.exception.DuplicateFavoriteException;
import edu.ben.backend.model.Favorite;
import edu.ben.backend.model.Music;
import edu.ben.backend.model.Review;
import edu.ben.backend.model.dto.ReviewDTO;
import edu.ben.backend.repository.FavoriteRepository;
import edu.ben.backend.repository.MusicRepository;
import edu.ben.backend.repository.ReviewRepository;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ReviewService {
    ReviewRepository reviewRepository;
    AuthenticationService authenticationService;
    MusicRepository musicRepository;
    FavoriteRepository favoriteRepository;

    public ReviewService(ReviewRepository reviewRepository, AuthenticationService authenticationService, MusicRepository musicRepository, FavoriteRepository favoriteRepository) {
        this.reviewRepository = reviewRepository;
        this.authenticationService = authenticationService;
        this.musicRepository = musicRepository;
        this.favoriteRepository = favoriteRepository;
    }

    public List<ReviewDTO> getAllReviewsForSongOrAlbum(Long musicId) {

        List<Review> reviewResults = reviewRepository.findAllByMusicId(musicId);
        List<ReviewDTO> reviewDTOResults = new ArrayList();
        for (Review review: reviewResults) {
            reviewDTOResults.add(new ReviewDTO(review.getId(), review.getUserId(), review.getContent(), review.getRating(), review.getMusicId(), review.getFavorites()));
        }

        return reviewDTOResults;
    }


    public List<ReviewDTO> getAllReviewsForUser(Long userId) {

        List<Review> reviewResults = reviewRepository.findAllByUserId(userId);
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


    public void updateFavorites(ReviewDTO reviewDTO) {
        String type = getFavoriteType(reviewDTO);
        boolean canFavorite = checkDuplicateFavorite(type, reviewDTO);

        if (canFavorite) {
            reviewRepository.updateFavorites(reviewDTO.getId(), reviewDTO.getFavorites());
        } else {
            throw new DuplicateFavoriteException();
        }

    }

    private boolean checkDuplicateFavorite(String type, ReviewDTO reviewDTO) {
        Favorite previousFavorite = favoriteRepository.findFavoriteByUserIdAndReviewId(authenticationService.getLoggedInUser().getId(), reviewDTO.getId());

        if (previousFavorite == null) {
            favoriteRepository.save(new Favorite(authenticationService.getLoggedInUser().getId(), reviewDTO.getId(), type));
            return true;
        } else if (!previousFavorite.getType().equals(type)) {
            favoriteRepository.updateFavorites(previousFavorite.getId(), type);
            return true;
        } else {
            return false;
        }
    }

    private String getFavoriteType(ReviewDTO reviewDTO) {
        Review review = reviewRepository.getById(reviewDTO.getId());
        if (review.getFavorites() > reviewDTO.getFavorites()) {
            return "dislike";
        } else {
            return "like";
        }
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

