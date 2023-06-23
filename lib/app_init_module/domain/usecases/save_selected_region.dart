import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/domain/entities/app_init_entity.dart';
import 'package:imperial/app_init_module/domain/repository/base_app_init_repository.dart';

import '../entities/region_entity.dart';
import '../../../core/utils/nework_exception.dart';

class SaveSelectedRegionUseCase{
  final BaseAppInitRepository baseAppInitRepository;

  SaveSelectedRegionUseCase(this.baseAppInitRepository);

  Future<Either <ErrorMessageModel,bool>> execute(Region region)async{
    log('SaveSelectedRegionUseCase:execute ');
    return await baseAppInitRepository.saveSelectedRegion(region);
  }
}