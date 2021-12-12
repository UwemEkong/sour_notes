import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import '../models/review2.dart';

class UserReviewsPage extends StatefulWidget {
  final int? userId;
  UserReviewsPage(this.userId);

  @override
  State<UserReviewsPage> createState() => _UserReviewsPageState();
}

class _UserReviewsPageState extends State<UserReviewsPage> {
  getUrlForReviewsForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/';
    } else {
      return 'http://localhost:8080/';
    }
  }

  Future<List<Review2>> _getAllReviews() async {
    String url = getUrlForReviewsForDevice() +
        "api/review/getAllReviewsforUser/" +
        "${widget.userId}/";

    var res = await http.get(Uri.parse(url));
    var body = res.body;
    var jsonData = json.decode(body);
    List<Review2> reviews = [];

    for (var s in jsonData) {
      // get title of music that is reviewed
      int musicId = s["musicId"];
      String url =
          getUrlForReviewsForDevice() + "api/music/getMusicById/" + "$musicId/";
      var res = await http.get(Uri.parse(url));
      var body = res.body;
      String musicTitle = json.decode(body)['title'];

      // get the review
      Review2 review = Review2(
          id: s["id"],
          userId: s["userId"],
          content: s["content"],
          rating: s["rating"],
          songId: (s["songId"] == null ? (-1) : s["songId"]),
          albumId: (s["albumId"] == null ? (-1) : s["albumId"]),
          musicId: s["musicId"],
          musicTitle: musicTitle,
          favorites: s["favorites"]);

      reviews.add(review);
    }
    return reviews;
  }

  bool admin = false;
  var reviewId = 0;

  checkUser() async {
    var url = Platform.isAndroid
        ? 'http://10.0.2.2:8080/api/auth/getloggedinuser'
        : 'http://localhost:8080/api/auth/getloggedinuser';
    var res = await http.get(Uri.parse(url));
    var body = res.body;
    if (body.length > 1) {
      if (json.decode(body)["username"] == "admin") {
        admin = true;
      }
      return admin;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkUser();
    return Scaffold(
      backgroundColor: Color(0xFF303030),
      appBar: AppBar(
        title: Text("My Reviews"),
        backgroundColor: Color(0xFF303030),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(20),
                  child: Column(children: [
                    RichText(
                        text: TextSpan(
                            text: "Reviews",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black,
                            ))),
                    FutureBuilder(
                        future: _getAllReviews(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                                  //List tile / Song row
                                  return ListTile(
                                    title: Text(snapshot.data[index].musicTitle),
                                    subtitle: Text(
                                        '${snapshot.data[index].content}'),
                                    trailing:
                                        Wrap(spacing: 5, children: <Widget>[
                                      Text(snapshot.data[index].getNotes()),
                                      if (admin)
                                        IconButton(
                                            icon: new Icon(Icons.cancel),
                                            onPressed: () {
                                              reviewId =
                                                  snapshot.data[index].id;
                                              deleteReview();
                                              debugPrint('ready to delete');
                                              ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    //List tile / Song row
                                                    return ListTile(
                                                        title: Text(''),
                                                        subtitle: Text(''),
                                                        trailing: Text(''));
                                                  });
                                            })
                                    ]),
                                  );
                                });
                          }
                        })
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  void deleteReview() async {
    final response = await http.post(
        Uri.parse(getUrlForReviewsForDevice() + "deleteReview/${reviewId}"));
    if (response.statusCode == 200) {
      setState(() {});
    }
  }
}

// }
