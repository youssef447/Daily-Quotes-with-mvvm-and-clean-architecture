import 'package:dio/dio.dart';

class RateLimitingInterceptor extends Interceptor {
  final int maxRequests = 5;
  final Duration timeFrame = Duration(seconds: 15);
  final List<DateTime> requestTimes = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final now = DateTime.now();
    requestTimes.add(now);

    // remove old requests from list.
    requestTimes.removeWhere(
      (time) => now.difference(time) > timeFrame,
    );

    if (requestTimes.length > maxRequests) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Too many requests. Please try again later.',
        ),
      );
      return;
    }
    handler.next(options);
  }
}
