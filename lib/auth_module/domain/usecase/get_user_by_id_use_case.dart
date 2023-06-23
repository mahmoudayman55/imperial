import 'package:dartz/dartz.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../entities/user_entity.dart';
import '../repository/base_auth_repository.dart';

class GetUserByIdUseCase{
  BaseAuthRepository authRepository;

  GetUserByIdUseCase(this.authRepository);
  Future<Either<ErrorMessageModel, User>> execute(int id) async {
    return await authRepository.getUserById(id);



  }
}