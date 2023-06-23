import 'dart:developer';

import 'package:imperial/core/utils/app_constants.dart';

import '../../domain/entities/onboarding_entity.dart';


class OnBoardingModel extends OnBoarding {
  OnBoardingModel(
      {required super.id, required super.title, required super.content});
  factory OnBoardingModel.fromJson(Map<String, dynamic> map) {

return OnBoardingModel(
      id: map[AppConstants.idKey],
      title: map[AppConstants.onBoardingTitleKey],
      content: map[AppConstants.onBoardingContentKey],
    );
  }
}
