// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:imperial/widgets/community_widget.dart';
// import 'package:imperial/widgets/custom_button.dart';
// import 'package:imperial/widgets/custom_text_form_field.dart';
// import 'package:imperial/widgets/event_widget.dart';
// import 'package:imperial/widgets/swipe_up_button.dart';
// import 'package:scaled_list/scaled_list.dart';
// import 'package:widget_slider/widget_slider.dart';
//
// import '../widgets/event_slider.dart';
// import '../widgets/sign_with_button.dart';
// import 'package:get/get.dart';
//
// class WidgetTestingScreen extends StatefulWidget {
//   const WidgetTestingScreen({Key? key}) : super(key: key);
//
//   @override
//   _WidgetTestingScreenState createState() => _WidgetTestingScreenState();
// }
//
// class _WidgetTestingScreenState extends State<WidgetTestingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text('Widget Testing Screen'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: Column(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Upcoming Events',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayLarge!
//                                 .copyWith(color: Colors.black),
//                           ),
//                           Text(
//                             'see all',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // EventSlider(
//                     //   height: Get.height * 0.22,
//                     //   events: [
//                     //     EventWidget(
//                     //       height: Get.height * 0.2,
//                     //       width: Get.width * 0.8,
//                     //     ),
//                     //     EventWidget(
//                     //       height: Get.height * 0.2,
//                     //       width: Get.width * 0.8,
//                     //     ),
//                     //     EventWidget(
//                     //       height: Get.height * 0.2,
//                     //       width: Get.width * 0.8,
//                     //     ),
//                     //   ],
//                     // ),
// EventSlider(events: [], width: Get.width, height: Get.height*0.2,),
//
//                   ],
//                 ),
//                 CommunityWidget(width: Get.width, height: Get.height * 0.25),
//
//               ],
//             ),
//           ),
//         ));
//   }
// }
