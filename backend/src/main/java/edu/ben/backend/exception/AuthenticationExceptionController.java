
package edu.ben.backend.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class AuthenticationExceptionController {
    @ExceptionHandler(value = UserNotFoundException.class)
    public ResponseEntity<Object> exception(UserNotFoundException exception) {
        return new ResponseEntity<>("Incorrect Username",HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(value = IncorrectPasswordException.class)
    public ResponseEntity<Object> exception(IncorrectPasswordException exception) {
        return new ResponseEntity<>("Incorrect Password", HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(value = InvalidPasswordLengthException.class)
    public ResponseEntity<Object> exception(InvalidPasswordLengthException exception) {
        return new ResponseEntity<>("Password must be at least 8 characters long", HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(value = DuplicateUsernameException.class)
    public ResponseEntity<Object> exception(DuplicateUsernameException exception) {
        return new ResponseEntity<>("Duplicate Username", HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(value = SpecialCharacterException.class)
    public ResponseEntity<Object> exception(SpecialCharacterException exception) {
        return new ResponseEntity<>("At least one special character required", HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(value = MissingFieldException.class)
    public ResponseEntity<Object> exception(MissingFieldException exception) {
        return new ResponseEntity<>("All fields must be filled in", HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(value = MissingNumberException.class)
    public ResponseEntity<Object> exception(MissingNumberException exception) {
        return new ResponseEntity<>("At least 1 number is required", HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(value = UpperCaseException.class)
    public ResponseEntity<Object> exception(UpperCaseException exception) {
        return new ResponseEntity<>("AT least 1 uppercase letter is required", HttpStatus.NOT_FOUND);
    }

}