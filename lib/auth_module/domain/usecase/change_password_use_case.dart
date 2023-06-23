import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart' as i;
import 'package:imperial/auth_module/data/remote_data_source/auth_remote_data_source.dart';
import 'package:imperial/auth_module/domain/repository/base_auth_repository.dart';
import 'package:imperial/core/utils/nework_exception.dart';
import 'package:imperial/user_module/domain/repository/baseUserRepository.dart';

import '../../data/models/user_model.dart';
import '../entities/user_entity.dart';

class ChangePasswordUseCase{
  BaseAuthRepository authRepository;

  ChangePasswordUseCase(this.authRepository);
  Future<Either<ErrorMessageModel,String>>execute(
      {required String email, required String newPassword}) async {
    return await authRepository.changePassword(email: email,password: newPassword);

  }
}





