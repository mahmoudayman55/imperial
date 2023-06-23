import 'package:imperial/core/utils/app_constants.dart';

import '../../domain/entities/language_entity.dart';

class SpeakingLanguageModel extends SpeakingLanguage {
  SpeakingLanguageModel({required super.name, required super.id});


  factory SpeakingLanguageModel.fromJson(Map<String, dynamic> json) {
    return SpeakingLanguageModel(
      name: json[AppConstants.speakingLanguageNameKey] ,
      id: json[AppConstants.idKey] ,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[AppConstants.speakingLanguageNameKey] = name;
    data[AppConstants.idKey] = id;
    return data;
  }
}
