import 'package:dio/dio.dart';

class ErrorHandlerInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timeout. Please try again.';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        errorMessage =
            'Received invalid status code: ${err.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request was cancelled.';
        break;
      case DioExceptionType.unknown:
      default:
        errorMessage = 'Something went wrong. Please try again.';
        break;
    }

    if (err.response?.statusCode == 429) {
      errorMessage = 'Too many requests. Please slow down.';
    }

    return handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: errorMessage,
      ),
    );
  }
}
