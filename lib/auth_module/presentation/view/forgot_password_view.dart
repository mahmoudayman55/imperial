import 'dart:ui';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperial/auth_module/presentation/controller/auth_controller.dart';
import 'package:imperial/auth_module/presentation/controller/reset_password_controller.dart';
import 'package:imperial/auth_module/presentation/view/registration/choose_account%20type.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:imperial/widgets/sign_with_button.dart';
import 'package:imperial/widgets/swipe_up_button.dart';
import 'package:sizer/sizer.dart';
import '../../../core/utils/custom_colors.dart';
import '../../../widgets/custom_password_field.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      double height = 100.h;
      double width = 100.w;
      bool _onEditing = false;
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
                          child: GetBuilder<ResetPasswordController>(
                              init: ResetPasswordController(),
                              builder: (controller) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                      canvasColor:
                                          Colors.white.withOpacity(0.3),
                                      colorScheme: Theme.of(context)
                                          .colorScheme
                                          .copyWith(
                                              background:
                                                  Colors.white.withOpacity(0.3),
                                              onBackground: Colors.white
                                                  .withOpacity(0.3))),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stepper(
                                        margin: EdgeInsets.zero,
                                        elevation: 0,
                                        controlsBuilder: (context, controls) {
                                          return SizedBox();
                                        },
                                        type: StepperType.horizontal,
                                        currentStep: controller.currentStep,
                                        steps: [
                                          Step(
                                              isActive:
                                                  controller.currentStep >= 0,
                                              content: Form(
                                                key: controller.emailFormKey,
                                                child: SizedBox(
                                                  height: height * 0.3,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "Please enter your email",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium
                                                            ,
                                                      ),
                                                      CustomTextFormField(
                                                        controller: controller
                                                            .emailController,
                                                        validator: (v) {
                                                          if (!EmailValidator
                                                              .validate(controller
                                                                  .emailController
                                                                  .text)) {
                                                            return "invalid email";
                                                          }
                                                          return null;
                                                        },
                                                        context: context,
                                                        label: "Email",
                                                        textColor: Colors.white,
                                                      ),
                                                      CustomButton(
                                                          height: height * 0.06,
                                                          width: width,enabled: !controller.loading,
                                                          onPressed: () =>
                                                              controller
                                                                  .getResetCode(),
                                                          label:controller.loading?"Loading...": "Next")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: controller
                                                                    .currentStep >=
                                                                0
                                                            ? CustomColors.red
                                                            : Colors.black87),
                                              )),
                                          Step(
                                              isActive:
                                                  controller.currentStep >= 1,
                                              title: Text(
                                                "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: controller
                                                                    .currentStep >=
                                                                1
                                                            ? CustomColors.red
                                                            : Colors.black87),
                                              ),
                                              content: SizedBox(
                                                height: height *0.4,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Enter code of 6 digits that you received on your email",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium
                                                      ,textAlign: TextAlign.center,
                                                    ),
                                                    VerificationCode(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .displayLarge!
                                                          .copyWith(
                                                              color:
                                                                  CustomColors
                                                                      .red),
                                                      keyboardType:
                                                          TextInputType.text,

                                                      underlineColor:
                                                          CustomColors.red,
                                                      underlineUnfocusedColor:
                                                          Colors.white,
                                                      // If this is null it will use primaryColor: Colors.red from Theme
                                                      length: 6,
                                                      cursorColor:
                                                          CustomColors.red,
                                                      // If this is null it will default to the ambient
                                                      // clearAll is NOT required, you can delete it
                                                      // takes any widget, so you can implement your design
                                                      clearAll: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'clear all',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color:
                                                                      CustomColors
                                                                          .red),
                                                        ),
                                                      ),

                                                      onEditing: (bool value) {
                                                        _onEditing = value;

                                                        if (!_onEditing)
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                      },
                                                      onCompleted:
                                                          (String value) {
                                                        controller
                                                            .verifyResetCode(
                                                                value);
                                                      },
                                                    ),
                                                    Text(
                                                      "If you did not find the email, please check your spam folder ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall
                                                      ,textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Step(
                                              isActive:
                                                  controller.currentStep >= 2,
                                              title: Text(
                                                "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: controller
                                                                    .currentStep >=
                                                                2
                                                            ? CustomColors.red
                                                            : Colors.black87),
                                              ),
                                              content: Form(
                                                key: controller
                                                    .newPasswordFormKey,
                                                child: SizedBox(
                                                  height: height * 0.3,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      CustomPasswordField(
                                                        controller: controller
                                                            .passwordController,
                                                        label: "New password",
                                                        validator: (v) {
                                                          if (controller
                                                              .passwordController
                                                              .text
                                                              .isEmpty) {
                                                            return "this field cannot be empty";
                                                          } else if (controller
                                                                  .passwordController
                                                                  .text
                                                                  .length <
                                                              8) {
                                                            return "Your password must be at least 8 characters long";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      CustomPasswordField(
                                                        controller: controller
                                                            .confirmPasswordController,
                                                        label:
                                                            "Confirm new password",
                                                        validator: (v) {
                                                          if (controller
                                                              .passwordController
                                                              .text
                                                              .isEmpty) {
                                                            return "this field cannot be empty";
                                                          } else if (controller
                                                                  .passwordController
                                                                  .text
                                                                  .length <
                                                              8) {
                                                            return "Your password must be at least 8 characters long";
                                                          } else if (controller
                                                                  .passwordController
                                                                  .text !=
                                                              controller
                                                                  .confirmPasswordController
                                                                  .text) {
                                                            return "Passwords do not match";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      CustomButton(
                                                          height: height * 0.06,
                                                          width: width,enabled: !controller.loading,
                                                          onPressed: () =>
                                                              controller
                                                                  .changePassword(),
                                                          label:
                                                          controller.loading?"Loading...":"Reset Password")
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ]),
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
          : SizedBox(
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
                        width: 60.w,
                        height: height,
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child:
                              GetBuilder<AuthController>(builder: (controller) {
                            return Form(
                              key: controller.loginFormKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(3.w),
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                    child: Column(
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
                                                        .userEmailController
                                                        .text)) {
                                              return "invalid email";
                                            }
                                            return null;
                                          },
                                          controller: controller
                                              .userLoginEmailController,
                                          context: context,
                                          label: "Email",
                                          textColor: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 3.w,
                                        ),
                                        CustomPasswordField(
                                          label: 'Password',
                                          controller: controller
                                              .loginPasswordController,
                                          validator: (value) {
                                            if (controller
                                                .loginPasswordController
                                                .text
                                                .isEmpty) {
                                              return 'Please enter a password';
                                            }
                                            if (controller
                                                    .loginPasswordController
                                                    .text
                                                    .length <
                                                6) {
                                              return 'Password must be at least 6 characters long';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomButton(
                                    height: 5.h,
                                    width: 50.w,
                                    label: "Log in",
                                    onPressed: () {},
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
                                              padding: EdgeInsets.all(0)),
                                          onPressed: () =>
                                              Get.to(ChooseAccountView()),
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
            );
    });
  }
}
