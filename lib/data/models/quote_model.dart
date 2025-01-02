import 'package:dailyquotes/domain/entity/quote_entity.dart';

class QuoteModel extends QuoteEntity {
  QuoteModel({
    required super.quote,
    required super.author,
    super.id,
    super.fav,
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

  factory QuoteModel.fromEntity(QuoteEntity entity) {
    return QuoteModel(
      quote: entity.quote,
      author: entity.author,
      id: entity.id,
      fav: entity.fav,
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
