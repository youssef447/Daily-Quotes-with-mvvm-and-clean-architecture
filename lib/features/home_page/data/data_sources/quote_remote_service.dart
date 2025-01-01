import 'package:dailyquotes/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

import '../../../../core/services/Network/remote/dio_helper.dart';

class QuoteRemoteService {
  Future<Response<dynamic>> reqTodayQuoteService() async {
    return await DioHelper.getData(
      method: ApiConstants.methodToday,
    );
  }

  Future<Response> reqWithKeyQuoteService({required String keyword}) async {
    return await DioHelper.getData(
      method: '${ApiConstants.methodKeyword}$keyword',
    );
  }

  Future<Response> reqRandomQuoteService() async {
    return await DioHelper.getData(
      method: ApiConstants.methodRandom,
    );
  }
}
