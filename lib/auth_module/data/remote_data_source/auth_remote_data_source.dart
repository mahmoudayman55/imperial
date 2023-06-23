import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:imperial/app_init_module/data/models/region_model.dart';
import 'package:imperial/auth_module/data/models/register_request_model.dart';
import 'package:imperial/auth_module/data/models/user_register_model.dart';
import 'package:imperial/auth_module/domain/entities/notification.dart';
import 'package:imperial/auth_module/domain/entities/register_request.dart';
import 'package:imperial/core/utils/ServerException.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../../../core/utils/app_constants.dart';
import '../../domain/entities/register_request.dart';
import '../../domain/entities/register_request.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_join_request_model.dart';
import '../models/user_login_model.dart';
import '../models/user_model.dart';
import '../models/user_request_model.dart';
import '../models/user_ticket_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<User> userRegister(User user);

  Future<String> sendNotification(AppNotification notification);

  Future<String> sendRegistrationRequest(
      RegistrationRequest registrationRequest);

  Future<List<UserJoinRequest>> getUserJoinRequests(int id);

  Future<String> userLogin(UserLoginModel user);
  Future<String> removeDeviceToken(int userId);

  Future<String> updateUserToken(int id);

  Future<User> getUserById(int id);

  Future<List<UserTicketModel>> getUserTicketRequests(int id);

  Future<String> getResetPasswordCode(String email);

  Future<String> changePassword(
      {required String email, required String newPassword});

  Future<String> changeCurrentPassword(
      {required String email,
      required String newPassword,
      required currentPassword});
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<User> userRegister(User user) async {
    try {
      final response = await Dio().post(AppConstants.userRegisterRoute,
          data: (user as UserRegisterModel).toJson());

      return UserRegisterModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<String> userLogin(UserLoginModel user) async {
    try {
      final response =
          await Dio().post(AppConstants.userLoginRoute, data: user.toJson());
      return response.data[AppConstants.userKey];
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<String> sendRegistrationRequest(
      RegistrationRequest registrationRequest) async {
    try {
      final response = await Dio().post(AppConstants.regRequest,
          data: (registrationRequest as RegistrationRequestModel).toJson());
      return response.data["msg"].toString();
    } on DioError catch (e) {
      log("Dio error: " + e.toString());

      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<List<UserJoinRequest>> getUserJoinRequests(int id) async {
    try {
      final response =
          await Dio().get("${AppConstants.userJoinRequestsRoute}/$id");

      log(response.data.toString());
      return List.from(response.data['joinRequests'] as List)
          .map((e) => UserJoinRequest.fromJson(e))
          .toList();
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<String> updateUserToken(int id) async {
    try {
      final response =
          await Dio().put("${AppConstants.userUpdateTokenRoute}/$id");
      return response.data[AppConstants.userKey];
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      log(e.message.toString());

      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<List<UserTicketModel>> getUserTicketRequests(int id) async {
    try {
      final response =
          await Dio().get("${AppConstants.userTicketRequestRoute}/$id");
      log(response.statusCode.toString());
      return List.from(response.data["event_tickets"])
          .map((e) => UserTicketModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<User> getUserById(int id) async {
    try {
      final response = await Dio().get("${AppConstants.userRoute}/$id");
      log(response.statusCode.toString());
      return UserModel.fromJson(response.data["user"]);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<String> sendNotification(AppNotification notification) async {
    final dio = Dio(); // create a Dio instance

    final options = Options(
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': AppConstants.notificationServerKey,
      },
    );

    try {
      final response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: {
          'to': notification.receiverToken,
          'notification': notification.toJson(),
        },
        options: options,
      );
      return "notification sent successfully";
    } on Exception catch (e) {
      throw ServerException(
          ErrorMessageModel(message: "error while sending notification"));
    }
  }

  @override
  Future<String> getResetPasswordCode(String email) async {
    try {
      final response = await Dio().post(
        AppConstants.forgotPasswordRoute,
        data: {"email": email},
      );
      return response.data["refresh_code"];
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<String> changePassword(
      {required String email, required String newPassword}) async {
    try {
      final response = await Dio().post(
        AppConstants.changePasswordRoute,
        data: {"email": email, "new_password": newPassword},
      );
      return response.data["msg"];
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<String> changeCurrentPassword(
      {required String email,
      required String newPassword,
      required currentPassword}) async {
    try {
      final response = await Dio().post(
        AppConstants.changeCurrentPasswordRoute,
        data: {
          "email": email,
          "new_password": newPassword,
          "password": currentPassword
        },
      );
      return response.data["msg"];
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<String> removeDeviceToken(int userId) async {
    try {
      final response =
          await Dio().put("${AppConstants.userRoute}/$userId",data: {"device_token":""});
      return response.data["msg"];
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      log(e.message.toString());

      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }
}
