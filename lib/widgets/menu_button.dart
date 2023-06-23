import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:imperial/core/utils/custom_colors.dart';
import 'package:sizer/sizer.dart';
class MenuButton extends StatelessWidget {
  final double height;
  final double width;
  final double iconSize;
  final String label;
  final IconData? icon;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final bool useGradient;
  final FontWeight fontWeight;
  final VoidCallback onPressed;

  const MenuButton({
    Key? key,
    this.textColor = Colors.white,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.label,
    this.icon,
    this.color = CustomColors.red,
    this.useGradient = true,
    this.borderColor = Colors.white,
    this.fontWeight = FontWeight.w500,  this.iconSize=5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startColor = color;
    final endColor = useGradient ? color.withOpacity(0.5) : color;

    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color ,),

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (icon != null)
                Padding(
                  padding:  EdgeInsets.only(right:width*0.04 ),
                  child: Icon(
                    icon,
                    size: (iconSize/70)*width,
                    color: textColor,
                  ),
                ),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: textColor, fontWeight: fontWeight),
              ),

            ],
          ),
        ));
  }
}
