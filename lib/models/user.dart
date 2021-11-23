import 'dart:convert';

User userJSON(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String userName;
  String password;
  String email;
  String firstName;
  String lastName;
  String type;

  User(
      {required this.id,
      required this.userName,
      required this.password,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.type});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["userName"],
        password: json["password"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "password": password,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "type": type,
      };

  String get username => userName;
  String get Password => password;
  String get Email => email;
  String get firstname => firstName;
  String get lastname => lastName;
}
