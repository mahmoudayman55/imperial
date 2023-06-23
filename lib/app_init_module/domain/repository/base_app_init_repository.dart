import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/domain/entities/app_init_entity.dart';
import 'package:imperial/app_init_module/domain/entities/group_age_entity.dart';
import 'package:imperial/app_init_module/domain/entities/onboarding_entity.dart';

import '../../../core/utils/nework_exception.dart';
import '../entities/city.dart';
import '../entities/language_entity.dart';
import '../entities/region_entity.dart';
abstract class BaseAppInitRepository{


  Future<Either <ErrorMessageModel,AppInitial>> getAppInitial ();
  Future<Either <ErrorMessageModel,List<OnBoarding>>> getOnBoards ();
  Future<Either <ErrorMessageModel,List<Region>>> getRegions ();
  Future<Either <ErrorMessageModel,List<GroupAge>>> getGroupAges ();
  Future<Either <ErrorMessageModel,List<City>>> getCities ();
  Future<Either <ErrorMessageModel,List<SpeakingLanguage>>> getSpeakingLanguages ();
  Future<Either <ErrorMessageModel,bool>> saveSelectedRegion ( Region region);
  Future<Either <ErrorMessageModel,Region>>saveOtherRegion ( String region);
  Future<Either <ErrorMessageModel,String>>getAppVersion ();




  Future<Either <Exception,Region>> getSelectedRegion ();


}