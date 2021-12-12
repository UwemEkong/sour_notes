package edu.ben.backend.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class FavoriteExceptionController {
    @ExceptionHandler(value = DuplicateFavoriteException.class)
    public ResponseEntity<Object> exception(DuplicateFavoriteException exception) {
        return new ResponseEntity<>("Cannot duplicate previous favorite", HttpStatus.BAD_REQUEST);
    }
}
