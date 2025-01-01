class QuoteModel {
  int? id;
  String quote, author;
  bool fav;

  QuoteModel({
    required this.quote,
    required this.author,
    this.id,
    this.fav = false,
  });

  factory QuoteModel.fromRemoteJson(Map<dynamic, dynamic> json) {
    return QuoteModel(
      quote: json['q'],
      author: json['a'],
    );
  }
  factory QuoteModel.fromLocalJson(Map<dynamic, dynamic> json) {
    return QuoteModel(
      quote: json['q'],
      author: json['a'],
      id: json['id'],
      fav: json['fav'] == 1 ? true : false,
    );
  }

  //for storing in sqflite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'q': quote,
      'a': author,
      'fav': fav == false ? 0 : 1,
    };
  }
}
