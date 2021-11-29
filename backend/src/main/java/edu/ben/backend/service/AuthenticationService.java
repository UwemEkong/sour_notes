package edu.ben.backend.service;
import edu.ben.backend.exception.*;
import edu.ben.backend.model.User;
import edu.ben.backend.model.dto.UserDTO;
import edu.ben.backend.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class AuthenticationService {

    UserRepository userRepository;
    UserDTO loggedInUser;

    public AuthenticationService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public UserDTO login(String username, String password) {
        User user = userRepository.findByUsername(username);
        if (user == null) {
            throw new UserNotFoundException();
        } else if (!user.getPassword().equals(password)) {
            throw new IncorrectPasswordException();
        } else {
            loggedInUser = new UserDTO(user.getId(), user.getUsername(), user.getPassword(), user.getEmail(), user.getFirstname(), user.getLastname(), user.getType());
            System.out.println("Get logged1 = " + loggedInUser);
            return new UserDTO(user.getId(), user.getUsername(), user.getPassword(), user.getEmail(), user.getFirstname(), user.getLastname(), user.getType());
        }
    }

    public void register(UserDTO userDTO) {
        User existingUser = userRepository.findByUsername(userDTO.getUsername());

        if (existingUser != null) {
            throw new DuplicateUsernameException();
        } else if (userDTO.getPassword().length() < 8) {
            throw new InvalidPasswordLengthException();
        } else if (!containsSpecialChar(userDTO.getPassword())) {
            throw new SpecialCharacterException();
        } else if (missingField(userDTO)) {
            throw new MissingFieldException();
        } else {
            System.out.println(userDTO);
            userRepository.save(new User(userDTO.getUsername(), userDTO.getPassword(), userDTO.getEmail(), userDTO.getFirstName(), userDTO.getLastName(), userDTO.getType()));
        }
    }

    private boolean missingField(UserDTO userDTO) {
        if (userDTO.getUsername().equals("") || userDTO.getEmail().equals("") || userDTO.getFirstName().equals("") || userDTO.getLastName().equals("") || userDTO.getPassword().equals("")) {
            return true;
        }
        return false;
    }

    private boolean containsSpecialChar(String password) {
        Pattern p = Pattern.compile("[^a-z0-9 ]", Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(password);
        return m.find();
    }

    public UserDTO getLoggedInUser() {
        return loggedInUser;
    }
}
