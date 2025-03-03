enum ApiResultType { success, error }

class ApiResult<T> {
  final ApiResultType type;
  final T? data; // Data returned in case of success
  final String? errorMessage;
  const ApiResult._({required this.type, this.data, this.errorMessage});

  factory ApiResult.success({T? data, String? successMessage}) {
    return ApiResult._(type: ApiResultType.success, data: data);
  }

  factory ApiResult.error([String? errorMessage, int? statusCode]) {
    return ApiResult._(type: ApiResultType.error, errorMessage: errorMessage);
  }

  bool get isSuccess => type == ApiResultType.success;

  bool get isError => type == ApiResultType.error;
}
