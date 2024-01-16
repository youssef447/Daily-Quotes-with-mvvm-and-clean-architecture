import 'package:dailyquotes/core/utils/apiConstants.dart';
import 'package:dailyquotes/model/services/iReqService.dart';
import 'package:dio/dio.dart';

import 'Network/remote/dio_helper.dart';

class DioReqService implements IReqService {
  @override
  Future<Response<dynamic>> reqTodayService() {
    return DioHelper.getData(
      method: ApiConstants.methodToday,
    );
  }

  @override
  Future<Response> reqWithKeyService({required String keyword}) {
    return DioHelper.getData(
      method: ApiConstants.methodKeyword,
    );
  }
}
