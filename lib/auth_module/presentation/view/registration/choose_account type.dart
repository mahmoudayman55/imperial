import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/auth_module/presentation/controller/choose_account_controller.dart';

import 'package:imperial/widgets/account_type_selector.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:imperial/widgets/onBoarding_next_Button.dart';
import 'package:imperial/widgets/sign_with_button.dart';
import 'package:imperial/widgets/swipe_up_button.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/utils/custom_colors.dart';
import '../../controller/user_join_requests_controller.dart';
import 'Individual/Individual_register_1.dart';
import 'business _registration_view.dart';
import 'community_registration.dart';

class ChooseAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        final double width = 100.w;
        final double height = 100.h;
        return deviceType == DeviceType.mobile
            ? Scaffold(
                resizeToAvoidBottomInset: false,
                extendBodyBehindAppBar: true,
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
                backgroundColor: Colors.grey.shade100,
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/authbg.jpg',
                      fit: BoxFit.cover,width: width
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
                        height: height * 0.06,
                        child:
                            GetBuilder<ChooseAccountTypeController>(builder: (controller) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Expanded(
                                  flex: 12,
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Choose Account Type',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            separatorBuilder: (c, index) =>
                                                SizedBox(
                                              height: height*0.03,
                                            ),
                                            itemCount: controller.types.length,
                                            itemBuilder: (context, index) {
                                              return CustomButton(
                                                height: height * 0.07,
                                                width: width * 0.7,
                                                label: controller.types[index],
                                                useGradient: index ==
                                                    controller.selectedType,
                                                color: index ==
                                                        controller.selectedType
                                                    ? CustomColors.red
                                                    : Colors.transparent,
                                                onPressed: () => controller
                                                    .onAccountTypeChange(index),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: CustomButton(
                                    height: 0.6 * height,
                                    width: width,
                                    onPressed: () =>
                                        controller.submitAccountType(),
                                    label: 'Next'),
                              )
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink();
      },
    );
  }
}

///Todo: tablet
// Scaffold(
// extendBodyBehindAppBar: true,
// appBar: AppBar(leadingWidth: 8.w,
// shadowColor: Colors.transparent,
// backgroundColor: Colors.transparent,
// elevation: 0,
// leading: Padding(
// padding:  EdgeInsets.symmetric(horizontal:1.w),
// child: NextButton(iconSize: 3,
// onPressed: () {},
// icon: Icons.arrow_back_ios_rounded,
// ),
// )),
// backgroundColor: Colors.grey.shade100,
// body: Stack(
// fit: StackFit.expand,
// children: [
// Image.asset(
// 'assets/images/authbg.jpg',
// fit: BoxFit.cover,
// ),
// BackdropFilter(
// filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// child: Container(
// width: 100.w,
// height: 100.h,
// decoration: const BoxDecoration(
// gradient: LinearGradient(
// colors: [Colors.black, Colors.transparent],
// begin: Alignment.bottomCenter,
// end: Alignment.topCenter,
// ),
// ),
// ),
// ),
// SafeArea(
// child: SizedBox( height: 60.h,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Expanded(
// flex: 1,
// child: Image.asset(
// 'assets/images/logo.png',
// fit: BoxFit.cover,
// ),
// ),
// Expanded(flex: 12,
// child:
// Container(width: 60.w,
// padding: EdgeInsets.all(20),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(8),
//
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Expanded(flex: 2,
// child: Text(
// 'Choose Account Type',
// style: Theme
//     .of(context)
// .textTheme
//     .headlineLarge
// ,
// ),
// ),
//
// Expanded(flex: 8,
// child: ListView.separated(shrinkWrap: true,
// separatorBuilder: (c, index) =>
// SizedBox(height: 3.h,),
// itemCount: _types.length,
// itemBuilder: (context, index) {
// return CustomButton(
// height: 7.h,
// width: 70.w,
// label: _types[index],
// useGradient: index == _selectedType,
// color: index == _selectedType
// ? CustomColors.red
//     : Colors.transparent,
// onPressed: () {
// setState(() {
// _selectedType = index;
// });
// },
//
// );
// },
// ),
// ),
//
// ],
// ),
// )),
// Expanded(flex: 1,
// child: CustomButton(
// height: 6.h, width: 100.w, onPressed: () {
// if (_selectedType == 0) {
// Get.to(IndividualRegister1View());
// }
// else if (_selectedType == 1) {
// Get.to(CommunityRegistrationView());
// }
// else if (_selectedType == 2) {
// Get.to(BusinessRegistrationView());
// }
// }, label: 'Next'),
// )
// ],
// ),
// ),
// ),
// ],
// ),
// )
