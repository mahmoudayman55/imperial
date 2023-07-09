import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imperial/core/utils/app_constants.dart';

import '../../../widgets/custom_snack_bar.dart';
import '../../data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import '../../data/models/user_login_model.dart';
import '../../data/models/user_model.dart';
import '../../data/remote_data_source/auth_remote_data_source.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../../domain/usecase/get_current_user_use_case.dart';
import '../../domain/usecase/save_user_token_use_case.dart';
import '../../domain/usecase/user_login_cuse_case.dart';
import 'current_user_controller.dart';

class LoginController extends GetxController{
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController userLoginEmailController = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  RxBool loggingIn = false.obs;

  userLogin() async {
    if (loginFormKey.currentState!.validate()) {
      loggingIn.value = true;
      update();

      BaseAuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();

      BaseAuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
      BaseAuthRepository authRepository =
      AuthRepository(authRemoteDataSource, authLocalDataSource);
      final result = await UserLoginUseCase(authRepository).execute(
          UserLoginModel(
              email: userLoginEmailController.text,
              password: loginPasswordController.text,
              deviceToken:
              (await FirebaseMessaging.instance.getToken()).toString()));
      result.fold(
              (l) => customSnackBar(
            title: "Login failed",
            message: l.message.toString(),
            successful: false,
          ), (r) async {
        SaveUserTokenUseCase(authRepository).execute(r);
     /*   final user = await GetCurrentUserUseCase(authRepository).execute();
        user.fold((l) => log(l.toString()), (r) {
          log((r as UserModel).toJson().toString());
        });*/
        Get.delete<CurrentUserController>(force: true);

        Get.offAllNamed(AppConstants.homePage);

      });
      loggingIn.value = false;
      update();
    }
  }

}