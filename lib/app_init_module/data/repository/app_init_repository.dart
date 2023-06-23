import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:imperial/app_init_module/data/local_data_source/hive/base_app_iti_local_data_source.dart';
import 'package:imperial/app_init_module/data/models/city_model.dart';
import 'package:imperial/app_init_module/data/models/group_age_model.dart';
import 'package:imperial/app_init_module/data/models/region_model.dart';
import 'package:imperial/app_init_module/domain/entities/app_init_entity.dart';
import 'package:imperial/app_init_module/domain/entities/city.dart';
import 'package:imperial/app_init_module/domain/entities/group_age_entity.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/app_init_module/domain/entities/onboarding_entity.dart';
import 'package:imperial/app_init_module/domain/repository/base_app_init_repository.dart';
import 'package:imperial/core/utils/ServerException.dart';

import '../../../core/utils/nework_exception.dart';
import '../../domain/entities/region_entity.dart';
import '../models/language_model.dart';
import '../remote_data_source/app_init_remote_data_source.dart';

class AppInitRepository extends BaseAppInitRepository {
  final BaseAppInitRemoteDataSource baseAppInitRemoteDataSource;
  final BaseAppInitLocalDataSource baseAppInitLocalDataSource;

  AppInitRepository(
      this.baseAppInitRemoteDataSource, this.baseAppInitLocalDataSource);

  @override
  Future<Either<ErrorMessageModel, AppInitial>> getAppInitial() async {
    try {    final result = await baseAppInitRemoteDataSource.getAppInit();

    return Right(result);
    }   on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<OnBoarding>>> getOnBoards() async {
    try {    final result = await baseAppInitRemoteDataSource.getOnBoards();

    return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    } on DioError catch (e) {
      return Left(ErrorMessageModel(
          message: e.message,
          type: e.type.toString(),
          statusCode: e.response!.statusCode,
          fixIt: e.error.toString()));
    } catch (e) {
    return  Left(ErrorMessageModel(
          message: e.toString(),
          type: e.toString(),
          fixIt: e.toString()));
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<Region>>> getRegions() async {
    try {    final result = await baseAppInitRemoteDataSource.getRegions();

    log('AppInitRepository: regions returned from api');
      return Right(result
          .map((regionModel) => RegionModel(
                id: regionModel.id,
                name: regionModel.name,
              ))
          .toList());
    }on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<Exception, Region>> getSelectedRegion() async {
    try {
      final selectedRegionModel =
          await baseAppInitLocalDataSource.getSelectedRegion();
      return Right(selectedRegionModel);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ErrorMessageModel, bool>> saveSelectedRegion(Region region) async {
    try {
      await baseAppInitLocalDataSource.saveRegion(region);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, Region>> saveOtherRegion(String region) async {

    try {    final result = await baseAppInitRemoteDataSource.saveOtherRegion(region);

    log('AppInitRepository: regions returned from api');
      return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<City>>> getCities() async {
    try {    final result = await baseAppInitRemoteDataSource.getCities();

    log('AppInitRepository: regions returned from api');
      return Right(result
          .map((City city) => CityModel(
                id: city.id,
                name: city.name,
              ))
          .toList());
    }on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<GroupAge>>> getGroupAges() async {
    try {    final result = await baseAppInitRemoteDataSource.getGroupAges();

    log('AppInitRepository: regions returned from api');
      return Right(result
          .map((GroupAge groupAge) => GroupAgeModel(
                id: groupAge.id,
                groupAge: groupAge.groupAge,
              ))
          .toList());
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<SpeakingLanguage>>>
      getSpeakingLanguages() async {
    try {
      final result = await baseAppInitRemoteDataSource.getSpeakingLanguages();

      log('AppInitRepository: regions returned from api');
      return Right(result
          .map((SpeakingLanguage speakingLanguage) => SpeakingLanguageModel(
                id: speakingLanguage.id,
                name: speakingLanguage.name,
              ))
          .toList());
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> getAppVersion()async {

    try {
      final result = await baseAppInitRemoteDataSource.getAppVersion();

    log('AppInitRepository: regions returned from api');
    return Right(result);
    } on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }
}
