import 'package:cross_file/src/types/interface.dart';
import 'package:dartz/dartz.dart';
import 'package:imperial/auth_module/data/models/user_model.dart';
import 'package:imperial/auth_module/domain/entities/user_entity.dart';
import 'package:imperial/community_module/data/model/community_model.dart';
import 'package:imperial/user_module/data/data_source/user_remote_data_source.dart';
import 'package:imperial/user_module/domain/repository/baseUserRepository.dart';
import 'package:image_picker/image_picker.dart' as i;
import '../../../community_module/data/model/update_community_model.dart';
import '../../../core/utils/ServerException.dart';
import '../../../core/utils/nework_exception.dart';

class UserRepository extends BaseUserRepository {
  BaseUserRemoteDataSource userRemoteDataSource;

  UserRepository(this.userRemoteDataSource);

  @override
  Future<Either<ErrorMessageModel, String>> updateUser(UserModel user) async {
    try {
      final result = await userRemoteDataSource.updateUser(user);

      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> updateUserProfilePic(
      int id, i.XFile pic) async {
    try {
      final result = await userRemoteDataSource.updateUserProfilePic(id, pic);

      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> updateUserCoverPic(
      int id, i.XFile pic) async {
    try {
      final result = await userRemoteDataSource.updateUserCoverPic(id, pic);

      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> updateUserCommunity(
      UpdateCommunityModel community) async {
    try {
      final result = await userRemoteDataSource.updateUserCommunity(community);

      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> updateCommunityCoverPic(
      int id, i.XFile pic) async {
    try {
      final result =
          await userRemoteDataSource.updateCommunityCoverPic(id, pic);

      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

}
