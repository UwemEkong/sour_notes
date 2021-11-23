package edu.ben.backend.model;

import lombok.*;

@Data
@ToString
@EqualsAndHashCode
@AllArgsConstructor
public class User {
    long id;
    String username;
    String password;
    String email;
    String firstName;
    String lastName;
    String Type;
}