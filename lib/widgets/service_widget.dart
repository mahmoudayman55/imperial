import 'dart:core';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/app_init_module/presentation/controller/on_boarding_controller.dart';
import 'package:imperial/app_init_module/presentation/controller/region_controller.dart';
import 'package:imperial/view/service_profile_view.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:sizer/sizer.dart';
import '../core/utils/custom_colors.dart';
import 'package:get/get.dart';

import '../service_module/domain/entity/service.dart';

class ServiceWidget extends StatelessWidget {
  final double height;
  final double width;
  final double iconSize;
  final CService service;
  final VoidCallback onPressed;

  ServiceWidget(
      {required this.width,
      required this.height,
      this.iconSize = 5,
      required this.service,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: CustomColors.softBlack,
            borderRadius: BorderRadius.circular(8)),
        width: width,
        height: height,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 3,
              child: CustomCachedNetworkImage(
                  imageUrl: service.picUrl, width: width, height: height),
            ),

            Expanded(flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  service.name,overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium,textAlign: TextAlign.center,
                ),
              ),
            ),
            Text(
              service.about,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
             maxLines: 3,
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: (iconSize/50)*width,
                          color: Colors.amber,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<AppDataController>(
                                builder: (regController) {

                              return Text(
                                regController.regions.isEmpty?"":
                                regController.regions
                                    .where((element) =>
                                        element.id == service.regionId)
                                    .first
                                    .name,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              );
                            }),
                            SizedBox(
                              width: width * 0.4,
                              child: Text(
                                service.address,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(color: Colors.grey.shade400),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(service.totalRate.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Colors.white)),
                        Icon(
                          Icons.star,
                          size: (iconSize/50)*width,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
