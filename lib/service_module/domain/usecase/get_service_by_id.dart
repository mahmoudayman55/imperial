import 'package:dartz/dartz.dart';
import 'package:imperial/core/utils/nework_exception.dart';
import 'package:imperial/service_module/domain/entity/service.dart';

import '../repository/base_service_repository.dart';

class GetServiceByIdUseCase{
  BaseServiceRepository baseServiceRepository;

  GetServiceByIdUseCase(this.baseServiceRepository);

  Future<Either<ErrorMessageModel,CService>>execute(int id)async{
    return await baseServiceRepository.getServiceById(id);
  }
}