import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperial/auth_module/presentation/controller/user_join_requests_controller.dart';
import 'package:imperial/auth_module/presentation/controller/login_controller.dart';
import 'package:imperial/auth_module/presentation/view/registration/choose_account%20type.dart';
import 'package:imperial/core/utils/app_constants.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:imperial/widgets/sign_with_button.dart';
import 'package:imperial/widgets/swipe_up_button.dart';
import 'package:sizer/sizer.dart';
import '../../../core/utils/custom_colors.dart';
import '../../../widgets/custom_password_field.dart';
import 'forgot_password_view.dart';

class LogInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      double height = 100.h;
      double width = 100.w;
      return deviceType == DeviceType.mobile
          ? SizedBox(
              width: width,
              height: height,
              child: Scaffold(
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
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: Padding(
                          padding: EdgeInsets.all(0.03 * width),
                          child:
                              GetBuilder<LoginController>(builder: (controller) {
                            return Form(
                              key: controller.loginFormKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.cover,
                                    width: width*0.6,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomTextFormField(
                                        validator: (v) {
                                          if (controller
                                                  .userLoginEmailController
                                                  .text
                                                  .isEmpty ||
                                              !EmailValidator.validate(
                                                  controller
                                                      .userLoginEmailController
                                                      .text)) {
                                            return "invalid email";
                                          }
                                          return null;
                                        },
                                        controller:
                                            controller.userLoginEmailController,
                                        context: context,keyboardType: TextInputType.emailAddress,
                                        label: "Email",
                                        textColor: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 0.03 * width,
                                      ),
                                      CustomPasswordField(
                                        label: 'Password',
                                        controller:
                                            controller.loginPasswordController,
                                        validator: (value) {
                                          if (controller.loginPasswordController
                                              .text.isEmpty) {
                                            return 'Please enter a password';
                                          }
                                          if (controller.loginPasswordController
                                                  .text.length <
                                              6) {
                                            return 'Password must be at least 6 characters long';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CustomButton(
                                        enabled: !controller.loggingIn.value,
                                        height: height * 0.05,
                                        width: width * 0.8,
                                        label: controller.loggingIn.value
                                            ? "Logging you in..."
                                            : "Login",
                                        onPressed: () {
                                          controller.userLogin();
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                            onTap: () {
                                              Get.toNamed( AppConstants.forgotPasswordPage);
                                            },
                                            child: Text(
                                              "Forgot password?",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            )),
                                      )
                                    ],
                                  ),
                                  //
                                  // Text('Or',style: Theme.of(context).textTheme.headlineLarge,),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     SocialMediaButton(onPressed: () {}),
                                  //     SocialMediaButton(onPressed: () {}, icon: 'google'),
                                  //   ],
                                  // ),
                                  //
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Don\'t have account?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero),
                                          onPressed: () =>
                                              Get.toNamed(AppConstants.accountTypePage),
                                          child: Text('Sign up',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      color: CustomColors.red)))
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          :
      ///Todo: tablet
      SizedBox(
              width: width,
              height: height,
            );
    });
  }
}
