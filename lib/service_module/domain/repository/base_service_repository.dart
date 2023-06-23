import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/data/models/request_communities_model.dart';
import 'package:imperial/service_module/data/model/service_rate_model.dart';
import 'package:imperial/service_module/domain/entity/service_category.dart';

import '../../../core/utils/nework_exception.dart';
import '../entity/service.dart';

abstract class BaseServiceRepository{
Future <Either<ErrorMessageModel,List<ServiceCategory>>>getServiceCategories();
Future <Either<ErrorMessageModel,List<CService>>>getService(LimitParametersModel queryParameters);
Future <Either<ErrorMessageModel,CService>>getServiceById(int id);
Future rateService(ServiceRateModel rate);
}