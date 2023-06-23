import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:hive/hive.dart';
import 'package:imperial/core/utils/app_constants.dart';

import '../../../../../../app_init_module/domain/entities/region_entity.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../models/user_model.dart';

abstract class BaseAuthLocalDataSource{
   Future saveUserToken(String userToken);
   Future<User> getCurrentUser();
   Future userLogout();
}
class AuthLocalDataSource extends BaseAuthLocalDataSource{
  final Box<String> _userTokenBox = Hive.box<String>(AppConstants.userTokenBoxName);



   @override
  Future saveUserToken(String userToken) async {
     try {
       await _userTokenBox.put(AppConstants.userTokenBoxKey, userToken);
       log("AuthLocalDataSource: userToken Saved");
     } on Exception catch (e) {
     log("AuthLocalDataSource: $e");
     }
  }

  @override
  Future<User> getCurrentUser() async {
  final userToken=  _userTokenBox.get(AppConstants.userTokenBoxKey);
if(userToken==null) {
  throw Exception();    // Verify a token
}
    try {
      final jwt = JWT.verify(userToken, SecretKey("hgf45hnfghfg56h47fg68h74gf685j4gh56j4/89"));

     log("payload " +jwt.toString());

      User user= UserModel.fromJson(jwt.payload);
      return user;
    } on Exception catch (e) {
      throw Exception();
    }

  }

  @override
  userLogout()async {
await _userTokenBox.clear();
  }

}