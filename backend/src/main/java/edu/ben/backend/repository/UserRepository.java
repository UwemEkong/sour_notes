package edu.ben.backend.repository;

import edu.ben.backend.model.User;
import edu.ben.backend.model.dto.UserDTO;
import org.springframework.stereotype.Component;

import java.util.HashMap;

@Component
public class UserRepository {
    public HashMap<String, User> userTable;

    public UserRepository() {
        populateUserTable();

    }

    private void populateUserTable() {
        userTable = new HashMap();
        userTable.put("uwem123", new User(1, "uwem123", "Uwem123!", "uweme6@gmail.com", "Uwem", "Ekong", "member"));
    }

    public User findByUsername(String username) {
        return userTable.get(username);
    }

    public void createUser(UserDTO userDTO) {
        userTable.put(userDTO.getUsername(), new User(generateId(), userDTO.getUsername(), userDTO.getPassword(), userDTO.getEmail(), userDTO.getFirstName(), userDTO.getLastName(), "member"));
    }

    public long generateId() {
        long largest = 0;

        for (User user: userTable.values()) {
            if (user.getId() > largest) {
                largest = user.getId();
            }
        }
        return largest + 1;
    }
}