import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart' as i;
import 'package:imperial/core/utils/nework_exception.dart';
import 'package:imperial/user_module/domain/repository/baseUserRepository.dart';

import '../../../auth_module/data/models/user_model.dart';
import '../../../auth_module/domain/entities/user_entity.dart';

class UpdateUserCoverUseCase{
  BaseUserRepository userRepository;

  UpdateUserCoverUseCase(this.userRepository);
  Future<Either<ErrorMessageModel,String>>execute(int id,i.XFile pic) async {
    return await userRepository.updateUserCoverPic(id,pic);

  }
}





