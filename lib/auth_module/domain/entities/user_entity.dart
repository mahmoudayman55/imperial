import 'package:hive/hive.dart';
import 'package:imperial/app_init_module/domain/entities/group_age_entity.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/app_init_module/domain/entities/region_entity.dart';

import '../../../app_init_module/domain/entities/city.dart';
import '../../../community_module/domain/entity/community.dart';

class User   {
  late int id;

  late String name;
   String deviceToken;

  late String email;

  late String password;

   Region? region;

  late String zip;

  late String phone;

   GroupAge? groupAge;

   City? city;

   SpeakingLanguage? speakingLanguage;

  late String coverPicUrl;
   String? role;

  late String picUrl;

   Community? community;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.deviceToken,
    required this.password,
    required this.region,
    required this.zip,
    required this.phone,
    required this.role,
    required this.groupAge,
    required this.city,
    required this.speakingLanguage,
    required this.coverPicUrl,
    required this.picUrl,
    required this.community,
  });

}
