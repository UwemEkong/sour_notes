import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Music {
  int id;
  String deezerUrl;
  bool isSong;
  String title;
  String artist;
  int rating;
  static String imageUrl = "";
  Music({
    required this.id,
    required this.deezerUrl,
    required this.isSong,
    required this.title,
    required this.artist,
    required this.rating,
  });

  getNotes() {
    return "🎵" * rating;
  }

  Future<String> getCoverArt() async {
    var res = await http.get(Uri.parse(this.deezerUrl));
    var body = res.body;
    // print(body);
    var jsonData = json.decode(body);

// Only albums have covers

// if this is an album, get cover
// else get album, then get cover

    if (!this.isSong) {
      return jsonData["cover"];
    }

    return jsonData["album"]["cover"];
  }

  Future<String> getAudio() async {
    var res = await http.get(Uri.parse(this.deezerUrl));
    var body = res.body;
    var jsonData = json.decode(body);

// Only albums have covers

    return jsonData["preview"];
  }
}
