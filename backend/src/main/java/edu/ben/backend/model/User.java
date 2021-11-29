package edu.ben.backend.model;

import lombok.*;

import javax.persistence.*;

@Entity
@Data
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    Long id;
    @Column(name = "username")
    String username;
    @Column(name = "password")
    String password;
    @Column(name = "email")
    String email;
    @Column(name = "firstname")
    String firstname;
    @Column(name = "lastname")
    String lastname;
    @Column(name = "Type")
    String Type;

    public User(String username, String password, String email, String firstname, String lastname, String Type) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.firstname = firstname;
        this.lastname = lastname;
        this.Type = Type;
    }
}