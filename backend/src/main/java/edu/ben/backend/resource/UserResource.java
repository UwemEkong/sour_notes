package edu.ben.backend.resource;


import edu.ben.backend.model.dto.UserDTO;
import edu.ben.backend.service.UserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping(value = "api/users", produces = "application/json")
public class UserResource {

    private final UserService userService;
    public UserResource(UserService userService){
        this.userService = userService;
    }
    @GetMapping(value="/getAllUsers")
    public List<UserDTO> getAllUsers(){

        return userService.getAllUsers();
    }
}
