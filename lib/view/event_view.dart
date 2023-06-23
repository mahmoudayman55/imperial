import 'package:carousel_slider/carousel_slider.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperial/community_module/presentation/controller/community_controller.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';
import 'package:imperial/core/utils/custom_url_luncher.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:sizer/sizer.dart';
import 'package:imperial/view/event_view_tabs/attendes_tab.dart';
import 'package:imperial/view/event_view_tabs/details_tab.dart';
import 'package:imperial/view/event_view_tabs/rules_tab.dart';
import 'package:imperial/widgets/custom_button.dart';
import '../core/utils/custom_colors.dart';
import '../widgets/community_admin_widget.dart';
import '../widgets/event_slider.dart';
import '../widgets/event_widget.dart';
import '../widgets/onBoarding_next_Button.dart';
import 'package:intl/intl.dart';

class EventView extends StatelessWidget {
// final eventController=Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      final double height = 100.h;
      final double width = 100.w;
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
                      iconSize: 5,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icons.arrow_back_ios_rounded,
                    ),
                  )),
              backgroundColor: Colors.grey.shade100,
              body: GetBuilder<EventController>(builder: (controller) {
                return SizedBox(
                  height: height,
                  child: controller.gettingEvent
                      ? LoadingScreen(width * 0.1)
                      : Column(
                          children: [
                            Expanded(
                              flex: 14,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.red,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            color: Colors.red,
                                            width: width,
                                            height: height * 0.3,
                                            child: CarouselSlider(
                                              items: controller
                                                  .selectedEvent.eventCovers
                                                  .map((e) =>
                                                      CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          height: height * 0.3,
                                                          width: width,
                                                          imageUrl: e.coverUrl))
                                                  .toList(),
                                              options: CarouselOptions(
                                                aspectRatio: 4,
                                                height: height,
                                                autoPlay: true,
                                                viewportFraction: 1.0,
                                                enlargeCenterPage: false,
                                                onPageChanged: (index, r) =>
                                                    controller
                                                        .onCoverChanged(index),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: controller
                                                  .selectedEvent.eventCovers
                                                  .map((image) {
                                                int index = controller
                                                    .selectedEvent.eventCovers
                                                    .indexOf(image);
                                                return Container(
                                                  width: width * 0.03,
                                                  height: width * 0.03,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 2.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: controller
                                                                .currentEventCover ==
                                                            index
                                                        ? CustomColors.red
                                                        : Colors.white,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .selectedEvent.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    RichText(
                                                        text:
                                                            TextSpan(children: [
                                                      TextSpan(
                                                          text: 'organized by ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey)),
                                                      TextSpan(
                                                          text: (controller
                                                              .selectedEvent
                                                              .community
                                                              .name),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black)),
                                                    ])),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        const Icon(
                                                            Icons
                                                                .monetization_on_outlined,
                                                            color:
                                                                Colors.amber),
                                                        Text(
                                                          "${controller.selectedEvent.adultTicketPrice} £",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      width: width * 0.1,
                                                      height: height * 0.05,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            controller.getMonthName(
                                                                controller
                                                                    .selectedEvent
                                                                    .appointment
                                                                    .month),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall,
                                                          ),
                                                          Text(
                                                            controller
                                                                .selectedEvent
                                                                .appointment
                                                                .day
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium,
                                                          )
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: CustomColors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        color: Colors
                                                            .grey.shade400),
                                                    Text(
                                                      DateFormat(
                                                              'EEE, MMMM d, y  h:mm a')
                                                          .format(controller
                                                              .selectedEvent
                                                              .appointment),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Colors.grey
                                                            .shade400),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .selectedEvent
                                                              .address,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displaySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        // SizedBox(width: 40.w,
                                                        //   child: Text(
                                                        //     "52-56 Inverness Terrace, London W2 3LB, United Kingdom",
                                                        //     maxLines: 3,
                                                        //     overflow:
                                                        //         TextOverflow.ellipsis,
                                                        //     style: Theme.of(context)
                                                        //         .textTheme
                                                        //         .displaySmall!
                                                        //         .copyWith(
                                                        //             color: Colors.grey),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: Colors.grey.shade300,
                                            height: 1,
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       vertical: 3),
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment
                                          //             .spaceBetween,
                                          //     children: [
                                          //       Row(
                                          //         children: [
                                          //           Icon(
                                          //             Icons.group_outlined,
                                          //             color: Colors.grey,
                                          //             size: 5.w,
                                          //           ),
                                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          ("${controller.selectedEvent.attendees} will be there "),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .displayMedium!
                                                              .copyWith(
                                                                  color:
                                                                      Colors.black),
                                                        ),
                                                        Text(
                                                          ("Available places: ${controller.selectedEvent.maxAttendees-controller.selectedEvent.attendees}"),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .displayMedium!
                                                              .copyWith(
                                                                  color:
                                                                      Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                          //         ],
                                          //       ),
                                          //       controller.selectedEvent
                                          //               .attendees.isEmpty
                                          //           ? InkWell(
                                          //               onTap: () {},
                                          //               child: Text(
                                          //                 "No Attendees yet",
                                          //                 style: Theme.of(
                                          //                         context)
                                          //                     .textTheme
                                          //                     .bodyMedium!
                                          //                     .copyWith(
                                          //                         color:
                                          //                             CustomColors
                                          //                                 .red),
                                          //               ),
                                          //             )
                                          //           : Row(
                                          //               children: [
                                          //                 for (int index = 0;
                                          //                     index < (controller.selectedEvent.attendees.length<4?controller.selectedEvent.attendees.length:4);
                                          //                     index++)
                                          //                   if (index > 2)
                                          //                     Container(
                                          //                       margin: EdgeInsets
                                          //                           .symmetric(
                                          //                               horizontal:
                                          //                                   3),
                                          //                       alignment:
                                          //                           Alignment
                                          //                               .center,
                                          //                       width:
                                          //                           width * 0.1,
                                          //                       height:
                                          //                           width * 0.1,
                                          //                       decoration:
                                          //                           BoxDecoration(
                                          //                         color:
                                          //                             CustomColors
                                          //                                 .red,
                                          //                         borderRadius:
                                          //                             BorderRadius
                                          //                                 .circular(
                                          //                                     50.0),
                                          //                       ),
                                          //                       child: Text(
                                          //                         controller.selectedEvent.attendees
                                          //                                     .length >=
                                          //                                 100
                                          //                             ? "+99"
                                          //                             : "+${controller.selectedEvent.attendees.length - 3}",
                                          //                         style: Theme.of(
                                          //                                 context)
                                          //                             .textTheme
                                          //                             .displayLarge,
                                          //                       ),
                                          //                     )
                                          //                   else
                                          //                     Padding(
                                          //                       padding: const EdgeInsets
                                          //                               .symmetric(
                                          //                           horizontal:
                                          //                               3.0),
                                          //                       child: ClipOval(
                                          //                         child:
                                          //                             CustomCachedNetworkImage(
                                          //                           imageUrl:
                                          //                           controller.selectedEvent.attendees[index].picUrl,
                                          //                           width:
                                          //                               width *
                                          //                                   0.1,
                                          //                           height:
                                          //                               width *
                                          //                                   0.1,
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                 SizedBox(
                                          //                   width: width * 0.02,
                                          //                 ),
                                          //               ],
                                          //             )
                                          //     ],
                                          //   ),
                                          // ),
                                          Container(
                                            color: Colors.grey.shade300,
                                            height: 1,
                                          ),
                                          SizedBox(
                                            height: height * 0.5,
                                            child:
                                                GetBuilder<CommunityController>(
                                                    builder: (c) {
                                              return DefaultTabController(
                                                initialIndex: 0,
                                                length: 3,
                                                child: SizedBox(
                                                  width: width,
                                                  child: Column(
                                                    children: [
                                                      TabBar(
                                                          labelStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displaySmall!
                                                                  .copyWith(
                                                                    color:
                                                                        CustomColors
                                                                            .red,
                                                                  ),
                                                          labelColor:
                                                              CustomColors.red,
                                                          unselectedLabelColor:
                                                              Colors.black,
                                                          unselectedLabelStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displaySmall!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                          indicatorColor:
                                                              CustomColors.red,
                                                          onTap: (index) {},
                                                          tabs: const [
                                                            Tab(
                                                                text:
                                                                    'Details'),
                                                            Tab(
                                                                text:
                                                                    'Instructions'),
                                                            Tab(
                                                              text:
                                                                  'Who Can Attend',
                                                            ),
                                                          ]),
                                                      SizedBox(
                                                        height: height * 0.4,
                                                        child: TabBarView(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          children: [
                                                            SingleChildScrollView(
                                                                child:
                                                                    DetailsTab()),
                                                            SingleChildScrollView(
                                                              child: RulesTab(
                                                                  width: width,
                                                                  height:
                                                                      height),
                                                            ),
                                                            SingleChildScrollView(
                                                              child:
                                                                  AttendesTab(
                                                                width: width,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        CustomButton(
                                            height: height * 0.05,
                                            width: width * 0.5,
                                            borderRadius: 0,
                                            onPressed: () =>
                                                CustomUrlLauncher.launchCallApp(
                                                    controller
                                                        .selectedEvent.phone),
                                            useGradient: false,
                                            circleIcon: false,
                                            borderColor: CustomColors.red,
                                            icon: Icons.call,
                                            label: 'Contact'),
                                        // controller.selectedEvent.maxAttendees ==
                                        //         controller.selectedEvent
                                        //             .attendees.length
                                            // ? SizedBox(
                                            //     width: width * 0.5,
                                            //     child: Text(
                                            //       "Tickets Sold Out!",
                                            //       style: Theme.of(context)
                                            //           .textTheme
                                            //           .bodyMedium!
                                            //           .copyWith(
                                            //               color: Colors.red),
                                            //       textAlign: TextAlign.center,
                                            //     ),
                                            //   )
                                            //:
                                        CustomButton(
                                                height: height * 0.05,
                                                width: width * 0.5,
                                                borderRadius: 0,
                                                borderColor: CustomColors.green,
                                                onPressed: () =>
                                                    controller.showPaymentDialog(
                                                        context, width, height),
                                                icon: Icons
                                                    .confirmation_num_outlined,
                                                useGradient: false,
                                                circleIcon: false,
                                                color: CustomColors.green,
                                                label: 'Buy A Ticket')
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                );
              }),
            )
          : SizedBox();
    });
  }
}

//
//
//
//
// Scaffold(
// extendBodyBehindAppBar: true,
// appBar:AppBar(
// leadingWidth: 8.w,
// shadowColor: Colors.transparent,
// backgroundColor: Colors.transparent,
// elevation: 0,
// leading: Padding(
// padding: EdgeInsets.symmetric(horizontal: 1.w),
// child: NextButton(
// iconSize: 3,
// onPressed: () {},
// icon: Icons.arrow_back_ios_rounded,
// ),
// )),
// backgroundColor: Colors.grey.shade100,
// body: SizedBox(
// height: height,
// child: Column(
// children: [
// Expanded(
// flex: 14,
// child: SingleChildScrollView(
// child: Column(
// children: [
// Container(
// color: Colors.red,
// child: Stack(
// alignment: Alignment.center,
// children: [
// Container(
// color: Colors.red,
// width: width,
// height: height * 0.3,
// child: CarouselSlider(
// items: images
//     .map((e) => CachedNetworkImage(
// fit: BoxFit.cover,
// height: height * 0.3,
// width: width,
// imageUrl: e))
// .toList(),
// options: CarouselOptions(
// aspectRatio: 4,
// height: height,
// autoPlay: true,
// viewportFraction: 1.0,
// enlargeCenterPage: false,
// onPageChanged: (index, r) {
// // setState(() {
// //   current = index;
// // });
// },
// ),
// ),
// ),
// Positioned(
// bottom: 1,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: images.map((image) {
// int index = images.indexOf(image);
// return Container(
// width: width * 0.02,
// height: width * 0.02,
// margin: EdgeInsets.symmetric(
// vertical: 10.0, horizontal: 2.0),
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: current == index
// ? CustomColors.red
//     : Colors.white,
// ),
// );
// }).toList(),
// ),
// ),
// ],
// ),
// ),
// Container(
// padding: EdgeInsets.all(8),
// width: width,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// flex: 8,
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Text(
// 'Event Name',
// style: Theme.of(context)
// .textTheme
//     .headlineLarge!
// .copyWith(color: Colors.black),
// ),
// RichText(
// text: TextSpan(children: [
// TextSpan(
// text: 'organized by ',
// style: Theme.of(context)
// .textTheme
//     .displayMedium!
// .copyWith(color: Colors.grey)),
// TextSpan(
// text: 'Indian Community',
// style: Theme.of(context)
// .textTheme
//     .displayMedium!
// .copyWith(color: Colors.black)),
// ])),
// ],
// ),
// ),
// Expanded(
// flex: 4,
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: [
// Column(
// children: [
// Icon(Icons.monetization_on_outlined,size: 5.w,
// color: Colors.amber),
// Text(
// "20\$",
// style: Theme.of(context)
// .textTheme
//     .displayLarge!
// .copyWith(color: Colors.black),
// )
// ],
// ),
// Container(
// width: width * 0.06,
// height: height * 0.05,
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: [
// Text(
// "JAN",
// style: Theme.of(context)
// .textTheme
//     .displayMedium,
// ),
// Text(
// "12",
// style: Theme.of(context)
// .textTheme
//     .displayLarge,
// )
// ],
// ),
// decoration: BoxDecoration(
// color: CustomColors.red,
// borderRadius:
// BorderRadius.circular(8),
// ),
// ),
// ],
// ),
// )
// ],
// ),
// Padding(
// padding: const EdgeInsets.symmetric(vertical: 15),
// child: Column(
// children: [
// Row(
// children: [
// Icon(Icons.calendar_month_outlined,
// color: Colors.grey.shade400),
// Text(
// "sat, January 25, 2020 at 3:30 PM",
// style: Theme.of(context)
// .textTheme
//     .displayMedium!
// .copyWith(color: Colors.black),
// )
// ],
// ),
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// flex: 4,
// child: Row(
// children: [
// Icon(Icons.location_on_outlined,
// color: Colors.grey.shade400),
// Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Text(
// "London, Hyde Park International",
// style: Theme.of(context)
// .textTheme
//     .displayMedium!
// .copyWith(
// color: Colors.black),
// ),
// SizedBox(width: 40.w,
// child: Text(
// "52-56 Inverness Terrace, London W2 3LB, United Kingdom",
// maxLines: 3,
// overflow:
// TextOverflow.ellipsis,
// style: Theme.of(context)
// .textTheme
//     .displayMedium!
// .copyWith(
// color: Colors.grey),
// ),
// ),
// ],
// )
// ],
// ),
// ),
// Expanded(
// flex: 3,
// child: TextButton(
// onPressed: () {},
// child: Text(
// 'Get Destination',
// style: Theme.of(context)
// .textTheme
//     .displayMedium!
// .copyWith(
// color: CustomColors.red),
// )),
// )
// ],
// ),
// ],
// ),
// ),
// Container(
// color: Colors.grey.shade300,
// height: 1,
// ),
// Padding(
// padding: const EdgeInsets.symmetric(vertical: 3),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Row(
// children: [
// Icon(
// Icons.group_outlined,
// color: Colors.grey,
// size: 5.w,
// ),
// Text(
// "45 are going",
// style: Theme.of(context)
// .textTheme
//     .displayMedium!
// .copyWith(color: Colors.black),
// ),
// ],
// ),
// SizedBox(
// width: width * 0.30,
// height: width * 0.06,
// child: ListView.separated(
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// if (index == 3 - 1) {
// // check if this is the last item
// return Container(
// alignment: Alignment.center,
// width: width * 0.06,
// height: width*0.06,
// decoration: BoxDecoration(
// color: CustomColors.red,
// borderRadius:
// BorderRadius.circular(50.0),
// ),
// child: Text(
// '+20',
// style: Theme.of(context)
//     .textTheme
//     .displayLarge,
// ),
// );
// } else {
// return CachedNetworkImage(
// width: width * 0.06,
// height: width * 0.06,
// imageUrl:
// 'https://gitlab.com/uploads/-/system/user/avatar/56386/tt_avatar_small.jpg',
// imageBuilder:
// (context, imageProvider) =>
// SizedBox(
// width: width * 0.1,
// child: CircleAvatar(
// backgroundImage: imageProvider,
// radius: 40,
// ),
// ),
// placeholder: (context, url) =>
// CircularProgressIndicator(),
// errorWidget:
// (context, url, error) =>
// CircleAvatar(
// child: Icon(Icons.person),
// radius: 40.0,
// ),
// );
// }
// },
// separatorBuilder: (context, index) {
// return SizedBox(
// width: width * 0.02,
// );
// },
// itemCount: 3,
// ),
// ),
// ],
// ),
// ),
// Container(
// color: Colors.grey.shade300,
// height: 1,
// ),
// SizedBox(
// height: height * 0.5,
// child: DefaultTabController(
// initialIndex: 1,
// length: 3,
// child: Scaffold(
// backgroundColor: Colors.grey.shade100,
// body: Column(
// children: [
// TabBar(
// labelStyle: Theme.of(context)
// .textTheme
//     .displaySmall!
// .copyWith(
// color: CustomColors.red),
// labelColor: CustomColors.red,
// unselectedLabelColor: Colors.black,
// unselectedLabelStyle:
// Theme.of(context)
// .textTheme
//     .displaySmall!
// .copyWith(
// color: Colors.black),
// indicatorColor: CustomColors.red,
// onTap: (index) {},
// tabs: [
// Tab(text: 'Details'),
// Tab(text: 'Rules'),
// Tab(
// text: 'Who Can Attend',
// ),
// ]),
// SizedBox(
// height: height * 0.4,
// child: TabBarView(
// children: [
// DetailsTab(),
// RulesTab(
// width: width, height: height),
// AttendesTab(
// width: width, height: height),
// ],
// ),
// ),
// ],
// )),
// ),
// )
// ],
// ),
// ),
// ],
// ),
// ),
// ),
// Expanded(
// flex: 1,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Row(
// children: [
// CustomButton(
// height: height * 0.05,
// width: width * 0.5,
// borderRadius: 0,
// onPressed: () {},
// useGradient: false,
// circleIcon: false,
// borderColor: CustomColors.red,
// icon: Icons.call,
// label: 'Contact'),
// CustomButton(
// height: height * 0.05,
// width: width * 0.5,
// borderRadius: 0,
// borderColor: CustomColors.green,
// onPressed: () {},
// icon: Icons.confirmation_num_outlined,
// useGradient: false,
// circleIcon: false,
// color: CustomColors.green,
// label: 'Buy A Ticket')
// ],
// ),
// ],
// ))
// ],
// ),
// ),
// );
