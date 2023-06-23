import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart' as i;

import '../../../auth_module/data/models/user_model.dart';
import '../../../auth_module/domain/entities/user_entity.dart';
import '../../../community_module/data/model/community_model.dart';
import '../../../community_module/data/model/update_community_model.dart';
import '../../../core/utils/nework_exception.dart';

abstract class BaseUserRepository{
Future<Either<ErrorMessageModel,String>> updateUser(UserModel user);
Future<Either<ErrorMessageModel,String>> updateUserProfilePic(int id,i.XFile pic);
Future<Either<ErrorMessageModel,String>> updateUserCoverPic(int id,i.XFile pic);
Future<Either<ErrorMessageModel,String>> updateCommunityCoverPic(int id,i.XFile pic);
Future<Either<ErrorMessageModel,String>> updateUserCommunity(UpdateCommunityModel community);

}