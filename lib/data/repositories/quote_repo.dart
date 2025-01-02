import 'package:dailyquotes/core/helpers/api_result_helper.dart';
import 'package:dailyquotes/data/models/quote_model.dart';
import 'package:dailyquotes/domain/entity/quote_entity.dart';

import '../../core/services/Network/local/cach_helper.dart';
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

  Future<ApiResult<QuoteEntity>> reqTodayQuote() async {
    try {
      final response = await _remoteService.reqTodayQuoteService();
      final model = QuoteModel.fromRemoteJson(response.data[0]);

      await CacheHelper.saveData(
        key: 'date',
        value: DateTime.now().toString(),
      );

      return ApiResult.success(data: model);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  ///called once when we first put our first stored quote, after calling reqTodayQuote Function

  Future<ApiResult<QuoteEntity>> cacheTodayQuote(QuoteModel model) async {
    try {
      await _localService.cacheTodayQuote(model.toMap());

      return ApiResult.success(data: model);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  ///getting Today's quote from database

  Future<ApiResult<QuoteEntity>> getCachedTodayQuote() async {
    try {
      var map = await _localService.getTodayQuote();

      return ApiResult.success(data: QuoteModel.fromLocalJson(map));
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  ///only updates where id =1 as todays quote is always first row and others are favourites, this method only called when we update fav state and when we get todays quote after a day been passed

  Future<ApiResult<QuoteEntity>> updateTodayQuote(QuoteEntity model) async {
    try {
      final quoteModel = QuoteModel.fromEntity(model);
      await _localService.updateTodayQuote(quoteModel.toMap());

      return ApiResult.success(data: model);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<List<QuoteEntity>>> getFavQuotes() async {
    try {
      var list = await _localService.getFavQuotes();

      final res = list.map((e) => QuoteModel.fromLocalJson(e)).toList();

      return ApiResult.success(data: res);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult> removeFromFav(String quoteText) async {
    try {
      await _localService.removeFromFav(quoteText);
      return ApiResult.success();
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult> addFavQuote(QuoteEntity model) async {
    try {
      final quoteModel = QuoteModel.fromEntity(model);
      await _localService.addFavQuote(quoteModel.toMap());
      return ApiResult.success();
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<QuoteEntity>> getRandomQuote() async {
    try {
      var map = await _remoteService.reqRandomQuoteService();

      return ApiResult.success(data: QuoteModel.fromRemoteJson(map.data[0]));
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult> addMyQuote(QuoteEntity model) async {
    final quoteModel = QuoteModel.fromEntity(model);
    try {
      await _localService.addMyQuotesPageService(quoteModel.toMap());
      return ApiResult.success();
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<List<QuoteEntity>>> getMyQuotesPage() async {
    try {
      var list = await _localService.geMyQuotesPage();

      final res = list.map((e) => QuoteModel.fromLocalJson(e)).toList();
      return ApiResult.success(data: res);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult> deleteMyQuote(int id) async {
    try {
      await _localService.deleteMyQuotesPageService(id);

      return ApiResult.success();
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult> updateMyQuote(QuoteEntity model) async {
    final quoteModel = QuoteModel.fromEntity(model);
    try {
      await _localService.updateMyQuotesPageService(quoteModel.toMap());

      return ApiResult.success();
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

//-------- Not Used Yet ----------
  Future<ApiResult<List<QuoteEntity>>> reqWithKeyRepo(
      {required String keyword}) async {
    try {
      final List<QuoteEntity> list = [];
      final response =
          await _remoteService.reqWithKeyQuoteService(keyword: keyword);
      (response.data as List).map(
        (e) => list.add(QuoteModel.fromRemoteJson(e)),
      );

      return ApiResult.success(data: list);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }
}
