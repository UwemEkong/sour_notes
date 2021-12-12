package edu.ben.backend.service;

import edu.ben.backend.model.Favorite;
import edu.ben.backend.repository.FavoriteRepository;
import org.springframework.stereotype.Service;

@Service
public class FavoriteService {

    FavoriteRepository favoriteRepository;
    AuthenticationService authenticationService;
    public FavoriteService(FavoriteRepository favoriteRepository, AuthenticationService authenticationService) {
        this.favoriteRepository = favoriteRepository;
        this.authenticationService = authenticationService;
    }

    public Favorite getFavorite(Long reviewId) {
        Long userId = authenticationService.getLoggedInUser().getId();
        Favorite favorite = favoriteRepository.findFavoriteByUserIdAndReviewId(userId, reviewId);
        return favorite;
    }
}
