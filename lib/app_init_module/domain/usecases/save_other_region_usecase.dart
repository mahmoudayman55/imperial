import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/domain/entities/app_init_entity.dart';
import 'package:imperial/app_init_module/domain/repository/base_app_init_repository.dart';

import '../../../core/utils/nework_exception.dart';
import '../entities/region_entity.dart';

class SaveOtherRegionUseCase{
  final BaseAppInitRepository baseAppInitRepository;

  SaveOtherRegionUseCase(this.baseAppInitRepository);

  Future<Either<ErrorMessageModel, Region>> execute(String region)async{
    log('SaveOtherRegionUseCase:execute ');
    return await baseAppInitRepository.saveOtherRegion(region);
  }
}