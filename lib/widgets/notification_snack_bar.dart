import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperial/core/utils/custom_colors.dart';
import 'package:imperial/core/utils/theme.dart';
import 'package:sizer/sizer.dart';

SnackbarController notificationSnackBar({

  required String title,
  required String message,

}) {
  return Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: Themes.lightTheme.textTheme.bodyMedium,
    ),
    messageText: Text(
      message,
      style:Themes.lightTheme.textTheme.bodyMedium,
    ),
    backgroundColor: CustomColors.green,
    icon: const Icon(
      Icons.notifications_active_outlined,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 5),
  );
}
