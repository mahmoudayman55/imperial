import '../../../core/utils/app_constants.dart';
import '../../domain/entities/user_entity.dart';

class UserRegisterModel extends User {
  UserRegisterModel(
      {
      required super.name,
      required super.email,
      required super.password,
      required super.region,
      required super.zip,
      required super.phone,
      required super.groupAge,
      required super.city,
      required super.speakingLanguage,
      required super.coverPicUrl,
      required super.picUrl,
       super.community,  super.id=0,  super.role, required super.deviceToken});
// UserRegisterModel({
//   required String name,
//   required String email,
//   required String password,
//   required int regionId,
//   required String zip,
//   required String phone,
//   required int groupAgeId,
//   required int cityId,
//   required int speakingLanguageId,
//   required String coverPicUrl,
//   required String picUrl,
// }) : super(
//   id: -1,
//   name: name,
//   email: email,
//   password: password,
//   regionId: regionId,
//   zip: zip,
//   phone: phone,
//   groupAgeId: groupAgeId,
//   cityId: cityId,
//   speakingLanguageId: speakingLanguageId,
//   coverPicUrl: coverPicUrl,
//   picUrl: picUrl,
// );
//
Map<String, dynamic> toJson() {
  return {
    AppConstants.userNameKey: name,
    AppConstants.emailKey: email,
    AppConstants.passwordKey: password,
    AppConstants.userRegionIdKey: region!.id,
    AppConstants.zipKey: zip,
    AppConstants.phoneKey: phone,
    AppConstants.groupAgeIdKey: groupAge!.id,
    AppConstants.cityIdKey: city!.id,
    AppConstants.speakingLanguageIdKey: speakingLanguage!.id,
    AppConstants.userCoverPicUrlKey: coverPicUrl,
    AppConstants.userPicUrlKey: picUrl,
    "device_token":deviceToken
  };
}

static UserRegisterModel fromJson(Map<String, dynamic> json) {
  return UserRegisterModel(
    name: json[AppConstants.userNameKey],      deviceToken: json["device_token"],

    email: json[AppConstants.emailKey],
    password: json[AppConstants.passwordKey],
    zip: json[AppConstants.zipKey],
    phone: json[AppConstants.phoneKey],
    coverPicUrl: json[AppConstants.userCoverPicUrlKey],
    picUrl: json[AppConstants.userPicUrlKey], region: null, groupAge: null, city: null, speakingLanguage: null,
  );
}
}
