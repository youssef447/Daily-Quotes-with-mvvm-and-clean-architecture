import 'package:dio/dio.dart';

abstract class IReqService {
  Future<Response<dynamic>> reqTodayService();
    Future<Response<dynamic>> reqWithKeyService({required String keyword});

}
