import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/domain/entities/app_init_entity.dart';
import 'package:imperial/app_init_module/domain/repository/base_app_init_repository.dart';

import '../entities/region_entity.dart';

class GetSelectedRegionUseCase{
  final BaseAppInitRepository baseAppInitRepository;

  GetSelectedRegionUseCase(this.baseAppInitRepository);

  Future<Either <Exception,Region >>execute()async{
    log('GetRegionsUseCase:execute ');
    return await baseAppInitRepository.getSelectedRegion();
  }
}