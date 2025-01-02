class QuoteEntity {
  int? id;
  String quote, author;
  bool fav;

  QuoteEntity({
    required this.quote,
    required this.author,
    this.id,
    this.fav = false,
  });

  toggleFav([bool? fav]) {
    this.fav = fav ?? !this.fav;
  }

  bool get isFav => fav;
}
