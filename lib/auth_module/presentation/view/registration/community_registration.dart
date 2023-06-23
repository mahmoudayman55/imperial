import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/auth_module/presentation/controller/auth_controller.dart';
import 'package:imperial/view/home_view.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/account_type_selector.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:imperial/widgets/onBoarding_next_Button.dart';
import 'package:imperial/app_init_module/presentation/components/region_selector.dart';
import 'package:imperial/widgets/sign_with_button.dart';
import 'package:imperial/widgets/swipe_up_button.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/custom_colors.dart';
import '../../../../core/utils/uk_number_validator.dart';
import '../../../../widgets/custom_drop_down.dart';
import 'choose_account type.dart';

class CommunityRegistrationView extends StatefulWidget {
  @override
  State<CommunityRegistrationView> createState() =>
      _CommunityRegistrationViewState();
}

class _CommunityRegistrationViewState extends State<CommunityRegistrationView> {


  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      double width = 100.w;
      double height = 100.h;

      return deviceType == DeviceType.mobile
          ? Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(title:
              Text("Community registration",style: Theme.of(context).textTheme.headlineLarge,),centerTitle: true,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NextButton(
                      iconSize: 5,
                      onPressed: ()=> Get.back(),
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
                        height: height ,
                        padding: EdgeInsets.all(10),
                        child: GetBuilder<AuthController>(
                          builder: (controller) {
                            return controller.gettingCommunityRegions?LoadingScreen(width * 0.1): Form(
                              key: controller.registerCommunityFormKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Expanded(
                                    flex: 2,
                                    child: CustomTextFormField( validator: (v){
                                      if(controller.communityOwnerNameController.text.isEmpty){
                                        return "This field cannot be empty";
                                      }
                                      return null;
                                    },
                                      textColor: Colors.white,
                                      controller: controller.communityOwnerNameController,
                                      context: context,
                                      label: 'User Name',
                                    ),
                                  ),           Expanded(
                                    flex: 2,
                                    child: CustomTextFormField( validator: (v){
                                      if(controller.communityAddressController.text.isEmpty){
                                        return "This field cannot be empty";
                                      }
                                      return null;
                                    },
                                      textColor: Colors.white,
                                      controller: controller.communityAddressController,
                                      context: context,
                                      label: 'Address',
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: CustomTextFormField( validator: (v){
                                      if(controller.communityNameController.text.isEmpty){
                                        return "This field cannot be empty";
                                      }
                                      return null;
                                    },
                                      textColor: Colors.white,
                                      controller: controller.communityNameController,
                                      context: context,
                                      label: 'Community Name',
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child:    CustomTextFormField(keyboardType: TextInputType.emailAddress,
                                      controller:
                                      controller.communityEmailController,
                                      validator: (value) {

                                        if ( controller.communityEmailController.text.isEmpty ||
                                            !EmailValidator.validate(controller.communityEmailController.text )) {
                                          return "Invalid email address";
                                        }
                                        return null;
                                      },
                                      context: context,
                                      label: "Email",
                                      textColor: Colors.white,
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
                                                  .displayMedium,
                                            ),
                                          ),
                                        ),
                                        Expanded(flex: 10,
                                          child: CustomTextFormField(keyboardType: TextInputType.phone,
                                            controller:controller
                                                .communityPhoneController,
                                            context: context,
                                            label: "phone",
                                            textColor: Colors.white,
                                            validator: (v) {
                                              if (!isUkPhoneNumber(
                                                  "+44${controller
                                                      .communityPhoneController
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
                                        label: 'Region',
                                        items: controller.regions,
                                        onChanged: (item) {
                                          controller.onCommunityRegionChanged(item);
                                        }),
                                  ),        Expanded(
                                    flex: 2,
                                    child: CustomTextFormField(
                                      textColor: Colors.white,
                                      controller: controller.communityWebsiteController,
                                      context: context,
                                      label: 'Web URL (optional)',
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: CustomTextFormField( validator: (v){
                                      if(controller.communityAboutController.text.isEmpty){
                                        return "This field cannot be empty";
                                      }
                                      return null;
                                    },
                                      textColor: Colors.white,
                                      controller: controller.communityAboutController,
                                      context: context,
                                      label: 'About your community',maxLines: 4,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: CustomButton(iconSize: 0.03,
                                      height: height * 0.06,
                                      width: width,enabled: !controller.registeringCommunity,
                                      onPressed:  () {
                                       controller.sendCommunityRegistrationRequest();
                                      },
                                      label: controller.registeringCommunity?"Loading...":'Finish',
                                      color: CustomColors.green,
                                      icon: Icons.done,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        ),
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
                      onPressed: () {},
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
                        width: width * 0.5,
                        height: height * 0.8,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomTextFormField(
                                context: context,
                                label: 'Full Name',
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomTextFormField(
                                context: context,
                                label: 'Community Name',
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomTextFormField(
                                context: context,
                                label: 'Email',
                              ),
                            ),
                            Expanded(
                              flex: 2,
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
                                      selectorButtonOnErrorPadding: 8,
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
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Region',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  CustomButton(
                                    height: height * 0.06,
                                    width: width,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: SizedBox(
                                              height: height * 0.6,
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
                                                      height: height * 0.06,
                                                      width: width * 0.8,
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
                              flex: 2,
                              child: CustomTextFormField(
                                context: context,
                                label: 'About Your Community',
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomButton(
                                height: height * 0.06,
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
