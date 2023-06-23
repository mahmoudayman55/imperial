import 'package:dartz/dartz.dart';
import 'package:imperial/auth_module/domain/entities/register_request.dart';
import 'package:imperial/auth_module/domain/repository/base_auth_repository.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../entities/user_entity.dart';

class UpdateUserTokenUseCase{
  BaseAuthRepository  baseAuthRepository;

  UpdateUserTokenUseCase(this.baseAuthRepository);


  Future<Either<ErrorMessageModel, String>>execute(int id)async{
    return await baseAuthRepository.updateUserToken(id);



  }
}