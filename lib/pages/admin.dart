import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sour_notes/models/loginmessage.dart';
import 'package:sour_notes/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class adminPage extends StatefulWidget {
  @override
  _adminPageState createState() => _adminPageState();
}

getUrlForUsersForDevice() {
  if (Platform.isAndroid) {
    return 'http://10.0.2.2:8080/api/users/';
  } else {
    return 'http://localhost:8080/api/users/';
  }
}

Future<List<User>> getAllUsers() async {
  String url = getUrlForUsersForDevice() + "getAllUsers";
  var res = await http.get(Uri.parse(url));
  var body = res.body;
  print(body);
  var jsonData = json.decode(body);

  List<User> UserList = [];

  for (var s in jsonData) {
    User user = User(
        id: s["id"],
        userName: s["username"],
        password: s["password"],
        firstName: s["firstName"],
        lastName: s["lastName"],
        email: s["email"],
        type: s["type"]);
    UserList.add(user);
  }

  return UserList;
}

class _adminPageState extends State<adminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF303030),
      appBar: AppBar(
        title: Text('Admin', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF303030),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
              future: getAllUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //For reload on button click
                if (snapshot.connectionState == ConnectionState.done) {
                  // If JSON data has not arrived yet show loading
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading..."),
                      ),
                    );
                  } else {
                    //Once the JSON Data has arrived build the list
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          //List tile / User row
                          return ListTile(
                            tileColor: Colors.white,
                            title: Text(snapshot.data[index].userName,
                                style: TextStyle(
                                    fontFamily: "Trajan Pro",
                                    height: 1.0,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF303030))),
                            subtitle: Text(
                                snapshot.data[index].email +
                                    ' ' +
                                    snapshot.data[index].firstName,
                                style: TextStyle(
                                    fontFamily: "Trajan Pro",
                                    height: 1.0,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF303030))),
                            trailing: Text(snapshot.data[index].lastName),
                            onTap: () {
                              //When user clicks the row/tile they go to the song's detail page
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          (snapshot.data[index])));
                            },
                          );
                        });
                  }
                } else {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                }
              })),
    );
  }
}
