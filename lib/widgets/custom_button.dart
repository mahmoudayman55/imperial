import 'package:flutter/material.dart';
import 'package:imperial/core/utils/custom_colors.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double textPadding;
  final double iconSize;
  final double borderRadius;
  final String label;
  final IconData? icon;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final bool useGradient;
  final bool circleIcon;
  final bool enabled;
  final FontWeight fontWeight;
  final VoidCallback onPressed;

  const CustomButton({
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
    this.fontWeight = FontWeight.w700,
    this.borderRadius = 8,
    this.circleIcon = true,
    this.iconSize = 0.08,
    this.textPadding = 8,
     this.enabled=true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startColor = color;
    final endColor = useGradient ? color.withOpacity(0.5) : color;

    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: !useGradient ? Border.all(color: borderColor) : null,
            borderRadius: BorderRadius.circular(borderRadius),
            color: enabled?(!useGradient ? color : null):Colors.grey,
            gradient: enabled?(useGradient
                ? LinearGradient(
                    colors: [startColor, endColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                  )
                : null):null),
        height: height,
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          onPressed:enabled? onPressed:null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              if (icon != null && circleIcon )
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: Icon(
                    icon,
                    size: iconSize*width,
                    color: Colors.white,
                  ),
                ),
              if (icon != null && !circleIcon)
                Icon(
                  icon,
                  size: (iconSize)*width,
                  color: Colors.white,
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: textPadding),
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: textColor, fontWeight: fontWeight),
                ),
              ),
            ],
          ),
        ));
  }
}
