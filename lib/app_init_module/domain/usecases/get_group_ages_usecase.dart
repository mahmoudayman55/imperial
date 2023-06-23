import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/domain/repository/base_app_init_repository.dart';

import '../entities/group_age_entity.dart';
import '../../../core/utils/nework_exception.dart';

class GetGroupAgesUseCase{
  BaseAppInitRepository baseAppInitRepository;

  GetGroupAgesUseCase(this.baseAppInitRepository);

  Future<Either<ErrorMessageModel, List<GroupAge>>> execute()async{
    return await baseAppInitRepository.getGroupAges();
  }
}