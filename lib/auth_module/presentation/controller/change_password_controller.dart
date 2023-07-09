import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_snack_bar.dart';
import '../../data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import '../../data/remote_data_source/auth_remote_data_source.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/usecase/change_current_password_use_case.dart';

class ChangePasswordController extends GetxController{
bool changingPassword=false;

  final GlobalKey<FormState> changePasswordFrom = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();

  changePassword(String email) async {
    if (changePasswordFrom.currentState!.validate()) {

      changingPassword=true;
      update();
      final result = await ChangeCurrentPasswordUseCase(
          AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource()))
          .execute(
          email: email,
          newPassword: newPasswordController.text,
          currentPassword: currentPasswordController.text);

      result.fold(
              (l) => customSnackBar(
              title: "error",
              message: l.message.toString(),
              successful: false), (r) {
        Get.back();
        customSnackBar(title: "Done", message: r, successful: true);
      });

      changingPassword=false;
      update();
    }
  }
}