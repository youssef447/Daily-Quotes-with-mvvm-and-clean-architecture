import 'package:dailyquotes/model/Models/quoteModel.dart';

import '../Entities/quote.dart';

abstract class IReqRepo {
  Future<QuoteModel> reqTodayQuote();
  Future<QuoteModel> updateTodayQuote(QuoteModel model);
  Future<QuoteModel> getTodayQuote();
  Future<QuoteModel> addTodayQuote(QuoteModel model);

  Future<void> addFavQuote(QuoteModel model);
  Future<List<QuoteModel>> getFavQuotes();
  Future<void> removeFromFav(String quoteText);

  Future<List<Quote>> reqWithKeyRepo({required String keyword});

  Future<QuoteModel> getRandomQuote();

    Future<void> addMyQuote(QuoteModel model);
       Future<List<QuoteModel>> getMyQuotes();
       
  Future<void> updateMyQuote(QuoteModel model);
  Future<void> deleteMyQuote(int id);

}
