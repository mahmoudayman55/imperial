import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperial/core/utils/theme.dart';
import 'package:sizer/sizer.dart';

SnackbarController customSnackBar({

  required String title,
  required String message,
  required bool successful,
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
    backgroundColor: successful ? Colors.lightGreen : Colors.red,
    icon: Icon(
      successful ? Icons.check : Icons.error,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 3),
  );
}
