import 'package:dailyquotes/model/Entities/quote.dart';

class QuoteModel  extends Quote{
 
  QuoteModel({
    required super.quote,
    required super.id,
    required super.author,
  });

  factory QuoteModel.fromJson(Map<dynamic, dynamic> json) {
    return QuoteModel(quote: json['q'], author: json['a'],id:json['id']);
  }

  Map<String, String> toMap() {
    return {
      'q': quote,
      'a': author,
    };
  }
}
