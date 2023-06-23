import 'package:imperial/app_init_module/data/models/city_model.dart';
import 'package:imperial/app_init_module/data/models/on_boarding_model.dart';
import 'package:imperial/app_init_module/data/models/region_model.dart';
import 'package:imperial/app_init_module/domain/entities/app_init_entity.dart';
import 'package:imperial/core/utils/app_constants.dart';

import '../../domain/entities/group_age_entity.dart';
import '../../domain/entities/language_entity.dart';
import '../../domain/entities/region_entity.dart';
import 'group_age_model.dart';
import 'language_model.dart';

class AppInitModel extends AppInitial {
  AppInitModel({
    required List<RegionModel> regions,
    required List<OnBoardingModel> onBoarding,
    required List<GroupAgeModel> groupAges,
    required  List<SpeakingLanguageModel> languages,
    required  List<CityModel> cities,
    required String about,
    required String contact,
  }) : super(    languages: languages,

    regions: regions,cities: cities,
    onBoarding: onBoarding,
    groupAges: groupAges,
    about: about,
    contact: contact,
  );

  factory AppInitModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> regionsJson = json[AppConstants.regionsKey];
    final List<RegionModel> regions = regionsJson
        .map((regionJson) => RegionModel.fromJson(regionJson))
        .toList();

    final List<dynamic> onBoardingJson = json[AppConstants.onBoardingKey];
    final List<OnBoardingModel> onBoarding = onBoardingJson
        .map((onBoardingJson) {
      return OnBoardingModel.fromJson(onBoardingJson);
    })
        .toList();

    final List<dynamic> groupAgesJson = json[AppConstants.groupAgesKey];
    final List<GroupAgeModel> groupAges = groupAgesJson
        .map((groupAgeJson) => GroupAgeModel.fromJson(groupAgeJson))
        .toList();

    final List<dynamic> languagesJson = json[AppConstants.speakingLanguagesKey];
    final List<SpeakingLanguageModel> languages = languagesJson
        .map((languageJson) => SpeakingLanguageModel.fromJson(languageJson))
        .toList();

    final List<dynamic> citiesJson = json[AppConstants.citiesKey];
    final List<CityModel> cities = citiesJson
        .map((citiesJson) => CityModel.fromJson(citiesJson))
        .toList();


    return AppInitModel(
      regions: regions,
      onBoarding: onBoarding,
      groupAges: groupAges,
      about: json[AppConstants.appAboutKey],
      contact: json[AppConstants.appContactKey],
      languages: languages, cities: cities,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data[AppConstants.regionsKey] =
        regions.map((region) => region.toJson()).toList();

    data[AppConstants.onBoardingKey] =
        onBoarding.map((onBoarding) => onBoarding.toJson()).toList();

    data[AppConstants.groupAgesKey] =
        groupAges.map((groupAge) => groupAge.toJson()).toList();

    data[AppConstants.speakingLanguagesKey] =
        languages.map((language) => language.toJson()).toList();

    data[AppConstants.appAboutKey] = about;
    data[AppConstants.appContactKey] = contact;

    return data;
  }
}
