import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:imperial/service_module/data/model/service_card_model.dart';
import 'package:imperial/service_module/data/model/service_rate_model.dart';

import '../../../../app_init_module/data/models/request_communities_model.dart';
import '../../../../core/utils/ServerException.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/nework_exception.dart';
import '../../../domain/entity/service.dart';
import '../../../domain/entity/service_category.dart';
import '../../model/service_category_model.dart';
import '../../model/service_model.dart';

abstract class BaseServiceRemoteDataSource {
  Future<List<ServiceCategory>> getServiceCategories();

  Future<List<CService>> getServices(LimitParametersModel queryParameters);

  Future<CService> getServiceById(int id);

  Future serviceRate(ServiceRateModel rate);
}

class ServiceRemoteDataSource extends BaseServiceRemoteDataSource {
  @override
  Future<List<ServiceCategory>> getServiceCategories() async {
    try {
      final response = await Dio().get(AppConstants.servicesCategoriesRoute);

        log('ServiceRemoteDataSource: ServiceCategory data request successful');
        return List<ServiceCategory>.from((response.data["categories"] as List)
            .map((e) => ServiceCategoryModel.fromJson(e))).toList();
    } on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }

  }

  @override
  Future<List<CService>> getServices(
      LimitParametersModel queryParameters) async {
    try {
      final response = await Dio().get(AppConstants.servicesRoute,
          queryParameters: queryParameters.toJson());
      log("message ${queryParameters.toJson().toString()}");

        log('ServiceRemoteDataSource: ServiceCategory data request successful');
        return List<CService>.from((response.data["services"] as List)
            .map((e) => ServiceCardModel.fromJson(e))).toList();
    }  on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }

  }

  @override
  Future<CService> getServiceById(int id) async {
    try {
      final response = await Dio().get("${AppConstants.servicesRoute}/$id",   options: CacheOptions(
          store:
          MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576),
          maxStale: const Duration(hours: 10))
          .toOptions());
        log('ServiceRemoteDataSource: service by id $id data request successful');
        return ServiceModel.fromJson(response.data['service']);
    }  on DioError catch (e) {
      if(e.type == DioErrorType.connectionError || e.type == DioErrorType.receiveTimeout||e.type==DioErrorType.unknown){
        throw ServerException(ErrorMessageModel(message: "No internet connection"));

      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }

  @override
  Future serviceRate(ServiceRateModel rate) async {
    final response = await Dio()
        .post(AppConstants.servicesRateRoute, data: rate.toJson());
    if (response.statusCode == 201) {

    } else {
      throw Exception(response.statusCode);
    }
  }
}
