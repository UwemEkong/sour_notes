import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Review {
  int id;
  int userId;
  String content;
  int rating;
  int musicId;
  int favorites;

  bool hasDeleted;

  Review(
      {required this.id,
      required this.userId,
      required this.content,
      required this.rating,
      required this.musicId,
      required this.favorites,
      this.hasDeleted = false});

  getNotes() {
    return "🎵" * rating;
  }

  String getURlForSingleReview(int reviewId) {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/review/getReview/$reviewId';
    } else {
      return 'http://localhost:8080/api/review/getReview/$reviewId';
    }
  }

  Future<bool> checkHasDeleted(reviewId) async {
    String url = getURlForSingleReview(reviewId);
    var res = await http.get(Uri.parse(url));
    var body = res.body;
    var jsonData = json.decode(body);
    if (body == "") {
      hasDeleted = true;
      return true;
    } else {
      hasDeleted = false;
      return false;
    }
  }
}
