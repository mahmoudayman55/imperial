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
import 'package:imperial/community_module/presentation/view/event_view_tabs/attendes_tab.dart';
import 'package:imperial/community_module/presentation/view/event_view_tabs/details_tab.dart';
import 'package:imperial/community_module/presentation/view/event_view_tabs/rules_tab.dart';
import 'package:imperial/widgets/custom_button.dart';
import '../core/utils/custom_colors.dart';
import '../widgets/community_admin_widget.dart';
import '../widgets/event_slider.dart';
import '../widgets/event_widget.dart';
import '../widgets/onBoarding_next_Button.dart';
// import 'package:intl/intl.dart';
//
// class AppUpdateView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, deviceType) {
//       final double height = 100.h;
//       final double width = 100.w;
//       return deviceType == DeviceType.mobile
//           ? Scaffold(
//               extendBodyBehindAppBar: true,
//               backgroundColor: Colors.grey.shade100,
//               body: GetBuilder<EventController>(builder: (controller) {
//                 return SizedBox(
//                   height: height,
//                   child: Column(
//                     children: [
//                       Text(
//                         "New update available",
//                         style: Theme.of(context).textTheme.displayMedium,
//                       ),
//                       Row(
//                         children: [
//                           CustomButton(useGradient: false,
//                               height: height * 0.06,
//                               width: width * 0.4,
//                               onPressed: () {},
//                               label: "Update"),
//                                  CustomButton(useGradient: false,
//                               height: height * 0.06,
//                               width: width * 0.4,
//                               onPressed: () {},
//                               label: "Not Now"),
//
//                         ],
//                       )
//                     ],
//                   ),
//                 );
//               }),
//             )
//           : SizedBox();
//     });
//   }
// }

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
