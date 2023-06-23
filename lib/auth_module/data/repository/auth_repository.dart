import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:imperial/auth_module/data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import 'package:imperial/auth_module/data/models/user_join_request_model.dart';
import 'package:imperial/auth_module/data/models/user_ticket_model.dart';
import 'package:imperial/auth_module/data/remote_data_source/auth_remote_data_source.dart';
import 'package:imperial/auth_module/domain/entities/notification.dart';
import 'package:imperial/auth_module/domain/entities/register_request.dart';
import 'package:imperial/auth_module/domain/entities/user_entity.dart';
import 'package:imperial/auth_module/domain/repository/base_auth_repository.dart';
import 'package:imperial/core/utils/ServerException.dart';
import 'package:imperial/core/utils/nework_exception.dart';
import 'package:imperial/user_module/data/data_source/user_remote_data_source.dart';
import 'package:imperial/user_module/data/repository/user_repository.dart';
import 'package:imperial/user_module/domain/use_case/update_user_use_case.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';

import '../models/user_login_model.dart';

class AuthRepository extends BaseAuthRepository{
  BaseAuthRemoteDataSource authRemoteDataSource;
 BaseAuthLocalDataSource authLocalDataSource;

  AuthRepository(this.authRemoteDataSource,this.authLocalDataSource);

  @override
  Future<Either<ErrorMessageModel, User>> userRegister(User user) async {
    try {
      final result =await authRemoteDataSource.userRegister(user);

      return Right(result);
    }
    on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> userLogin(UserLoginModel user) async {

    try {
      final result =await authRemoteDataSource.userLogin(user);

      return Right(result);
    }
    on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<Exception, User>> getCurrentUser() async {

    try {
      final User currentUser= await authLocalDataSource.getCurrentUser();

return Right(currentUser);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  saveUserToken(String userToken) {
    try{
      authLocalDataSource.saveUserToken(userToken);
    }
    on Exception catch (e){
      log(e.toString());
      rethrow;

    }
  }


  @override
  Future userLogout() async{

   await authLocalDataSource.userLogout();

  }

  @override
  Future<Either<ErrorMessageModel, String>> sendRegistrationRequest(RegistrationRequest registrationRequest) async {
    try {
      final result =await authRemoteDataSource.sendRegistrationRequest(registrationRequest);

      return Right(result);
    }
    on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<UserJoinRequest>>> getUserJoinRequests(int id) async {
    try {
      final result =await authRemoteDataSource.getUserJoinRequests(id);

      return Right(result);
    }
    on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> updateUserToken(int id) async {
    try {
      final result =await authRemoteDataSource.updateUserToken(id);

      return Right(result);
    }
    on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<UserTicketModel>>> getUserTicketRequests(int id) async {
    try {
      final result =await authRemoteDataSource.getUserTicketRequests(id);

      return Right(result);
    }
    on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, User>> getUserById(int id) async {
    try {
      final result =await authRemoteDataSource.getUserById(id);

      return Right(result);
    }
    on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> sendNotification(AppNotification notification) async {

    try {
      final result =await authRemoteDataSource.sendNotification(notification);

      return Right(result);
    }
    on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> changePassword({required String email, required String password}) async{
    try {
      final result =
      await authRemoteDataSource.changePassword(email: email,newPassword:password );

      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> getResetPasswordCode(
      String email) async {
    try {
      final result =
      await authRemoteDataSource.getResetPasswordCode(email);

      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> changeCurrentPassword({required String email, required String newPassword, required String currentPassword}) async {
    try {
      final result =
          await authRemoteDataSource.changeCurrentPassword(newPassword:newPassword ,email:email ,currentPassword:currentPassword );

      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> removeDeviceToken(int userId)async {
    try {
      final result =
          await authRemoteDataSource.removeDeviceToken(userId);

      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

}