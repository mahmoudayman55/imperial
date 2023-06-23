
import 'package:dartz/dartz.dart';
import 'package:imperial/service_module/data/model/service_rate_model.dart';

import '../entity/service.dart';
import '../entity/service_category.dart';
import '../repository/base_service_repository.dart';

class RateServiceUseCase{
  BaseServiceRepository baseServiceRepository;

  RateServiceUseCase(this.baseServiceRepository);

  Future execute(ServiceRateModel rate)async{
     await baseServiceRepository.rateService(rate);
  }
}