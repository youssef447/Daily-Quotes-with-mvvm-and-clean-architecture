import 'package:dailyquotes/core/services/Network/remote/error_handler_interceptor.dart';
import 'package:dailyquotes/core/services/Network/remote/rate_limit_interceptor.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late final Dio dio;
  static init({required String baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        //  validateStatus: (_) => true,
      ),
    )..interceptors
        .addAll([ErrorHandlerInterceptor(), RateLimitingInterceptor()]);
  }

  static Future<Response> getData({
    required String method,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
      'Connection': 'keep-alive',
    };
    return await dio.get(method, queryParameters: query);
  }

  static Future<Response> postData({
    required String method,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
      'Connection': 'keep-alive'
    };

    return await dio.post(
      method,
      queryParameters: query,
      data: data,
    );
  }
}
