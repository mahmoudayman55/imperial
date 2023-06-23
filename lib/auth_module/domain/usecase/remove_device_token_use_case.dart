import 'package:dartz/dartz.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../repository/base_auth_repository.dart';

class RemoveDeviceTokenUseCase{
  BaseAuthRepository authRepository;

  RemoveDeviceTokenUseCase(this.authRepository);
Future<Either<ErrorMessageModel, String>>  execute(int userId) async {
    return await authRepository.removeDeviceToken(userId);



  }
}