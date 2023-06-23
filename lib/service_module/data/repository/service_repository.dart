import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:imperial/core/utils/ServerException.dart';
import 'package:imperial/service_module/data/data_source/remote_data_source/service_remote_data_source.dart';
import 'package:imperial/service_module/data/model/service_card_model.dart';
import 'package:imperial/service_module/data/model/service_rate_model.dart';
import 'package:imperial/service_module/domain/entity/service_category.dart';
import 'package:imperial/service_module/domain/repository/base_service_repository.dart';

import '../../../app_init_module/data/models/request_communities_model.dart';
import '../../../core/utils/nework_exception.dart';
import '../../domain/entity/service.dart';

class ServiceRepository extends BaseServiceRepository{
  BaseServiceRemoteDataSource serviceRemoteDataSource;

  ServiceRepository(this.serviceRemoteDataSource);

  @override
  Future<Either<ErrorMessageModel, List<ServiceCategory>>> getServiceCategories() async {
    try {
      final result =await serviceRemoteDataSource.getServiceCategories();

      log('ServiceRepository: service categories returned from api');
      return Right(result);

    } on ServerException catch (e){
      return   Left(e.errorMessageModel);
    }

  }

  @override
  Future<Either<ErrorMessageModel, List<CService>>> getService(LimitParametersModel queryParameters) async {
    try { final result =await serviceRemoteDataSource.getServices( queryParameters);

      log('ServiceRepository: service categories returned from api');
      return Right(result);

    }
    on ServerException catch (e){
      return   Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, CService>> getServiceById(int id) async {
    try {  final result =await serviceRemoteDataSource.getServiceById(id);

      log('ServiceRepository: service by id $id returned from api');
      return Right(result);

    }
    on ServerException catch (e){
      return   Left(e.errorMessageModel);
    }
  }

  @override
  Future rateService(ServiceRateModel rate) async {
   await serviceRemoteDataSource.serviceRate(rate);

  }

}