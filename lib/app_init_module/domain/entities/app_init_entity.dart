import 'package:imperial/app_init_module/data/models/language_model.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/app_init_module/domain/entities/region_entity.dart';

import '../../../core/utils/app_constants.dart';
import '../../data/models/city_model.dart';
import '../../data/models/group_age_model.dart';
import '../../data/models/on_boarding_model.dart';
import '../../data/models/region_model.dart';
import 'group_age_entity.dart';

class AppInitial {
  final List<RegionModel> regions;
  final List<OnBoardingModel> onBoarding;
  final List<GroupAgeModel> groupAges;
  final List<SpeakingLanguageModel> languages;
  final  List<CityModel> cities;

  final String about;
  final String contact;

  AppInitial(  {required this.languages,
    required this.regions,
    required this.onBoarding,
    required this.groupAges,required this.cities,
    required this.about,
    required this.contact,
  });


}