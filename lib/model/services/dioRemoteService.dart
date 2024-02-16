import 'package:dailyquotes/core/utils/apiConstants.dart';
import 'package:dailyquotes/model/services/iRemoteService.dart';
import 'package:dio/dio.dart';

import 'Network/remote/dio_helper.dart';

class DioRemoteService implements IRemoteService {
  @override
  Future<Response<dynamic>> reqTodayQuoteService() async {
    return await DioHelper.getData(
      method: ApiConstants.methodToday,
    );
  }

  @override
  Future<Response> reqWithKeyQuoteService({required String keyword}) async {
    return await DioHelper.getData(
      method: '${ApiConstants.methodKeyword}$keyword',
    );
  }

  @override
  Future<Response> reqRandomQuoteService() async {
    return await DioHelper.getData(
      method: ApiConstants.methodRandom,
    );
  }
}
