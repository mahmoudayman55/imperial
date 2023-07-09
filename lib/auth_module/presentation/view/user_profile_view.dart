import 'dart:developer';
import 'package:imperial/auth_module/presentation/controller/change_current_password_controller.dart';
import 'package:imperial/widgets/custom_password_field.dart';
import 'package:libphonenumber/libphonenumber.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:imperial/auth_module/presentation/controller/user_join_requests_controller.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import '../../../app_init_module/presentation/controller/region_controller.dart';
import '../controller/change_password_controller.dart';
import '../controller/current_user_controller.dart';
import '../../../core/utils/custom_colors.dart';
import '../../../core/utils/uk_number_validator.dart';
import '../../../widgets/community_admin_widget.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/event_slider.dart';
import '../../../widgets/event_widget.dart';
import '../../../widgets/onBoarding_next_Button.dart';
import 'package:get/get.dart';

class UserProfileView extends StatelessWidget {
  final currentUserController = Get.find<CurrentUserController>();
  final appDataController = Get.find<AppDataController>();

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
          child: GetBuilder<CurrentUserController>(builder: (c) {
            return
                    currentUserController.updatingUserInfo
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
                              imageUrl: currentUserController.currentUser!.coverPicUrl,
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
                              onTap: () => currentUserController.updateCoverPic(),
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
                                            currentUserController.currentUser!.picUrl,
                                        width: width * 0.3,
                                        height: width * 0.3,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () => currentUserController.updatePic(),
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
                                  currentUserController.currentUser!.name,
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
                          key: currentUserController.profileFormKey,
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
                                            text: currentUserController
                                                        .currentUser!.community ==
                                                    null
                                                ? "Not Member Of Any Community"
                                                : '${currentUserController.currentUser!.role} of ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: currentUserController
                                                                .currentUser!
                                                                .community ==
                                                            null
                                                        ? Colors.red
                                                        : Colors.grey)),
                                        TextSpan(
                                            text: currentUserController
                                                        .currentUser!.community ==
                                                    null
                                                ? ""
                                                : currentUserController
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
                                                text: currentUserController
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
                                      currentUserController.profileUserNameController,
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
                                      currentUserController.profileUserEmailController,
                                  textColor: Colors.black,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomTextFormField(
                                  controller:
                                      currentUserController.profileZipController,
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
                                        controller: currentUserController
                                            .profilePhoneController,
                                        context: context,
                                        label: "phone",
                                        labelColor: Colors.black,
                                        textColor: Colors.black,
                                        color: Colors.grey,
                                        validator: (v) {
                                          if (!isUkPhoneNumber(
                                             "+44${currentUserController
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
                                        currentUserController.profileSelectedGroupAge,
                                    label: 'Group Age',
                                    dark: true,
                                    items: appDataController.groupAges,
                                    onChanged: (item) => currentUserController
                                        .onProfileGroupAgeChanged(item)),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomDropdownWidget(
                                    initialValue:
                                        currentUserController.profileSelectedRegion,
                                    label: 'Region',
                                    dark: true,
                                    items: appDataController.regions,
                                    onChanged: (item) => currentUserController
                                        .onProfileRegionChanged(item)),
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomDropdownWidget(
                                    initialValue:
                                        currentUserController.profileSelectedCity,
                                    label: 'City',
                                    items: appDataController.cities,
                                    dark: true,
                                    onChanged: (item) => currentUserController
                                        .onProfileCityChanged(item)),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                               //       Get.put(()=>ChangePasswordController(),permanent: false);

                                      showDialog(
                                          context: context,
                                          builder: (c) {
                                            return Dialog(
                                              child: GetBuilder<ChangePasswordController>(
                                                init:ChangePasswordController() ,
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
                                                          CustomButton(enabled: !passController.changingPassword,
                                                              useGradient:
                                                                  false,
                                                              height:
                                                                  height * 0.06,
                                                              width: width,
                                                              onPressed: () =>
                                                                  passController
                                                                      .changePassword(currentUserController.currentUser!.email),
                                                              label:
                                                                  passController.changingPassword?"Loading...":"Change password")
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
                                        currentUserController.updateUser(),
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
