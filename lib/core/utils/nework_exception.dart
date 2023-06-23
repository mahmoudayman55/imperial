import 'app_constants.dart';

class ErrorMessageModel   {
  final String? type;
  final String? message;
  final String? fixIt;
  final int? statusCode;
  final Map<String, dynamic>? error;

  ErrorMessageModel({
    this.type,
    this.message,
    this.fixIt,
    this.statusCode,
    this.error,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      type: json[AppConstants.errorTypeKey],
      message: json[AppConstants.errorMessageKey],
      fixIt: json[AppConstants.errorFixItKey],
      statusCode: json[AppConstants.errorStatusCodeKey] ?? 0,
      error: json[AppConstants.errorKey],
    );
  }

  @override
  String toString() {
    return 'NetworkException: {type: $type, message: $message, fixIt: $fixIt, statusCode: $statusCode, error: $error}';
  }
}