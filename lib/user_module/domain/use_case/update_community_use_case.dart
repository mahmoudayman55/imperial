import 'package:dartz/dartz.dart';
import 'package:imperial/community_module/data/model/community_model.dart';
import 'package:imperial/community_module/data/model/update_community_model.dart';
import 'package:imperial/core/utils/nework_exception.dart';
import 'package:imperial/user_module/domain/repository/baseUserRepository.dart';

import '../../../auth_module/data/models/user_model.dart';
import '../../../auth_module/domain/entities/user_entity.dart';

class UpdateCommunityUseCase{
  BaseUserRepository userRepository;

  UpdateCommunityUseCase(this.userRepository);
  Future<Either<ErrorMessageModel, String>>execute(UpdateCommunityModel communityModel) async {
    return await userRepository.updateUserCommunity(communityModel);

  }
}





