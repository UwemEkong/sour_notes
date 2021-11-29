package edu.ben.backend.resource;

import edu.ben.backend.model.dto.ReviewDTO;
import edu.ben.backend.service.ReviewService;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
@RequestMapping(value = "api/review", produces = "application/json")
public class ReviewResource {

    private final ReviewService reviewService;

    public ReviewResource(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping(value="/getAllReviewsForSong/{songId}")
    public List<ReviewDTO> getAllReviewsForSong(@PathVariable Long songId){

        return reviewService.getAllReviewsForSong(songId);
    }
}
