import 'dart:convert';

import 'package:dailyquotes/model/Entities/quote.dart';
import 'package:dailyquotes/model/Models/quoteModel.dart';
import 'package:dailyquotes/model/repositories/iReqRepo.dart';
import 'package:dailyquotes/model/services/Network/local/IlocalService.dart';
import 'package:dailyquotes/model/services/Network/local/cach_helper.dart';
import 'package:dailyquotes/model/services/iReqService.dart';

class ApiReqRepo implements IReqRepo {
  late final IReqService _remoteService;
  late final ILocalService _localService;
  ApiReqRepo({
    required IReqService remoteService,
    required ILocalService localService,
  }) {
    _remoteService = remoteService;
    _localService = localService;
  }

  @override
  Future<QuoteModel> reqTodayRepo() async {
    final response = await _remoteService.reqTodayService();
    final model = QuoteModel.fromJson(response.data[0]);
    CacheHelper.saveData(
      key: 'today',
      value: json.encode(model.toMap()),
    );
    CacheHelper.saveData(
      key: 'date',
      value: DateTime.now().toString(),
    );
    return model;
  }

  @override
  Future<List<Quote>> getFavFromTable() async {
    var list = await _localService.getQuotes();

    final res = list.map((e) => QuoteModel.fromJson(e)).toList();
    return res;
  }

  @override
  Future<List<Quote>> reqWithKeyRepo({required String keyword}) async {
    final List<Quote> list = [];
    final response = await _remoteService.reqWithKeyService(keyword: keyword);
    (response.data as List).map(
      (e) => list.add(QuoteModel.fromJson(e)),
    );

    return list;
  }

  @override
  Future<void> addFavToTable({required QuoteModel model}) async {
    await _localService.addQuote(
      model.toMap(),
    );
  }
}
