package edu.ben.backend.resource;

import edu.ben.backend.model.dto.UserDTO;
import edu.ben.backend.service.AuthenticationService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "api/auth", produces = "application/json")
public class AuthenticationResource {

    private final AuthenticationService authenticationService;
    public AuthenticationResource(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }


    @GetMapping("/login/{username}/{password}")
    public UserDTO login(@PathVariable String username, @PathVariable String password) {
        return this.authenticationService.login(username, password);
    }

    @PostMapping("/register")
    public void createEmployee(@RequestBody UserDTO userDTO) {
        this.authenticationService.register(userDTO);
    }

    @GetMapping("/getloggedinuser")
    public UserDTO getLoggedInUser() {
        return this.authenticationService.getLoggedInUser();
    }

    @PutMapping("/logout")
    public void logout() {
        this.authenticationService.logout();
    }
}