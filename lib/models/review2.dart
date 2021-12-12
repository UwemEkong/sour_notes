class Review2 {
  int id;
  int userId;
  String content;
  int rating;
  int songId;
  int albumId;
  int musicId;
  String musicTitle;
  int favorites;

  Review2(
      {required this.id,
      required this.userId,
      required this.content,
      required this.rating,
      required this.songId,
      required this.albumId,
      required this.musicId,
      required this.musicTitle,
      required this.favorites});

  getNotes() {
    return "🎵" * rating;
  }
}
