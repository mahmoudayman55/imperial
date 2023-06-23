import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';


class IntroScreen extends StatelessWidget {

  final String label;
  final double height;
  final double width;
  final String details;

  IntroScreen({required this.label, required this.details, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);


      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(padding: EdgeInsets.all(width*0.02),height: 0.8*height,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(label,style: Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: 0.05*height,),
              Text(details,style: Theme.of(context).textTheme.bodyMedium,),
            ],
          ),
        ),
      );

  }
}
