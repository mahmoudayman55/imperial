import 'package:hive/hive.dart';
import 'package:imperial/app_init_module/data/models/group_age_model.dart';
import 'package:imperial/app_init_module/domain/entities/group_age_entity.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/app_init_module/domain/entities/region_entity.dart';

import '../../../app_init_module/data/models/language_model.dart';
import '../../../app_init_module/data/models/region_model.dart';
import '../../domain/entities/user_entity.dart';
class UserRequestModel extends User {
  UserRequestModel(
  {required super.name,
   super.email="",
  super.password ="",
  required super.region,
   super.zip="",
   super.phone="",
  required super.groupAge,
   super.city,
  required super.speakingLanguage,
  required super.id,
   super.coverPicUrl="",
  required super.picUrl,  super.community,  super.role, required super.deviceToken});
  factory UserRequestModel.fromJson(Map<String, dynamic> json) {
    return UserRequestModel(
      name: json['name'],
      picUrl: json['pic_url'],
      region: RegionModel.fromJson(json['region']),
      speakingLanguage: SpeakingLanguageModel.fromJson(json['speaking_language']),
      groupAge: GroupAgeModel.fromJson(json['group_age']), id: json['id'], deviceToken: json['device_token'],
    );
  }

  @override
  toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = {};
  //   data['name'] = this.name;
  //   data['pic_url'] = this.picUrl;
  //   data['region'] = this.region.toJson();
  //   data['speaking_language'] = this.speakingLanguage.toJson();
  //   data['group_age'] = this.groupAge.toJson();
  //   return data;
  // }
}