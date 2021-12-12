package edu.ben.backend.resource;

import edu.ben.backend.model.Favorite;
import edu.ben.backend.service.FavoriteService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "api/favorite", produces = "application/json")
public class FavoriteResource {

    private final FavoriteService favoriteService;
    public FavoriteResource(FavoriteService favoriteService) {
    this.favoriteService = favoriteService;
    }

    @GetMapping("/getFavorite/{reviewid}")
    public Favorite getFavorite(@PathVariable Long reviewid) {
        return this.favoriteService.getFavorite(reviewid);
    }
}
