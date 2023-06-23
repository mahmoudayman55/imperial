import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imperial/app_init_module/presentation/components/region_selector.dart';
import 'package:sizer/sizer.dart';

class onBoardingRegions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(

            child: RegionSelector()),
      ),
    );
  }
}
