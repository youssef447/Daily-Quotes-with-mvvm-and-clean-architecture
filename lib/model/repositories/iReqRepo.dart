import 'package:dailyquotes/model/Models/quoteModel.dart';

import '../Entities/quote.dart';

abstract class IReqRepo {
  Future<QuoteModel> reqTodayRepo();
  Future<void> addFavToTable({required QuoteModel model});

  Future<List<Quote>> getFavFromTable();
  Future<List<Quote>> reqWithKeyRepo({required String keyword});
}
