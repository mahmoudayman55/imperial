import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/utils/custom_colors.dart';
class CustomErrorWidget extends StatelessWidget{
  final VoidCallback onPressed;
  final String message;
  final Color color;

  const CustomErrorWidget({required this.onPressed, required this.message,  this.color=Colors.white});

  @override
  Widget build(BuildContext context) {
return  SizedBox(height:10.h ,
    child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!.copyWith(color: color),
        ),IconButton(onPressed: onPressed, icon: Icon(Icons.refresh,color: CustomColors.red,size: 8.w,))
      ],
    ));
  }

}