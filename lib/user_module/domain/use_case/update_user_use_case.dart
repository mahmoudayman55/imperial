import 'package:dartz/dartz.dart';
import 'package:imperial/core/utils/nework_exception.dart';
import 'package:imperial/user_module/domain/repository/baseUserRepository.dart';

import '../../../auth_module/data/models/user_model.dart';
import '../../../auth_module/domain/entities/user_entity.dart';

class UpdateUserUseCase{
  BaseUserRepository userRepository;

  UpdateUserUseCase(this.userRepository);
  Future<Either<ErrorMessageModel, String>>execute(UserModel user) async {
    return await userRepository.updateUser(user);

  }
}





