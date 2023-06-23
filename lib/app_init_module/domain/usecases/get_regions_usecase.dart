import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/domain/entities/app_init_entity.dart';
import 'package:imperial/app_init_module/domain/repository/base_app_init_repository.dart';

import '../entities/region_entity.dart';
import '../../../core/utils/nework_exception.dart';

class GetRegionsUseCase{
  final BaseAppInitRepository baseAppInitRepository;

  GetRegionsUseCase(this.baseAppInitRepository);

  Future<Either <ErrorMessageModel,List<Region>>>execute()async{
    log('GetRegionsUseCase:execute ');
    return await baseAppInitRepository.getRegions();
  }
}