import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/app_init_module/presentation/controller/region_controller.dart';
import 'package:imperial/app_init_module/presentation/view/onboarding/intro_screen1.dart';
import 'package:imperial/auth_module/presentation/controller/user_join_requests_controller.dart';
import 'package:imperial/view/home_view.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/account_type_selector.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_drop_down.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:imperial/widgets/onBoarding_next_Button.dart';
import 'package:imperial/app_init_module/presentation/components/region_selector.dart';
import 'package:imperial/widgets/sign_with_button.dart';
import 'package:imperial/widgets/swipe_up_button.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../../../app_init_module/domain/entities/group_age_entity.dart';
import '../../../../../app_init_module/presentation/view/onboarding/intro_screen2.dart';
import '../../../../../core/utils/custom_colors.dart';
import '../../../../../core/utils/uk_number_validator.dart';
import '../../../controller/user_register_controller.dart';

class UserRegisterPhaseTwoView extends StatelessWidget {

  final appDataController =Get.find<AppDataController>();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      final double width = 100.w;
      final double height = 100.h;

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
                      onPressed: () => Get.back(),
                      icon: Icons.arrow_back_ios_rounded,
                    ),
                  )),
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
                    child: SingleChildScrollView(
                      child: Container(
                        height: height,
                        padding: EdgeInsets.all(10),
                        child:
                            GetBuilder<UserRegisterController>(builder: (controller) {
                          return Form(
                            key: controller.userRegisterPhase2FormKey,
                            child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text("Create new account",style: Theme.of(context).textTheme.headlineLarge,)
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: CustomTextFormField(
                                          validator: (v) {
                                            if (controller.userNameController
                                                .text.isEmpty) {
                                              return "This field cannot be empty";
                                            }
                                            return null;
                                          },
                                          textColor: Colors.white,
                                          controller:
                                              controller.userNameController,
                                          context: context,
                                          label: 'User Name',
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: CustomDropdownWidget(
                                            label: 'Group Age',
                                            items: appDataController.groupAges,initialValue: appDataController.groupAges[0],
                                            onChanged: (item) {
                                              controller
                                                  .onGroupAgeChanged(item);
                                            }),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: CustomDropdownWidget(
                                            label: 'Speaking Language',
                                            items: appDataController.speakingLanguages,initialValue: appDataController.speakingLanguages[0],
                                            onChanged: (item) {
                                              controller
                                                  .onSpeakingLanguageChanged(
                                                      item);
                                            }),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: CustomDropdownWidget(
                                            label: 'City',
                                            items: appDataController.cities,initialValue: appDataController.cities[0],
                                            onChanged: (item) {
                                              controller.onCityChanged(item);
                                            }),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: CustomDropdownWidget(
                                            label: 'Region',
                                            items:appDataController.regions,initialValue: appDataController.regions[0],
                                            onChanged: (item) {
                                              controller
                                                  .onUserRegionChanged(item);
                                            }),
                                      ),


                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                height: height * 0.06,
                                                child: Text(
                                                  "+44",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 10,
                                              child: CustomTextFormField(keyboardType: TextInputType.phone,
                                                controller: controller
                                                    .userRegisterPhoneController,
                                                context: context,
                                                label: "phone",
                                                textColor: Colors.white,
                                                validator: (v) {
                                                  if (!isUkPhoneNumber(
                                                      "+44${controller.userRegisterPhoneController.text}")) {
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
                                        flex: 3,
                                        child: CustomTextFormField(
                                          validator: (v) {
                                            if (controller
                                                .zipController.text.isEmpty) {
                                              return "This field cannot be empty";
                                            }
                                          },
                                          textColor: Colors.white,
                                          controller: controller.zipController,
                                          context: context,
                                          label: 'Zip',
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: CustomButton(
                                          height: height * 0.03,
                                          width: width,
                                          enabled: !controller.registeringUser,
                                          onPressed: () {
                                            controller.registerUserPhase2();
                                          },
                                          label: controller.registeringUser
                                              ? "loading..."
                                              : 'Finish',iconSize: 0.03,
                                          color: CustomColors.green,
                                          icon: Icons.done,
                                        ),
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
            )
          : Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  leadingWidth: 8.w,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: NextButton(
                      iconSize: 3,
                      onPressed: () => Get.back(),
                      icon: Icons.arrow_back_ios_rounded,
                    ),
                  )),
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
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        height: height * 0.8,
                        width: width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomTextFormField(
                                textColor: Colors.white,
                                context: context,
                                label: 'User Name',
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomDropdownWidget(
                                  label: 'Group Age',
                                  items: [],
                                  onChanged: (item) {}),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomDropdownWidget(
                                  label: 'Speaking Language',
                                  items: [],
                                  onChanged: (item) {}),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomDropdownWidget(
                                  label: 'City',
                                  items: [],
                                  onChanged: (item) {}),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Region',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  SizedBox(height: height * 0.01),
                                  CustomButton(
                                    height: height * 0.6,
                                    width: width,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: SizedBox(
                                              height: height,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      flex: 10,
                                                      child: RegionSelector()),
                                                  Expanded(
                                                    flex: 1,
                                                    child: CustomButton(
                                                      height: 6.h,
                                                      width: 80.w,
                                                      label: "Select",
                                                      onPressed: () {},
                                                      useGradient: false,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    label: 'West Midlands',
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    useGradient: false,
                                    icon: Icons.done,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Phone',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: InternationalPhoneNumberInput(
                                      initialValue: PhoneNumber(isoCode: "GB"),
                                      selectorTextStyle: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(color: Colors.black54),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white),
                                      inputDecoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Phone Number',
                                        hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      onInputChanged: (PhoneNumber value) {},
                                      selectorConfig: SelectorConfig(
                                          trailingSpace: false,
                                          selectorType:
                                              PhoneInputSelectorType.DROPDOWN),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomTextFormField(
                                context: context,
                                label: 'Zip',
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomButton(
                                height: 0.03 * height,
                                width: width,
                                onPressed: () {
                                  Get.offAll(HomeView());
                                },
                                label: 'Finish',
                                color: CustomColors.green,
                                icon: Icons.done,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
