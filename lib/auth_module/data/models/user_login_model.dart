import '../../../core/utils/app_constants.dart';
import '../../domain/entities/user_entity.dart';

class UserLoginModel extends User {
  UserLoginModel({
    required String email,
    required String password,
    required String deviceToken,

  }) : super(
    id: -1,
    name: "",
    email: email,deviceToken:deviceToken ,
    password: password,
    zip: "",
    phone: "",role: null,
    coverPicUrl: "",
    picUrl: "",community: null,city: null,groupAge: null,region: null,speakingLanguage: null
  );

  Map<String, dynamic> toJson() {
    return {
      AppConstants.emailKey: email,
      AppConstants.passwordKey: password,
      "device_token": deviceToken,
    };
  }

   @override
  UserLoginModel fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      email: json[AppConstants.emailKey],
      password: json[AppConstants.passwordKey], deviceToken: json["device_token"],
    );
  }
}