import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_colors.dart';

class Themes {
  static final Color darkBlue = Color.fromARGB(255, 47, 124, 183);
  static final Color softBlue = Color.fromARGB(255, 194, 227, 251);
  static final TextTheme _phoneTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 20.0.sp,
        color: Colors.white),
    headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 18.0.sp,
        color: Colors.white),
    displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 16.0.sp,
        color: Colors.white),
    displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 12.0.sp,
        color: Colors.white),
    displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 10.0.sp,
        color: Colors.white),
    bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 10.0.sp,
        color: Colors.white),
    bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 6.0.sp,
        color: Colors.white),
  );
  static final TextTheme _tabletTextTheme = TextTheme(
    headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 12.0.sp,
        color: Colors.white),
    headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 10.0.sp,
        color: Colors.white),
    displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 6.0.sp,
        color: Colors.white),
    displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 4.0.sp,
        color: Colors.white),
    displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 2.0.sp,
        color: Colors.white),
    bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 2.0.sp,
        color: Colors.white),
    bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 1.0.sp,
        color: Colors.white),
  );

  static final lightTheme = ThemeData.light().copyWith(
    primaryColorLight: CustomColors.red,
    colorScheme: ThemeData.light().colorScheme.copyWith(primary:  CustomColors.red,),
    scaffoldBackgroundColor: Colors.white,
    dividerColor: Colors.grey.shade300,
    primaryColor: CustomColors.red,
    primaryColorDark: CustomColors.red,
    textTheme: SizerUtil.deviceType == DeviceType.mobile
        ? _phoneTextTheme
        : _tabletTextTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkBlue,
    ),
  );
}
