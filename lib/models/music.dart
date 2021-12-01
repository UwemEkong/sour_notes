class Music {
  int id;
  String deezerUrl;
  bool isSong;
  String title;
  String artist;
  int rating;

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
}
