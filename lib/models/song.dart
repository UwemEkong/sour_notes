class Song {
  int id;
  String deezerUrl;
  String title;
  String artist;
  int rating;

  Song({
    required this.id,
    required this.deezerUrl,
    required this.title,
    required this.artist,
    required this.rating,
  });

  getNotes() {
    return "🎵" * rating;
  }
}
