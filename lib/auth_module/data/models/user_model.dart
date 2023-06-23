import 'dart:developer';

import 'package:imperial/app_init_module/data/models/group_age_model.dart';
import 'package:imperial/app_init_module/data/models/language_model.dart';
import 'package:imperial/app_init_module/data/models/region_model.dart';
import 'package:imperial/auth_module/domain/entities/user_entity.dart';
import 'package:imperial/community_module/data/model/community_event_model.dart';
import 'package:imperial/community_module/data/model/community_model.dart';

import '../../../app_init_module/data/models/city_model.dart';
import '../../../core/utils/app_constants.dart';

class UserModel extends User {

  UserModel(
      {required super.name,
      required super.email,
       super.password ="",
      required super.region,
      required super.zip,
      required super.phone,
      required super.groupAge,
      required super.city,
      required super.speakingLanguage,
      required super.id,
      required super.coverPicUrl,
      required super.picUrl,  super.community,  super.role, required super.deviceToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    log("role is: ${json["roleTitle"]}");

    return UserModel(
      id: json[AppConstants.idKey],
      name: json[AppConstants.userNameKey],
      email: json[AppConstants.emailKey],
      region: RegionModel.fromJson(json['region']),
      zip: json[AppConstants.zipKey],
      phone: json[AppConstants.phoneKey],
      deviceToken: json["device_token"],
      groupAge:GroupAgeModel.fromJson( json["group_age"]),
      city: CityModel.fromJson(json["city"]),
      speakingLanguage: SpeakingLanguageModel.fromJson(json["speaking_language"]),
      coverPicUrl:  json[AppConstants.userCoverPicUrlKey],
      picUrl:  json[AppConstants.userPicUrlKey], community:json["community"]!=null? CommunityEventModel.fromJson( json["community"]):null,
    role: json["roleTitle"] );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data[AppConstants.userNameKey] = name;
    data[AppConstants.emailKey] = email;
    data['region_id'] = region!.id;
    data[AppConstants.zipKey] = zip;
    data[AppConstants.phoneKey] = phone;
    data["group_age_id"] = groupAge!.id;
    data["city_id"] = city!.id;
    data[AppConstants.idKey] = id;
    data["speaking_language_id"] = speakingLanguage!.id;
    data['device_token'] = deviceToken;

    return data;
  }


}
