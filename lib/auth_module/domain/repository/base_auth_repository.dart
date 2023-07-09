import 'package:dartz/dartz.dart';
import 'package:imperial/auth_module/data/models/user_join_request_model.dart';
import 'package:imperial/auth_module/data/models/user_login_model.dart';
import 'package:imperial/auth_module/domain/entities/notification.dart';
import 'package:imperial/auth_module/domain/entities/register_request.dart';
import 'package:imperial/auth_module/domain/entities/user_entity.dart';
import 'package:imperial/community_module/data/model/community_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../../data/models/user_ticket_model.dart';

abstract class BaseAuthRepository {
  Future<Either<ErrorMessageModel, User>> userRegister(User user);
  Future<Either<ErrorMessageModel, String>> userLogin(UserLoginModel user);
  saveUserToken(String userToken);
  Future userLogout();
  Future<Either<Exception, User>> getCurrentUser();
  Future<Either<ErrorMessageModel, User>> getUserById(int id);
  Future<Either<ErrorMessageModel, String>> sendServiceRegistrationRequest(
      RegistrationRequest registrationRequest);
  Future<Either<ErrorMessageModel, String>> sendCommunityRegistrationRequest(
      RegistrationRequest registrationRequest);
  Future<Either<ErrorMessageModel, List<UserJoinRequest>>> getUserJoinRequests(
      int id);
  Future<Either<ErrorMessageModel, List<UserTicketModel>>>
      getUserTicketRequests(int id);
  Future<Either<ErrorMessageModel, String>> updateUserToken(int id);
  Future<Either<ErrorMessageModel, String>> sendNotification(
      AppNotification notification);
  Future<Either<ErrorMessageModel,String>> getResetPasswordCode(String email);
  Future<Either<ErrorMessageModel,String>> removeDeviceToken(int userId);
  Future<Either<ErrorMessageModel, String>> changePassword(
      {required String email,required String password});
  Future<Either<ErrorMessageModel, String>> changeCurrentPassword(
      {required String email,required String newPassword,required String currentPassword});
}
