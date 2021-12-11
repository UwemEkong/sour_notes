package edu.ben.backend.service;

import edu.ben.backend.model.User;
import edu.ben.backend.model.dto.UserDTO;
import edu.ben.backend.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Service
public class AdminService {

    UserRepository userRepository;
    UserDTO editedUser;

    public AdminService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public UserDTO getUser(String username) {
        User userEditing = userRepository.findByUsername(username);
        System.out.println(userEditing);
        return new UserDTO(userEditing.getId(), userEditing.getUsername(), userEditing.getPassword(), userEditing.getEmail(), userEditing.getFirstname(), userEditing.getLastname(), userEditing.getType());
    }

    public void updateDetails(UserDTO userDTO) {
        User editingUser = userRepository.findByUsername(userDTO.getUsername());
        User userUpdated = new User(editingUser.getId(), editingUser.getUsername(), editingUser.getPassword(), userDTO.getEmail(), userDTO.getFirstName(), userDTO.getLastName(), userDTO.getType());
        userRepository.save(userUpdated);
    }
}
