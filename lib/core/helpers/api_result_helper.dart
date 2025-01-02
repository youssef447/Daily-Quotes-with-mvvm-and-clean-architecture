// Define an enum to represent the API result type
enum ApiResultType { success, error }

// Define a class to encapsulate the API result
class ApiResult<T> {
  final ApiResultType type; // Type of result: success or error
  final T? data; // Data returned in case of success
  final String? errorMessage; // Error message in case of failure

  // Private constructor
  const ApiResult._({required this.type, this.data, this.errorMessage});

  // Factory for success
  factory ApiResult.success({T? data, String? successMessage}) {
    return ApiResult._(type: ApiResultType.success, data: data);
  }

  // Factory for error
  factory ApiResult.error(String errorMessage) {
    return ApiResult._(type: ApiResultType.error, errorMessage: errorMessage);
  }

  // Check if the result is success
  bool get isSuccess => type == ApiResultType.success;

  // Check if the result is error
  bool get isError => type == ApiResultType.error;
}
