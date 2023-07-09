import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperial/app_init_module/presentation/controller/region_controller.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:sizer/sizer.dart';

class ChangeRegionButton extends StatelessWidget {
  final double iconSize;
  final double width;

  AppDataController controller = Get.find<AppDataController>();

  ChangeRegionButton({this.iconSize = 3, required this.width});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppDataController>(builder: (c) {
      return c.loading?
      LoadingScreen(width * 0.1): ( c.error? SizedBox.shrink(): Container(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PopupMenuButton(
              icon: Icon(
                Icons.change_circle_outlined,
                size: (iconSize/100)*width,
              ),
              itemBuilder: (BuildContext context) {
                return c.regions
                    .map((e) => PopupMenuItem(
                        onTap: () => c.updateCurrentRegion(e),
                        child: Text(
                          e.name,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.black),
                        )))
                    .toList();
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All results from',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.grey),
                ),
                Flexible(
                  child: Text(
                    c.currentRegion!.name,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ));
    });
  }
}
