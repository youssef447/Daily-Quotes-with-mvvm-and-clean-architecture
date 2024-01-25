import 'package:dio/dio.dart';

abstract class IRemoteService {
  Future<Response<dynamic>> reqTodayQuoteService();
  Future<Response<dynamic>> reqRandomQuoteService();

  Future<Response<dynamic>> reqWithKeyQuoteService({required String keyword});
}
