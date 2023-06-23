import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:imperial/auth_module/presentation/controller/auth_controller.dart';
import 'package:imperial/community_module/data/model/community_model.dart';
import 'package:imperial/community_module/presentation/controller/community_controller.dart';
import 'package:imperial/core/utils/custom_url_luncher.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../community_module/domain/entity/community.dart';
import '../core/utils/custom_colors.dart';
import '../widgets/community_admin_widget.dart';
import '../widgets/event_slider.dart';
import '../widgets/event_widget.dart';
import '../widgets/onBoarding_next_Button.dart';

class CommunityProfileView extends StatelessWidget {
  final communityC = Get.find<CommunityController>();
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      double width = 100.w;
      double height = 100.h;
      return deviceType == DeviceType.mobile
          ? Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NextButton(
                      onPressed: () => Get.back(),
                      icon: Icons.arrow_back_ios_rounded,
                    ),
                  )),
              backgroundColor: Colors.grey.shade100,
              body: GetBuilder<CommunityController>(builder: (c) {
                return communityC.gettingCommunity
                    ? LoadingScreen(width * 0.1)
                    : Column(
                        children: [
                          Expanded(
                            flex: 15,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      CustomCachedNetworkImage(
                                          imageUrl: communityC
                                              .selectedCommunity.coverUrl,
                                          width: width,
                                          height: height * 0.4),
                                      Container(
                                        width: width,
                                        height: height * 0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.black,
                                              Colors.transparent
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          color:
                                              CustomColors.red.withOpacity(0.5),
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            communityC.selectedCommunity.name,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Members (${communityC.selectedCommunity.membersNumber})',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            communityC.selectedCommunity.members
                                                    .isEmpty
                                                ? InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      "No members yet",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color:
                                                                  CustomColors
                                                                      .red),
                                                    ),
                                                  )
                                                : Row(
                                                    children: [
                                                      for (int index = 0;
                                                          index <
                                                              (communityC
                                                                          .selectedCommunity
                                                                          .members
                                                                          .length <
                                                                      4
                                                                  ? communityC
                                                                      .selectedCommunity
                                                                      .members
                                                                      .length
                                                                  : 4);
                                                          index++)
                                                        if (index > 2)
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        3),
                                                            width: width * 0.1,
                                                            height: width * 0.1,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: const BoxDecoration(
                                                                color:
                                                                    CustomColors
                                                                        .red,
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Text(
                                                              communityC
                                                                          .selectedCommunity
                                                                          .members
                                                                          .length >=
                                                                      100
                                                                  ? "+99"
                                                                  : "+${communityC.selectedCommunity.members.length - 3}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayLarge,
                                                            ),
                                                          )
                                                        else
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        3.0),
                                                            child: ClipOval(
                                                              child:
                                                                  CustomCachedNetworkImage(
                                                                imageUrl: communityC
                                                                    .selectedCommunity
                                                                    .members[
                                                                        index]
                                                                    .picUrl,
                                                                width:
                                                                    width * 0.1,
                                                                height:
                                                                    width * 0.1,
                                                              ),
                                                            ),
                                                          ),
                                                      SizedBox(
                                                        width: width * 0.02,
                                                      ),
                                                    ],
                                                  )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Our Events',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        communityC.selectedCommunity.events
                                                .isEmpty
                                            ? Text(
                                                "No events yet",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color:
                                                            CustomColors.red),
                                              )
                                            : EventSlider(
                                                events: communityC
                                                    .selectedCommunity.events,
                                                width: width,
                                                height: height * 0.2,
                                              ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Admins',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                              // Text(
                                              //   'see all',
                                              //   style: Theme.of(context)
                                              //       .textTheme
                                              //       .bodyLarge!
                                              //       .copyWith(
                                              //           color: Colors.black),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width,
                                          height: height * 0.17,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  child: InkWell(
                                                    onTap: () =>
                                                        authC.openPersonScreen(
                                                            communityC
                                                                .selectedCommunity
                                                                .admins[index]
                                                                .id),
                                                    child: CommunityAdminWidget(
                                                        width: width * 0.27,
                                                        height: height * 0.17,
                                                        admin: communityC
                                                            .selectedCommunity
                                                            .admins[index]),
                                                  ),
                                                );
                                              },
                                              itemCount: communityC
                                                  .selectedCommunity
                                                  .admins
                                                  .length),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'About Us',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            Text(
                                              communityC
                                                  .selectedCommunity.about,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  CustomButton(
                                      height: height * 0.1,
                                      width: (authC.currentUser == null ||
                                              authC.currentUser!.role == null)
                                          ? (width * 0.5)
                                          : width,
                                      borderRadius: 0,
                                      onPressed: () {
                                        CustomUrlLauncher.launchCallApp(
                                            communityC.selectedCommunity
                                                .admins[0].phone);
                                      },
                                      useGradient: false,
                                      circleIcon: false,
                                      borderColor: CustomColors.red,
                                      icon: Icons.call,
                                      label: 'Contact'),
                                  if (authC.currentUser == null ||
                                      authC.currentUser!.role == null)
                                    CustomButton(
                                        height: height * 0.1,
                                        width: width * 0.5,
                                        borderRadius: 0,
                                        borderColor: CustomColors.green,
                                        onPressed: () => communityC.askToJoin(),
                                        icon: communityC.sendingJoinRequest
                                            ? Icons.loop
                                            : Icons.app_registration,
                                        enabled: !communityC.sendingJoinRequest,
                                        useGradient: false,
                                        circleIcon: false,
                                        color: CustomColors.green,
                                        label: communityC.sendingJoinRequest
                                            ? "Loading..."
                                            : 'Ask To Join')
                                ],
                              ))
                        ],
                      );
              }),
            )
          : Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  leadingWidth: 8.w,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: NextButton(
                      iconSize: 3,
                      onPressed: () => Get.back(),
                      icon: Icons.arrow_back_ios_rounded,
                    ),
                  )),
              backgroundColor: Colors.grey.shade100,
              body: Column(
                children: [
                  Expanded(
                    flex: 25,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CachedNetworkImage(
                                width: width,
                                height: height * 0.4,
                                imageUrl:
                                    'https://www.thenews.com.pk/assets/uploads/akhbar/2020-01-26/604335_063214_updates.jpg',
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  child: Icon(Icons.person),
                                  radius: 40.0,
                                ),
                              ),
                              Container(
                                width: width,
                                height: height * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: [Colors.black, Colors.transparent],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: CustomColors.red.withOpacity(0.5),
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Community name',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Members',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.30,
                                      height: width * 0.06,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          if (index == 3 - 1) {
                                            // check if this is the last item
                                            return Container(
                                              alignment: Alignment.center,
                                              width: width * 0.06,
                                              height: width * 0.06,
                                              decoration: BoxDecoration(
                                                color: CustomColors.red,
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: Text(
                                                '+20',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge,
                                              ),
                                            );
                                          } else {
                                            return CachedNetworkImage(
                                              width: width * 0.06,
                                              height: width * 0.06,
                                              imageUrl:
                                                  'https://gitlab.com/uploads/-/system/user/avatar/56386/tt_avatar_small.jpg',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      SizedBox(
                                                width: width * 0.1,
                                                child: CircleAvatar(
                                                  backgroundImage:
                                                      imageProvider,
                                                  radius: 40,
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      CircleAvatar(
                                                child: Icon(Icons.person),
                                                radius: 40.0,
                                              ),
                                            );
                                          }
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            width: width * 0.02,
                                          );
                                        },
                                        itemCount: 3,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Our Events',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                        'see all',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                EventSlider(
                                  events: [
                                    // EventWidget(
                                    //   width: width,iconSize: 3,
                                    //   height: height * 0.27,
                                    //   whiteLayer: false,
                                    //   showDetails: true,
                                    //   image: 'assets/images/evp.png',
                                    // )
                                  ],
                                  width: width,
                                  height: height * 0.2,
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Admins',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                        'see all',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   width: width,
                                //   height: height * 0.17,
                                //   child: ListView.builder(
                                //       scrollDirection: Axis.horizontal,
                                //       itemBuilder: (context, index) {
                                //         return Padding(
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 5.0),
                                //           child: CommunityAdminWidget(
                                //               width: width * 0.27,
                                //               height: height * 0.17,
                                //               name: 'Mahmoud'),
                                //         );
                                //       },
                                //       itemCount: 3),
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About Us',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          CustomButton(
                              height: height * 0.07,
                              width: width * 0.5,
                              iconSize: 3,
                              borderRadius: 0,
                              onPressed: () {},
                              useGradient: false,
                              circleIcon: false,
                              borderColor: CustomColors.red,
                              icon: Icons.call,
                              label: 'Contact'),
                          CustomButton(
                              height: height * 0.07,
                              width: width * 0.5,
                              borderRadius: 0,
                              iconSize: 3,
                              borderColor: CustomColors.green,
                              onPressed: () {},
                              icon: Icons.app_registration,
                              useGradient: false,
                              circleIcon: false,
                              color: CustomColors.green,
                              label: 'Ask To Join')
                        ],
                      ))
                ],
              ),
            );
    });
  }
}
