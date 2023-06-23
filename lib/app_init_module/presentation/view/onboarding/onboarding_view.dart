import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:imperial/app_init_module/presentation/controller/on_boarding_controller.dart';
import 'package:imperial/core/utils/custom_colors.dart';
import 'package:imperial/auth_module/presentation/view/login.dart';
import 'package:imperial/view/home_view.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/onBoarding_next_Button.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../view/loading_screen.dart';
import '../../../../widgets/error_widget.dart';
import 'intro_screen1.dart';
import 'intro_screen2.dart';

class OnBoardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    return GetBuilder<OnBoardingController>(builder: (controller) {
      return Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          double height =100.h;
          double width =100.w;
          return deviceType == DeviceType.mobile
              ? Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/bg.jpg',
                        fit: BoxFit.cover,
                      ),
                      controller.loading
                          ? LoadingScreen(width * 0.1)
                          : (controller.networkError
                              ?CustomErrorWidget(onPressed: ()=>controller.getOnBoardsData(), message: "Connection Error")
                              : Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Colors.black,
                                        Colors.transparent
                                      ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter)),
                                  child: Stack(children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      alignment: Alignment.bottomCenter,
                                      height: height,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 15,
                                            child: PageView(
                                              onPageChanged: (value) =>
                                                  controller
                                                      .updateCurrentPage(value),
                                              controller:
                                                  controller.pageController,
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        controller
                                                            .onBoards.length;
                                                    i++)
                                                  IntroScreen(
                                                    label: controller
                                                        .onBoards[i].title,
                                                    details: controller
                                                        .onBoards[i].content, height: height, width: width,
                                                  ),
                                                onBoardingRegions(),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    onPressed: () => controller
                                                        .updateCurrentPage(
                                                            controller.onBoards
                                                                    .length +
                                                                1),
                                                    child: Text(
                                                      controller.currentPage !=
                                                              controller
                                                                  .onBoards
                                                                  .length
                                                          ? 'Skip'
                                                          : '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    )),
                                                SmoothPageIndicator(
                                                  controller:
                                                      controller.pageController,
                                                  count: controller
                                                          .onBoards.length +
                                                      1,
                                                  effect: ExpandingDotsEffect(
                                                    dotColor: Colors.white,
                                                    activeDotColor:
                                                        CustomColors.red,
                                                  ),
                                                ),
                                                controller.currentPage ==
                                                        controller
                                                            .onBoards.length
                                                    ? NextButton(
                                                        onPressed: () {
                                                          controller. submit();
                                                        },
                                                        icon: Icons.done,
                                                        color:
                                                            CustomColors.green,
                                                      )
                                                    : NextButton(onPressed: () {
                                                        controller
                                                            .pageController
                                                            .nextPage(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        200),
                                                                curve: Curves
                                                                    .easeInOut);
                                                      }),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                )),
                    ],
                  ))
              : Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/bg.jpg',
                        fit: BoxFit.cover,
                      ),
                      controller.loading
                          ? LoadingScreen(width * 0.1)
                          : Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    Colors.black,
                                    Colors.transparent
                                  ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter)),
                              child: Stack(children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.bottomCenter,
                                  height: height,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 20,
                                        child: PageView(
                                          onPageChanged: (value) => controller
                                              .updateCurrentPage(value),
                                          controller: controller.pageController,
                                          children: [
                                            for (int i = 0;
                                                i < controller.onBoards.length;
                                                i++)
                                              IntroScreen(
                                                label: controller
                                                    .onBoards[i].title,
                                                details: controller
                                                    .onBoards[i].content, height: height, width: width,
                                              ),
                                            onBoardingRegions(),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                onPressed: () => controller
                                                    .updateCurrentPage(
                                                        controller.onBoards
                                                                .length +
                                                            1),
                                                child: Text(
                                                  controller.currentPage !=
                                                          controller
                                                              .onBoards.length
                                                      ? 'Skip'
                                                      : '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge!
                                                      .copyWith(
                                                          color: Colors.white),
                                                )),
                                            SmoothPageIndicator(
                                              controller:
                                                  controller.pageController,
                                              count:
                                                  controller.onBoards.length +
                                                      1,
                                              effect: ExpandingDotsEffect(
                                                dotColor: Colors.white,
                                                activeDotColor:
                                                    CustomColors.red,
                                              ),
                                            ),
                                            controller.currentPage ==
                                                    controller.onBoards.length
                                                ? NextButton(
                                                    iconSize: 3,
                                                    onPressed: () {
                                                      controller. submit();
                                                    },
                                                    icon: Icons.done,
                                                    color: CustomColors.green,
                                                  )
                                                : NextButton(
                                                    iconSize: 3,
                                                    onPressed: () {
                                                      controller.pageController
                                                          .nextPage(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      200),
                                                              curve: Curves
                                                                  .easeInOut);
                                                    }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                    ],
                  ));
        },
      );
    });
  }
}

/// todo: tablet:
//  Scaffold(
//                     body: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.asset(
//                         'assets/images/bg.jpg',
//                         fit: BoxFit.cover,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 colors: [Colors.black, Colors.transparent],
//                                 begin: Alignment.bottomCenter,
//                                 end: Alignment.topCenter)),
//                         child: Stack(children: [
//                           Container(
//                             padding: EdgeInsets.all(1.w),
//                             alignment: Alignment.bottomCenter,
//                             height: 100.h,
//                             child: Column(
//                               children: [
//                                 Expanded(flex: 20,
//                                   child: PageView(
//                                     onPageChanged: (value) => setState(() {
//                                       currentPage = value;
//                                     }),
//                                     controller: _controller,
//                                     children: [
//                                       IntroScreen(
//                                         label: 'Join Your Community!',
//                                         details:
//                                         'imperial will help you to meet members of your community in the UK and attend various events with them',
//                                       ),
//                                       IntroScreen(
//                                         label: 'Join Your Community!',
//                                         details:
//                                         'imperial will help you to meet members of your community in the UK and attend various events with them',
//                                       ),
//
//                                       onBoardingRegions(),
//                                     ],
//                                   ),
//                                 ),Expanded(flex: 1,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       TextButton(
//                                           onPressed: () {
//                                             _controller.jumpToPage(controller.onBoards.length+1);
//                                           },
//                                           child: Text(
//                                             currentPage != 2 ? 'Skip' : '',
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .displayLarge!
//                                                 .copyWith(color: Colors.white),
//                                           )),
//                                       SmoothPageIndicator(
//                                         controller: _controller,
//                                         count: controller.onBoards.length+1,
//                                         effect: ExpandingDotsEffect(
//                                           dotColor: Colors.white,
//                                           activeDotColor: CustomColors.red,
//                                         ),
//                                       ),
//                                       TextButton(
//                                           onPressed: currentPage == controller.onBoards.length+1
//                                               ? () {
//                                             // Boxes.onBoardingBox().put(1, true);
//                                             // Get.offAll(HomeView());
//                                           }
//                                               : () {
//                                             _controller.nextPage(
//                                                 duration:
//                                                 Duration(milliseconds: 200),
//                                                 curve: Curves.easeInOut);
//                                           },
//                                           child: currentPage == controller.onBoards.length+1
//                                               ? NextButton(iconSize: 3,
//                                             onPressed: () {
//                                               Get.to(HomeView());
//                                             },
//                                             icon: Icons.done,
//                                             color: CustomColors.green,
//                                           )
//                                               : NextButton(iconSize: 3,onPressed: () {
//                                             setState(() {
//                                               _controller.nextPage(
//                                                   duration:
//                                                   Duration(milliseconds: 200),
//                                                   curve: Curves.easeInOut);
//                                             });
//                                           })),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                         ]),
//                       ),
//                     ],
//                   ));
