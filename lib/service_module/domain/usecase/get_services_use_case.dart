
import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/data/models/request_communities_model.dart';

import '../../../core/utils/nework_exception.dart';
import '../entity/service.dart';
import '../entity/service_category.dart';
import '../repository/base_service_repository.dart';

class GetServicesUseCase{
  BaseServiceRepository baseServiceRepository;

  GetServicesUseCase(this.baseServiceRepository);

  Future<Either<ErrorMessageModel, List<CService>>>execute(LimitParametersModel queryParameters)async{
    return await baseServiceRepository.getService(queryParameters);
  }
}