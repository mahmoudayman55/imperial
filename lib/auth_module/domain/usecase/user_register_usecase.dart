import 'package:dartz/dartz.dart';
import 'package:imperial/auth_module/domain/repository/base_auth_repository.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../entities/user_entity.dart';

class UserRegisterUseCase{
  BaseAuthRepository  baseAuthRepository;

  UserRegisterUseCase(this.baseAuthRepository);


  Future<Either<ErrorMessageModel, User>>execute(User user)async{
    return await baseAuthRepository.userRegister(user);



  }
}