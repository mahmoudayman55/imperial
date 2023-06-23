import 'package:dartz/dartz.dart';
import 'package:imperial/auth_module/domain/repository/base_auth_repository.dart';

import '../../../core/utils/nework_exception.dart';
import '../../data/models/user_login_model.dart';
import '../entities/user_entity.dart';

class UserLoginUseCase{
  BaseAuthRepository baseAuthRepository;

  UserLoginUseCase(this.baseAuthRepository);
  Future<Either<ErrorMessageModel, String>>execute(UserLoginModel user)async{
    return await baseAuthRepository.userLogin(user);



  }
}