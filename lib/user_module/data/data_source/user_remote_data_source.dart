import 'dart:developer';

import 'package:dio/dio.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:imperial/community_module/data/model/community_model.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth_module/data/models/user_model.dart';
import '../../../auth_module/domain/entities/user_entity.dart';
import '../../../community_module/data/model/update_community_model.dart';
import '../../../core/utils/ServerException.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/nework_exception.dart';

abstract class BaseUserRemoteDataSource {
  Future<String> updateUser(UserModel user);
  Future<String> updateUserCommunity(UpdateCommunityModel community);

  Future<String> updateUserProfilePic(int id, XFile pic);
  Future<String> updateUserCoverPic(int id, XFile pic);
  Future<String> updateCommunityCoverPic(int id, XFile pic);
}

class UserRemoteDataSource extends BaseUserRemoteDataSource {
  @override
  Future<String> updateUser(UserModel user) async {
    try {
      final response = await Dio().put(

        "${AppConstants.userRoute}/${user.id}",
        data: user.toJson(),
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
  Future<String> updateUserProfilePic(int id, XFile pic) async {
    try {
      FormData data = FormData.fromMap(
          {"key": "pic_url",

            "pic":await MultipartFile.fromFile(
                pic.path, filename: pic.name,
                contentType: MediaType('image', 'jpeg'))
          });
      final response =await Dio().post("${AppConstants.userRoute}/upload/$id",data: data);
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
  Future<String> updateUserCoverPic(int id, XFile pic) async {
    try {
      FormData data = FormData.fromMap(
          {"key": "cover_pic_url",

            "pic":await MultipartFile.fromFile(
              pic.path, filename: pic.name,
              contentType: MediaType('image', 'jpeg'))
          });
      final response =await Dio().post("${AppConstants.userRoute}/upload/$id",data: data);
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
  Future<String> updateUserCommunity(UpdateCommunityModel community) async {
    try {
      final response = await Dio().put(

        "${AppConstants.communitiesRoute}/${community.id}",
        data: community.toJson(),
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
  Future<String> updateCommunityCoverPic(int id, XFile pic) async {
    try {
      FormData data = FormData.fromMap(
          {"key": "cover_url",

            "pic":await MultipartFile.fromFile(
              pic.path, filename: pic.name,
              contentType: MediaType('image', 'jpeg'))
          });
      final response =await Dio().post("${AppConstants.communitiesRoute}/upload/$id",data: data);
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


}
