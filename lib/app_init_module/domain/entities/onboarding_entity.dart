import 'package:imperial/core/utils/app_constants.dart';

class OnBoarding {
 late final int id;
 late final String title;
 late final String content;

  OnBoarding({required this.id, required this.title, required this.content});

  OnBoarding.fromJson(Map<String, dynamic> json) {
    id = json[AppConstants.idKey];
    title = json[AppConstants.onBoardingTitleKey];
    content = json[AppConstants.onBoardingContentKey];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data[AppConstants.idKey] = id;
    data[AppConstants.onBoardingTitleKey] = title;
    data[AppConstants.onBoardingContentKey] = content;
    return data;
  }
}