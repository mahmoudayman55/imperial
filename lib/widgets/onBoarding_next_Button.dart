import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/utils/custom_colors.dart';
import 'package:get/get.dart';

class NextButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double iconSize;
  final Function onPressed;

  NextButton(
      {this.icon = Icons.navigate_next,
      required this.onPressed,
      this.color = CustomColors.red,
      super.key,
      this.iconSize = 6});

  @override
  Widget build(BuildContext context) {
    final startColor = color;
    final endColor = color.withOpacity(0.5);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          )),
      child: IconButton(
        onPressed: onPressed as void Function()?,
        style: IconButton.styleFrom(padding: EdgeInsets.zero,alignment: Alignment.center),
        icon: Icon(
          icon,
          size: iconSize.w,
          color: Colors.white,
        ),
      ),
    );
  }
}
