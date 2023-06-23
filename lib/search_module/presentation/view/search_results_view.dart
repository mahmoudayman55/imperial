import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/search_module/presentation/controller/search_controller.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';
import 'package:imperial/view/home_view.dart';
import 'package:imperial/widgets/account_type_selector.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:imperial/widgets/onBoarding_next_Button.dart';
import 'package:imperial/app_init_module/presentation/components/region_selector.dart';
import 'package:imperial/widgets/sign_with_button.dart';
import 'package:imperial/widgets/swipe_up_button.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import '../../../../core/utils/custom_colors.dart';
import 'package:imperial/widgets/search_bar.dart' as se;
import '../../../view/loading_screen.dart';
import '../widget/search_result_widget.dart';

class SearchResultsView extends StatelessWidget {
  final searchController = Get.find<HomeSearchController>();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      double width = 100.w;
      double height = 100.h;

      return deviceType == DeviceType.mobile
          ? Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  title: se.SearchBar(
                      controller: searchController.searchController,
                      height: height * 0.04,
                      color: Colors.amber,
                      width: width * 0.6,
                      onTapSearch: () {
                        searchController.reSearch();
                      }),
                  shadowColor: Colors.transparent,
                  backgroundColor: CustomColors.red,
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
              body: SafeArea(
                  child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: searchController.searching.value
                      ? LoadingScreen(width * 0.1)
                      : ((searchController.eventsSearchResults.value.isEmpty &&
                              searchController
                                  .communitiesSearchResults.value.isEmpty &&
                              searchController.servicesSearchResults.value.isEmpty)
                          ? Center(
                            child: Text(
                                "No results matching your search, try another keywords",
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.black54),
                                textAlign: TextAlign.center,
                              ),
                          )
                          : SizedBox(
                              height: height,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (searchController
                                        .communitiesSearchResults.isNotEmpty)
                                      Text(
                                        "Communities",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(color: Colors.black),
                                      ),
                                    Obx(
                                      () => ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (c, i) {
                                            return SizedBox(
                                              width: width,
                                              height: height * 0.2,
                                              child: SearchResultWidget(
                                                width: width,
                                                height: height * 0.25,
                                                searchResult: searchController
                                                    .communitiesSearchResults[i],
                                                iconSize: 0.04,
                                              ),
                                            );
                                          },
                                          separatorBuilder: (c, i) {
                                            return Divider();
                                          },
                                          itemCount: searchController
                                              .communitiesSearchResults.length),
                                    ),

                                    if (searchController
                                        .eventsSearchResults.isNotEmpty)
                                      Text(
                                        "Events",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(color: Colors.black),
                                      ),

                                    Obx(
                                      () => ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (c, i) {
                                            return SizedBox(
                                              width: width,
                                              height: height * 0.2,
                                              child: SearchResultWidget(
                                                width: width,
                                                height: height * 0.25,
                                                searchResult: searchController
                                                    .eventsSearchResults[i],
                                                iconSize: 0.04,
                                              ),
                                            );
                                          },
                                          separatorBuilder: (c, i) {
                                            return Divider();
                                          },
                                          itemCount: searchController
                                              .eventsSearchResults.length),
                                    ),

                                    if (searchController
                                        .servicesSearchResults.isNotEmpty)
                                      Text(
                                        "Services",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(color: Colors.black),
                                      ),
                                    Divider(
                                      color: Colors.black54,
                                    ),
                                    Obx(
                                      () => ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (c, i) {
                                            return SizedBox(
                                              width: width,
                                              height: height * 0.2,
                                              child: SearchResultWidget(
                                                width: width,
                                                height: height * 0.25,
                                                searchResult: searchController
                                                    .servicesSearchResults[i],
                                                iconSize: 0.04,
                                              ),
                                            );
                                          },
                                          separatorBuilder: (c, i) {
                                            return Divider();
                                          },
                                          itemCount: searchController
                                              .servicesSearchResults.length),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                ),
              )))
          : SizedBox();
    });
  }
}
// Todo:Tablet
//     : Scaffold(
// extendBodyBehindAppBar: true,
// appBar: AppBar(
// leadingWidth: 8.w,
// shadowColor: Colors.transparent,
// backgroundColor: Colors.transparent,
// elevation: 0,
// leading: Padding(
// padding: EdgeInsets.symmetric(horizontal: 1.w),
// child: NextButton(
// iconSize: 3,
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
// width: width,
// height: height,
// decoration: const BoxDecoration(
// gradient: LinearGradient(
// colors: [Colors.black, Colors.transparent],
// begin: Alignment.bottomCenter,
// end: Alignment.topCenter,
// ),
// ),
// ),
// ),
// Center(
// child: SingleChildScrollView(
// child: Container(
// width: width * 0.5,
// height: height * 0.8,
// padding: EdgeInsets.all(10),
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
// Expanded(
// flex: 2,
// child: CustomTextFormField(
// context: context,
// label: 'Full Name',
// ),
// ),
// Expanded(
// flex: 2,
// child: CustomTextFormField(
// context: context,
// label: 'Community Name',
// ),
// ),
// Expanded(
// flex: 2,
// child: CustomTextFormField(
// context: context,
// label: 'Email',
// ),
// ),
// Expanded(
// flex: 2,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Phone',
// style:
// Theme.of(context).textTheme.bodyLarge,
// ),
// SizedBox(height: Get.height * 0.01),
// Container(
// decoration: BoxDecoration(
// color: Colors.white.withOpacity(0.3),
// borderRadius: BorderRadius.circular(8),
// ),
// child: InternationalPhoneNumberInput(
// initialValue: number,
// selectorTextStyle: Theme.of(context)
// .textTheme
//     .displayLarge!
// .copyWith(color: Colors.black54),
// textStyle: Theme.of(context)
// .textTheme
//     .bodyLarge!
// .copyWith(color: Colors.white),
// inputDecoration: InputDecoration(
// border: InputBorder.none,
// hintText: 'Phone Number',
// hintStyle: TextStyle(
// color: Colors.grey[400],
// ),
// ),
// onInputChanged: (PhoneNumber value) {},
// selectorButtonOnErrorPadding: 8,
// selectorConfig: SelectorConfig(
// trailingSpace: false,
// selectorType:
// PhoneInputSelectorType.DROPDOWN),
// ),
// ),
// ],
// ),
// ),
// Expanded(
// flex: 2,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Region',
// style:
// Theme.of(context).textTheme.bodyLarge,
// ),
// SizedBox(height: Get.height * 0.01),
// CustomButton(
// height: height * 0.06,
// width: width,
// onPressed: () {
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return Dialog(
// child: SizedBox(
// height: height * 0.6,
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceBetween,
// children: [
// Expanded(
// flex: 10,
// child: RegionSelector()),
// Expanded(
// flex: 1,
// child: CustomButton(
// height: height * 0.06,
// width: width * 0.8,
// label: "Select",
// onPressed: () {},
// useGradient: false,
// ),
// ),
// ],
// ),
// ),
// );
// },
// );
// },
// label: 'West Midlands',
// color: Colors.white,
// textColor: Colors.black,
// useGradient: false,
// icon: Icons.done,
// ),
// ],
// ),
// ),
// Expanded(
// flex: 2,
// child: CustomTextFormField(
// context: context,
// label: 'About Your Community',
// ),
// ),
// Expanded(
// flex: 1,
// child: CustomButton(
// height: height * 0.06,
// width: width,
// onPressed: () {
// Get.offAll(HomeView());
// },
// label: 'Finish',
// color: CustomColors.green,
// icon: Icons.done,
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// ],
// ),
// );
