class Quote {
  int ?id;
  String quote, author;
  bool fav,today;

  Quote({
    required this.quote,
    required this.author,
     this.id,
     required this.fav,
     required this.today,
  });
}
