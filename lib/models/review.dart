class Review {
  int id;
  int userId;
  String content;
  int rating;
  int songId;
  int albumId;
  int favorites;

  Review(
      {required this.id,
      required this.userId,
      required this.content,
      required this.rating,
      required this.songId,
      required this.albumId,
      required this.favorites});

  getNotes() {
    return "🎵" * rating;
  }
}
