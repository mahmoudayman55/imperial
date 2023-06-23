// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:imperial/widgets/custom_button.dart';
// import 'package:imperial/widgets/custom_text_form_field.dart';
// import 'package:imperial/widgets/sign_with_button.dart';
// import 'package:imperial/widgets/swipe_up_button.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../core/utils/custom_colors.dart';
//
// class RegisterView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
//      final double width = 100.w;
//       final double height = 100.h;
//
//       return Scaffold(
//         backgroundColor: Colors.grey.shade100,
//         body: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.asset(
//               'assets/images/authbg.jpg',
//               fit: BoxFit.cover,
//             ),
//             BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//               child: Container(
//                 width: width,
//                 height: height,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.black, Colors.transparent],
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                   ),
//                 ),
//               ),
//             ),
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(padding: EdgeInsets.all(50),child:  Image.asset(
//                       'assets/images/logo.png',
//                       fit: BoxFit.cover,
//                     ),),
//                     CustomTextFormField(context: context, label:"Email",textColor: Colors.white,),
//                     CustomTextFormField(context: context, label:"Email",textColor: Colors.white,),
//                     Row(mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SocialMediaButton(onPressed: (){}),                  SocialMediaButton(onPressed: (){},icon: 'google'),
//                       ],
//                     ),
//                     CustomButton(height: height*0.06, width: width*0.8, label: "Log in", onPressed: (){},),
//                     SwipeAppArrow(onSwipe: (){})
//
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
