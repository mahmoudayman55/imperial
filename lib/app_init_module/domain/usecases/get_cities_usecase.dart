import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/domain/repository/base_app_init_repository.dart';

import '../entities/city.dart';
import '../../../core/utils/nework_exception.dart';

class GetCitiesUseCase {
  BaseAppInitRepository baseAppInitRepository;

  GetCitiesUseCase(this.baseAppInitRepository);

  Future <Either<ErrorMessageModel, List<City>>> execute()async{
    return await baseAppInitRepository.getCities();
  }
}