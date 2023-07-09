import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imperial/auth_module/data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import 'package:imperial/auth_module/data/remote_data_source/auth_remote_data_source.dart';
import 'package:imperial/auth_module/data/repository/auth_repository.dart';
import 'package:imperial/auth_module/domain/usecase/change_password_use_case.dart';
import 'package:imperial/user_module/data/data_source/user_remote_data_source.dart';
import 'package:imperial/user_module/data/repository/user_repository.dart';
import 'package:imperial/auth_module/domain/usecase/get_reset_password_code_use_case.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';

class ResetPasswordController extends GetxController {
  final forgotPasswordFormKey = GlobalKey<FormState>();

  int currentStep = 0;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController resetCodeController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();
  final newPasswordFormKey = GlobalKey<FormState>();
  late String resetCode;
bool loading=false;
  getResetCode() async {
    if (emailFormKey.currentState!.validate()) {
      loading=true;
      update();
      final result = await GetResetPasswordCodeUseCase(
              AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource()))
          .execute(emailController.text);
      result.fold(
          (l) => customSnackBar(
              title: "error",
              message: l.message.toString(),
              successful: false), (r) {
        currentStep++;
        update();
        customSnackBar(
            title: "Done",
            message: "reset code sent successfully to your email ",
            successful: true);
        resetCode = r;

      });
      loading=false;
      update();
    }
  }

  verifyResetCode(String code) {

    if (resetCode == code) {
      currentStep++;
      update();
    } else {
      customSnackBar(
          title: "error", message: "Invalid code", successful: false);
    }
  }

  changePassword() async {
    if (newPasswordFormKey.currentState!.validate()) {
      loading=true;
      update();
      final result = await ChangePasswordUseCase(
              AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource()))
          .execute(
              email: emailController.text,
              newPassword: passwordController.text);
      result.fold(
          (l) => customSnackBar(
              title: "error", message: l.message.toString(), successful: false),
          (r) {
            Get.offAllNamed("/login");
             customSnackBar(title: "Done", message: r, successful: true);
          });
      loading=false;
      update();
    }
  }
}
