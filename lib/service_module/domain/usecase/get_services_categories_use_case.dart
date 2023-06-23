import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:imperial/core/utils/nework_exception.dart';
import 'package:imperial/service_module/domain/repository/base_service_repository.dart';

import '../entity/service_category.dart';

class GetServicesCategoriesUseCase{
BaseServiceRepository baseServiceRepository;

GetServicesCategoriesUseCase(this.baseServiceRepository);

Future<Either<ErrorMessageModel, List<ServiceCategory>>>execute()async{
  return await baseServiceRepository.getServiceCategories();
}
}