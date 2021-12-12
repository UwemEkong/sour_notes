package edu.ben.backend.service;

import edu.ben.backend.model.User;
import edu.ben.backend.model.dto.UserDTO;
import edu.ben.backend.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {
    UserRepository userRepository;

    public UserService(UserRepository userRepository){
        this.userRepository = userRepository;
    }

    public List<UserDTO> getAllUsers() {
        List<User> userResults = userRepository.findAll();
        List<UserDTO> userDTOList = new ArrayList<>();

        for (User user: userResults) {
            userDTOList.add(new UserDTO(user.getId(), user.getUsername(), user.getPassword(), user.getFirstname(), user.getLastname(), user.getEmail(), user.getType()));
        }
        return userDTOList;

    }
}
