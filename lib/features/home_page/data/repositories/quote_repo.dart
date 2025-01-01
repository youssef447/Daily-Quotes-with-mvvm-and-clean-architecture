import 'package:dailyquotes/features/home_page/data/models/quoteModel.dart';

import '../../../../core/services/Network/local/cach_helper.dart';
import '../data_sources/quote_local_service.dart';
import '../data_sources/quote_remote_service.dart';

class QuoteRepo {
  late final QuoteRemoteService _remoteService;
  late final QuoteLocalService _localService;
  QuoteRepo({
    required QuoteRemoteService remoteService,
    required QuoteLocalService localService,
  }) {
    _remoteService = remoteService;
    _localService = localService;
  }

  ///first scenario, get quote from Api then add  it to local Database

  Future<QuoteModel> reqTodayQuote() async {
    final response = await _remoteService.reqTodayQuoteService();
    final model = QuoteModel.fromRemoteJson(response.data[0]);

    await CacheHelper.saveData(
      key: 'date',
      value: DateTime.now().toString(),
    );
    return model;
  }

  ///called once when we first put our first stored quote, after calling reqTodayQuote Function

  Future<QuoteModel> addTodayQuote(QuoteModel model) async {
    await _localService.addTodayQuote(model.toMap());
    return model;
  }

  ///getting Today's quote from database

  Future<QuoteModel> getTodayQuote() async {
    var map = await _localService.getTodayQuote();

    return QuoteModel.fromLocalJson(map);
  }

  ///only updates where id =1 as todays quote is always first row and others are favourites, this method only called when we update fav state and when we get todays quote after a day been passed

  Future<QuoteModel> updateTodayQuote(QuoteModel model) async {
    await _localService.updateTodayQuote(model.toMap());

    return model;
  }

  Future<List<QuoteModel>> getFavQuotes() async {
    var list = await _localService.getFavQuotes();

    final res = list.map((e) => QuoteModel.fromLocalJson(e)).toList();
    return res;
  }

  Future<void> removeFromFav(String quoteText) async {
    await _localService.removeFromFav(quoteText);
  }

  Future<void> addFavQuote(QuoteModel model) async {
    await _localService.addFavQuote(model.toMap());
  }

  Future<QuoteModel> getRandomQuote() async {
    var map = await _remoteService.reqRandomQuoteService();

    return QuoteModel.fromRemoteJson(map.data[0]);
  }

  Future<void> addMyQuote(QuoteModel model) async {
    await _localService.addMyQuoteService(model.toMap());
  }

  Future<List<QuoteModel>> getMyQuotes() async {
    var list = await _localService.geMyQuotes();

    final res = list.map((e) => QuoteModel.fromLocalJson(e)).toList();
    return res;
  }

  Future<void> deleteMyQuote(int id) async {
    await _localService.deleteMyQuoteService(id);
  }

  Future<void> updateMyQuote(QuoteModel model) async {
    await _localService.updateMyQuoteService(model.toMap());
  }

//-------- Not Used Yet ----------
  Future<List<QuoteModel>> reqWithKeyRepo({required String keyword}) async {
    final List<QuoteModel> list = [];
    final response =
        await _remoteService.reqWithKeyQuoteService(keyword: keyword);
    (response.data as List).map(
      (e) => list.add(QuoteModel.fromRemoteJson(e)),
    );

    return list;
  }
}
