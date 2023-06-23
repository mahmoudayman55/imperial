import 'package:hive/hive.dart';
import 'package:imperial/app_init_module/data/models/group_age_model.dart';
import 'package:imperial/app_init_module/domain/entities/group_age_entity.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/app_init_module/domain/entities/region_entity.dart';

import '../../../app_init_module/data/models/language_model.dart';
import '../../../app_init_module/data/models/region_model.dart';
import '../../domain/entities/user_entity.dart';
class UserTicketRequestModel extends User {
  UserTicketRequestModel(
  {required super.name,
  super.email="",
  super.password ="",
   super.region,
  super.zip="",
  super.phone="",
   super.groupAge,
  super.city,
   super.speakingLanguage,
  required super.id,
  super.coverPicUrl="",
  required super.picUrl,  super.community,  super.role, required super.deviceToken});
factory UserTicketRequestModel.fromJson(Map<String, dynamic> json) {
return UserTicketRequestModel(
  deviceToken: json['device_token'],
name: json['name'],
picUrl: json['pic_url'],
id: json['id'],
);
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = {};
  data['name'] = this.name;
  data['pic_url'] = this.picUrl;
  data['id'] = this.id;
  data['device_token'] = deviceToken;

  return data;
}

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}