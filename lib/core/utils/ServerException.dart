import 'package:imperial/core/utils/nework_exception.dart';

class ServerException implements Exception{
  final ErrorMessageModel errorMessageModel;

  ServerException(this.errorMessageModel);
}