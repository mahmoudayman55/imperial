import 'dart:developer';
import 'package:imperial/auth_module/presentation/controller/change_current_password_controller.dart';
import 'package:imperial/widgets/custom_password_field.dart';
import 'package:libphonenumber/libphonenumber.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:imperial/auth_module/presentation/controller/auth_controller.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import '../core/utils/custom_colors.dart';
import '../core/utils/uk_number_validator.dart';
import '../widgets/community_admin_widget.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/event_slider.dart';
import '../widgets/event_widget.dart';
import '../widgets/onBoarding_next_Button.dart';
import 'package:get/get.dart';

class UserProfileView extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      double width = 100.w;
      double height = 100.h;
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NextButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icons.arrow_back_ios_rounded,
              ),
            )),
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: GetBuilder<AuthController>(builder: (c) {
            return authController.loadingAppInit ||
                    authController.updatingUserInfo
                ? SizedBox(
                    width: width,
                    height: height,
                    child: Center(child: LoadingScreen(width * 0.1)))
                : Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomCachedNetworkImage(
                              imageUrl: authController.currentUser!.coverPicUrl,
                              width: width,
                              height: height * 0.3),
                          Container(
                            width: width,
                            height: height * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                colors: [Colors.black, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () => authController.updateCoverPic(),
                              child: Container(
                                width: width,
                                height: width * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: Icon(
                                  Icons.camera_enhance_outlined,
                                  size: width * 0.06,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipOval(
                                      child: CustomCachedNetworkImage(
                                        imageUrl:
                                            authController.currentUser!.picUrl,
                                        width: width * 0.3,
                                        height: width * 0.3,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () => authController.updatePic(),
                                        child: Container(
                                          width: width * 0.08,
                                          height: width * 0.08,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: width * 0.06,
                                            color: CustomColors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  authController.currentUser!.name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: height,
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: authController.profileFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: authController
                                                        .currentUser!.community ==
                                                    null
                                                ? "Not Member Of Any Community"
                                                : '${authController.currentUser!.role} of ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: authController
                                                                .currentUser!
                                                                .community ==
                                                            null
                                                        ? Colors.red
                                                        : Colors.grey)),
                                        TextSpan(
                                            text: authController
                                                        .currentUser!.community ==
                                                    null
                                                ? ""
                                                : authController
                                                    .currentUser!.community!.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(color: Colors.black)),
                                      ])),
                                    ),Align(
                                      alignment: Alignment.topCenter,
                                      child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: authController
                                                    .currentUser!.speakingLanguage!.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                    color: Colors.grey)),
                                            TextSpan(
                                                text: " speaker",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(color: Colors.black)),
                                          ])),
                                    )
                                  ],
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: CustomTextFormField(
                                  controller:
                                      authController.profileUserNameController,
                                  context: context,
                                  label: "User Name",
                                  labelColor: Colors.black,
                                  textColor: Colors.black,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomTextFormField(keyboardType: TextInputType.emailAddress,
                                  context: context,
                                  label: "Email",
                                  labelColor: Colors.black,
                                  controller:
                                      authController.profileUserEmailController,
                                  textColor: Colors.black,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomTextFormField(
                                  controller:
                                      authController.profileZipController,
                                  context: context,
                                  label: "Zip",
                                  labelColor: Colors.black,
                                  textColor: Colors.black,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(flex: 2,
                                      child: Container(alignment: Alignment.topCenter,
                                        height: height*0.06,
                                        child: Text(
                                          "+44",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 10,
                                      child: CustomTextFormField(keyboardType: TextInputType.phone,
                                        controller: authController
                                            .profilePhoneController,
                                        context: context,
                                        label: "phone",
                                        labelColor: Colors.black,
                                        textColor: Colors.black,
                                        color: Colors.grey,
                                        validator: (v) {
                                          if (!isUkPhoneNumber(
                                             "+44${authController
                                                  .profilePhoneController
                                                  .text}")) {
                                            return "invalid phone number";
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomDropdownWidget(
                                    initialValue:
                                        authController.profileSelectedGroupAge,
                                    label: 'Group Age',
                                    dark: true,
                                    items: authController.groupAges,
                                    onChanged: (item) => authController
                                        .onProfileGroupAgeChanged(item)),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomDropdownWidget(
                                    initialValue:
                                        authController.profileSelectedRegion,
                                    label: 'Region',
                                    dark: true,
                                    items: authController.regions,
                                    onChanged: (item) => authController
                                        .onProfileRegionChanged(item)),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomDropdownWidget(
                                    initialValue:
                                        authController.profileSelectedCity,
                                    label: 'City',
                                    items: authController.cities,
                                    dark: true,
                                    onChanged: (item) => authController
                                        .onProfileCityChanged(item)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (c) {
                                            return Dialog(
                                              child: GetBuilder<AuthController>(
                                                  builder: (passController) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    height: height * 0.4,
                                                    child: Form(
                                                      key: passController
                                                          .changePasswordFrom,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          CustomPasswordField(color: Colors.grey,
                                                              labelColor: Colors.black,

                                                              validator: (v) {
                                                                if (passController
                                                                    .currentPasswordController
                                                                    .text
                                                                    .isEmpty) {
                                                                  return "this field cannot be empty";
                                                                } else if (passController
                                                                        .currentPasswordController
                                                                        .text
                                                                        .length <
                                                                    8) {
                                                                  return "Your password must be at least 8 characters long";
                                                                }
                                                                return null;
                                                              },
                                                              controller:
                                                                  passController
                                                                      .currentPasswordController,
                                                              label:
                                                                  "Current Password"),
                                                          CustomPasswordField(color: Colors.grey,
                                                              labelColor:
                                                                  Colors.black,
                                                              validator: (v) {
                                                                if (passController
                                                                    .newPasswordController
                                                                    .text
                                                                    .isEmpty) {
                                                                  return "this field cannot be empty";
                                                                } else if (passController
                                                                        .newPasswordController
                                                                        .text
                                                                        .length <
                                                                    8) {
                                                                  return "Your password must be at least 8 characters long";
                                                                }
                                                                return null;
                                                              },
                                                              controller:
                                                                  passController
                                                                      .newPasswordController,
                                                              label:
                                                                  "New Password"),
                                                          CustomPasswordField(color: Colors.grey,
                                                              labelColor:
                                                                  Colors.black,
                                                              validator: (v) {
                                                                if (passController
                                                                    .confirmNewPasswordController
                                                                    .text
                                                                    .isEmpty) {
                                                                  return "this field cannot be empty";
                                                                } else if (passController
                                                                        .confirmNewPasswordController
                                                                        .text
                                                                        .length <
                                                                    8) {
                                                                  return "Your password must be at least 8 characters long";
                                                                } else if (passController
                                                                        .confirmNewPasswordController
                                                                        .text !=
                                                                    passController
                                                                        .newPasswordController
                                                                        .text) {
                                                                  return "Passwords do not match";
                                                                }
                                                                return null;
                                                              },
                                                              controller:
                                                                  passController
                                                                      .confirmNewPasswordController,
                                                              label:
                                                                  "Confirm Password"),
                                                          CustomButton(
                                                              useGradient:
                                                                  false,
                                                              height:
                                                                  height * 0.06,
                                                              width: width,
                                                              onPressed: () =>
                                                                  passController
                                                                      .changePassword(),
                                                              label:
                                                                  "Change password")
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            );
                                          });
                                    },
                                    child: Text(
                                      'Change Password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(color: CustomColors.red),
                                    )),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: CustomButton(
                                    height: height * 0.03,
                                    width: width,
                                    onPressed: () =>
                                        authController.updateUser(),
                                    label: 'Update',
                                    useGradient: false,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          }),
        ),
      );
    });
  }
}
