import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:imperial/app_init_module/presentation/controller/on_boarding_controller.dart';
import 'package:imperial/core/utils/custom_colors.dart';
import 'package:imperial/view/home_view.dart';
import 'package:imperial/widgets/onBoarding_next_Button.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class LoadingScreen extends StatelessWidget {

  final double width;


  LoadingScreen(this.width);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    return SpinKitFadingCircle(color: CustomColors.red,
      size: width,
    );
  }}
