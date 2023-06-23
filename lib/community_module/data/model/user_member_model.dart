import 'package:imperial/auth_module/domain/entities/user_entity.dart';

class UserMember extends User {
  UserMember({
    required super.id,
    required super.name,
    required super.picUrl,
    super.email = '',
    super.password = '',
    super.region,
    super.zip = '',
    required super.phone,
    super.groupAge,
    super.city,
    super.speakingLanguage,
    super.coverPicUrl = '',
    super.community,
    super.role,
    required super.deviceToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pic_url': picUrl,
      'device_token': deviceToken
    };
  }

  static UserMember fromJson(Map<String, dynamic> json) {
    return UserMember(
      id: json['id'] ?? -1,
      deviceToken: json['device_token'],
      name: json['name'],
      picUrl: json['pic_url'] ?? "",
      phone: json["phone"] ?? "",
    );
  }
}
