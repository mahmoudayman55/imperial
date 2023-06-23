import 'dart:developer';
import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperial/auth_module/presentation/controller/auth_controller.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:imperial/widgets/sign_with_button.dart';
import 'package:imperial/widgets/swipe_up_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../../widgets/custom_password_field.dart';
import '../../../../../widgets/onBoarding_next_Button.dart';
import 'Individual_register_2.dart';

class IndividualRegister1View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder:


        (BuildContext context, Orientation orientation, DeviceType deviceType) {


          final double width = 100.w;
          final double height = 100.h;
      return deviceType == DeviceType.mobile
          ? Scaffold(              extendBodyBehindAppBar: true,

        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NextButton(
              iconSize: 5,
              onPressed:()=> Get.back(),
              icon: Icons.arrow_back_ios_rounded,
            ),
          )),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey.shade100,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/authbg.jpg',
                    fit: BoxFit.cover,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GetBuilder<AuthController>(builder: (controller) {
                        return Form(
                          key: controller.userRegisterPhase1FormKey,
                          child: SizedBox(height: height,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(50),
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.cover,width: width*0.4,
                                  ),
                                ),
                                Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: height*0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomTextFormField(keyboardType: TextInputType.emailAddress,
                                            controller:
                                                controller.userEmailController,
                                            validator: (value) {

                                              if ( controller.userEmailController.text.isEmpty ||
                                                  !EmailValidator.validate(controller.userEmailController.text )) {
                                                return "Invalid email address";
                                              }
                                              return null;
                                            },
                                            context: context,
                                            label: "Email",
                                            textColor: Colors.white,
                                          ),
                                          CustomPasswordField(
                                            label: 'Password',
                                            controller: controller.passwordController,
                                            validator: (value) {
                                              if (controller.passwordController.text == null || controller.passwordController.text.isEmpty) {
                                                return 'Please enter a password';
                                              }
                                              if (controller.passwordController.text.length < 6) {
                                                return 'Password must be at least 6 characters long';
                                              }
                                              return null;
                                            },
                                          ),
                                          CustomPasswordField(
                                            label: 'Confirm Password',
                                            controller:
                                                controller.confirmPasswordController,
                                            validator: (value) {
                                              if (controller.confirmPasswordController.text  == null || controller.confirmPasswordController.text.isEmpty) {
                                                return 'Please enter a password';
                                              }
                                              if (controller.confirmPasswordController.text.length < 6) {
                                                return 'Password must be at least 6 characters long';
                                              }
                                              if (controller.confirmPasswordController.text !=
                                                  controller
                                                      .passwordController.text) {
                                                return "passwords do not match";
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomButton(
                                      height: height*0.06,
                                      width: width*0.8,
                                      label: "Register",
                                      onPressed: () {
                                        controller.userRegisterPhase1Submit();
                                      },
                                    ),
                                  ],
                                ),
                                // Text(
                                //   'Or',
                                //   style:
                                //       Theme.of(context).textTheme.headlineLarge,
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     SocialMediaButton(onPressed: () {}),
                                //     SocialMediaButton(
                                //         onPressed: () {}, icon: 'google'),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox();
    });
  }
}

///Todo: tablet
///Scaffold(resizeToAvoidBottomInset: false,
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
//                 width: 100.w,
//                 height: 100.h,
//                 decoration: const BoxDecoration(
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
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(50),
//                       child: Image.asset(
//                         'assets/images/logo.png',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30.h,
//                       width: 60.w,
//                       child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           CustomTextFormField(
//                             context: context,
//                             label: "Email",
//                             textColor: Colors.white,
//                           ),
//                           CustomPasswordField(
//                             label: 'Password',
//                             controller: _passwordController,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter a password';
//                               }
//                               if (value.length < 6) {
//                                 return 'Password must be at least 6 characters long';
//                               }
//                               return null;
//                             },
//                           ),   CustomPasswordField(
//                             label: 'Confirm Password',
//                             controller: _confirmPasswordController,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter a password';
//                               }
//                               if (value.length < 6) {
//                                 return 'Password must be at least 6 characters long';
//                               }
//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     CustomButton(
//                       height: 6.h,
//                       width: 50.w,
//                       label: "Register", onPressed: (){
//                       Get.to(IndividualRegistration2View());
//
//                     },),
//
//                     Text('Or',style: Theme.of(context).textTheme.headlineLarge,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SocialMediaButton(onPressed: () {}),
//                         SocialMediaButton(onPressed: () {}, icon: 'google'),
//                       ],
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )
