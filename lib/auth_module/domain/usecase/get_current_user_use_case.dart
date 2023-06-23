import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../repository/base_auth_repository.dart';

class GetCurrentUserUseCase {
  BaseAuthRepository authRepository;

  GetCurrentUserUseCase(this.authRepository);
  Future <Either<Exception,User>> execute() async {
    return await authRepository.getCurrentUser();



  }
}