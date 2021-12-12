package edu.ben.backend.resource;

import edu.ben.backend.model.dto.UserDTO;
import edu.ben.backend.service.AdminService;
import edu.ben.backend.service.AuthenticationService;
import org.springframework.boot.autoconfigure.kafka.KafkaProperties;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "api/admin", produces = "application/json")
public class AdminResource {

    private final AdminService adminService;
    public AdminResource(AdminService adminService) {
        this.adminService = adminService;
    }

    @GetMapping("/getUser/{username}")
    public void getUser(@PathVariable String username) {
        this.adminService.getUser(username);
    }

    @PostMapping("/updateDetails")
    public void updateEmployeeDetails(@RequestBody UserDTO userDTO) {
        this.adminService.updateDetails(userDTO);
    }
}
