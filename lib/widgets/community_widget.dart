import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:imperial/auth_module/presentation/controller/home_controller.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:imperial/community_module/presentation/controller/community_controller.dart';
import 'package:imperial/view/community_profile_view.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';

import '../community_module/domain/entity/community.dart';
import '../core/utils/app_constants.dart';
import '../core/utils/custom_colors.dart';
import 'event_slider.dart';
import 'event_widget.dart';

class CommunityWidget extends StatelessWidget {
  final Community community;


  CommunityWidget({required this.community, required this.width, required this.height});

  final double width;
  final double height;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [CustomCachedNetworkImage(imageUrl:
          community.coverUrl  , width: width, height: height),
            Container(height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  end: Alignment.topRight,
                  begin: Alignment.bottomLeft,
                  stops: [0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.0),
                  ],
                  transform: GradientRotation(150 * pi / 180),
                ),
              ),
            ),
            Container(height: 
              height,padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          community.name,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: Colors.amber),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Us',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Text(
                              community.about,maxLines: 7,overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: [  TextSpan(
                                    text: 'Members: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              TextSpan(
                                  text: community.membersNumber.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: Colors.amber)),

                            ])), RichText(
                                text: TextSpan(children: [     TextSpan(
                                    text: 'Events: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                  TextSpan(
                                      text: community.eventsNumber.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(color: Colors.amber)),

                                ])),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 5)
                          ]),
                          child: EventSlider(
                            events: community.events,
                            width: width * 0.4,
                            height: height * 0.5,
                            scrollDirection: Axis.vertical,
                            showEventDetails: false,
                          ),
                        ),
                        GetBuilder<HomeController>(
                          builder: (controller) {
                            return CustomButton(
                              height: height * 0.15,
                              width: width * 0.25,
                              onPressed: () => Get.toNamed(AppConstants.communityProfilePage,arguments: community.id),
                              borderColor: Colors.transparent,
                              label: 'visit',
                              icon: null,
                              useGradient: false,fontWeight: FontWeight.normal,
                              color: CustomColors.red,
                            );
                          }
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
