import '../../utils/utils.dart';

class ApiFormatter {
  static ErrorModel format(
    Object error, {
    StackTrace? trace,
    DialogErrorType? errorType,
  }) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      if (error.type == DioExceptionType.badResponse) {
        if (error.response != null && error.response?.data is Map) {
          String message = "Something went wrong";
          try {
            final errorResponse = ErrorResponse.fromJson(error.response?.data);
            message = errorResponse.errorType.replaceAll('-', ' ').capitalize;
          } catch (_) {}
          return ErrorModel(
            message: message,
            type: DialogErrorType.error,
            statusCode: statusCode,
          );
        }
      }
      if (error.type == DioExceptionType.connectionError) {
        return ErrorModel(
          message: 'Check your internet connection',
          type: DialogErrorType.noInternet,
          statusCode: statusCode,
        );
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return ErrorModel(
          message: 'Request took too long',
          type: DialogErrorType.error,
          statusCode: statusCode,
        );
      } else if (error.type == DioExceptionType.cancel) {
        return ErrorModel(
          message: 'Request was cancelled',
          type: DialogErrorType.error,
          statusCode: statusCode,
        );
      } else {
        return ErrorModel(
          message: 'An unexpected error occured',
          type: DialogErrorType.error,
          statusCode: statusCode,
        );
      }
    } else if (error is CustomException) {
      return ErrorModel(
        type: errorType ?? DialogErrorType.error,
        message: error.message,
      );
    }
    return ErrorModel(
      message: 'Something went wrong',
      type: DialogErrorType.error,
    );
  }
}
