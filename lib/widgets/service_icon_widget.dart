import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/service_module/domain/entity/service_category.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:sizer/sizer.dart';
import '../core/utils/custom_colors.dart';

class ServiceIconWidget extends StatelessWidget {
  final double width;
  final double iconSize;
  final ServiceCategory serviceCategory;
  final Color color;
  final Color textColor;

  ServiceIconWidget(
      {required this.width,
      required this.serviceCategory,
      this.color = Colors.black54,
      this.textColor = Colors.white,
      this.iconSize = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 1.w),
            child: CustomCachedNetworkImage(imageUrl: serviceCategory.icon, width: width*0.25, height: width*0.25),
          ),
          Text(
            serviceCategory.name,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: textColor),
          )
        ],
      ),
    );
  }
}
