import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:imperial/app_init_module/data/models/app_init_model.dart';
import 'package:imperial/app_init_module/data/models/region_model.dart';
import 'package:imperial/app_init_module/domain/entities/city.dart';
import 'package:imperial/app_init_module/domain/entities/group_age_entity.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/app_init_module/domain/entities/onboarding_entity.dart';
import 'package:imperial/core/utils/ServerException.dart';
import 'package:imperial/core/utils/app_constants.dart';

import '../../../core/utils/nework_exception.dart';
import '../../domain/entities/region_entity.dart';
import '../models/city_model.dart';
import '../models/group_age_model.dart';
import '../models/language_model.dart';

abstract class BaseAppInitRemoteDataSource {
  Future<AppInitModel> getAppInit();

  Future<List<OnBoarding>> getOnBoards();
  Future<List<Region>> getRegions();
  Future<String> getAppVersion();
  Future<List<City>> getCities();
  Future<List<GroupAge>> getGroupAges();
  Future<List<SpeakingLanguage>> getSpeakingLanguages();

  Future<Region>  saveOtherRegion(String region);
}

class AppInitRemoteDataSource extends BaseAppInitRemoteDataSource {
  @override
  Future<AppInitModel> getAppInit() async {
    try {
      final response = await Dio().get(AppConstants.initialRoute);
        log('AppInitRemoteDataSource: app initial data request successful');
        return AppInitModel.fromJson(response.data);
    } on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }

  }

  @override
  Future<List<OnBoarding>> getOnBoards() async {

    try {
      final response = await Dio().get(AppConstants.onBoardsRoute);
        log('AppInitRemoteDataSource: app onBoards data request successful');
        return List<OnBoarding>.from(
            (response.data[AppConstants.onBoardingKey] as List)
                .map((e) => OnBoarding.fromJson(e)));
    }on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }

  }

  @override
  Future<List<Region>> getRegions() async {
    try {
      final response = await Dio().get(AppConstants.regionsRoute);
        log('AppInitRemoteDataSource: app regions data request successful');
        return List<Region>.from((response.data[AppConstants.regionsKey] as List)
            .map((e) => RegionModel.fromJson(e)));
    } on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }

  }

  @override
  Future <Region> saveOtherRegion(String region) async {
    try {
      final response = await Dio().post(AppConstants.otherRegionRoute,
          data: {AppConstants.regionNameKey: region});
        log('AppInitRemoteDataSource: save other region request successful');
        log("log:"+response.data.toString());
        return RegionModel.fromJson(response.data[AppConstants.otherRegionKey]);
    } on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<List<City>> getCities() async {
    try {
      final response = await Dio().get(AppConstants.citiesRoute);

        log('AppInitRemoteDataSource: app cities data request successful');
        return List<City>.from((response.data[AppConstants.citiesKey] as List)
            .map((e) => CityModel.fromJson(e)));
    } on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<List<GroupAge>> getGroupAges() async {
    try {
      final response = await Dio().get(AppConstants.groupAgesRoute);
        log('AppInitRemoteDataSource: app cities data request successful');
        return List<GroupAge>.from((response.data as List)
            .map((e) => GroupAgeModel.fromJson(e)));
    } on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }

  }

  @override
  Future<List<SpeakingLanguage>> getSpeakingLanguages() async {
    try {
      final response = await Dio().get(AppConstants.speakingLanguageRoute);
        log('AppInitRemoteDataSource: app cities data request successful');
        return List<SpeakingLanguage>.from((response.data[AppConstants.speakingLanguagesKey] as List)
            .map((e) => SpeakingLanguageModel.fromJson(e)));
    }on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }

  }

  @override
  Future<String> getAppVersion()async {
    try {
      final response = await Dio().get("${AppConstants.versionRoute}/1");
      log('AppInitRemoteDataSource: app cities data request successful');
      return response.data["msg"];
    }on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }

  }


}
