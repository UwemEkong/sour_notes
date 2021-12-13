package edu.ben.backend.service;

import edu.ben.backend.exception.*;
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

        // checks for review limit for user
        Long userId = authenticationService.getLoggedInUser().getId();
        Long musicId = reviewDTO.getMusicId();

        boolean reviewAlreadyExists = false;
        List<Review> userReviewlist = reviewRepository.findAllByUserId(userId);

        for (int i = 0; i < userReviewlist.size(); i++) {
            if (userReviewlist.get(i).getMusicId() == musicId)
            {
                reviewAlreadyExists = true;
            }
        }
        if (reviewAlreadyExists == true){
            throw new ReviewAlreadyExistsException();
        }

        // check for review character count
        if (reviewDTO.getContent().length() < 1 || reviewDTO.getContent().length() > 250) {
            throw new InvalidContentLengthException();
        }

        // creates review
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

    public void updateReview(ReviewDTO reviewDTO) {

        if (reviewDTO.getContent().length() < 1 || reviewDTO.getContent().length() > 250) {
            throw new InvalidContentLengthException();
        }

        System.out.println("Updating Review/Rating");

        // FIND REVIEW BY ID
        List<Review> reviewlist = reviewRepository.findAllById(reviewDTO.getId());
        if (reviewlist.size() != 1){
            System.out.println("NO REVIEW WITH ID: " + reviewDTO.getId());
            return;
        }
        Review reviewUpdated = reviewlist.get(0);

        // UPDATE REVIEW CONTENT AND RATING
        reviewUpdated.setContent(reviewDTO.getContent());
        reviewUpdated.setRating(reviewDTO.getRating());
        reviewRepository.save(reviewUpdated);

        // UPDATE MUSIC AVERAGE RATING
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

    public ReviewDTO getReview(Long reviewId) {
        Optional<Review> review = reviewRepository.findById(reviewId);
        if (review.isPresent()) {
            return new ReviewDTO(review.get().getId(), review.get().getUserId(), review.get().getContent(), review.get().getRating(), review.get().getMusicId(), review.get().getFavorites());
        } else {
            return null;
        }
    }
}

