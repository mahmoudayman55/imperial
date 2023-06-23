import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:imperial/app_init_module/data/models/app_init_model.dart';
import 'package:imperial/app_init_module/data/models/region_model.dart';
import 'package:imperial/app_init_module/domain/entities/onboarding_entity.dart';
import 'package:imperial/core/utils/app_constants.dart';

import '../../../domain/entities/region_entity.dart';
abstract class BaseAppInitLocalDataSource{
  Future<Region> getSelectedRegion();
  Future<bool>  saveRegion(Region region);
}

class AppInitLocalDataSource extends BaseAppInitLocalDataSource{
  final Box<Region> _regionBox = Hive.box<Region>('regionBox');

  @override
  Future<Region> getSelectedRegion()async  {
    final selectedRegionModel = _regionBox.get('selectedRegion');
    //log("haha"+selectedRegionModel.toString());
    if (selectedRegionModel == null) {
      log('AppInitLocalDataSource: get region from hive failed');
      throw Exception('AppInitLocalDataSource: get region from hive failed');
    }

    return selectedRegionModel;
  }

  @override
  Future<bool> saveRegion(Region region) async {
    try {
      await _regionBox.put("selectedRegion", region);
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }


}