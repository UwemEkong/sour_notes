class Review {
  int id;
  int userId;
  String content;
  int rating;
  int musicId;
  int favorites;

  Review(
      {required this.id,
      required this.userId,
      required this.content,
      required this.rating,
      required this.musicId,
      required this.favorites});

  getNotes() {
    return "🎵" * rating;
  }
}
