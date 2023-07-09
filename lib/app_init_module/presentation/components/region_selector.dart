import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imperial/core/utils/custom_colors.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:imperial/widgets/error_widget.dart';
import 'package:sizer/sizer.dart';

import '../controller/region_controller.dart';

class RegionSelector extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppDataController>(builder: (controller) {
      return Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
       final   double width=100.w;
       final   double height=100.h;
          return deviceType == DeviceType.mobile
              ? FittedBox(
                  child: controller.loading
                      ? LoadingScreen(width * 0.1)
                      :controller.error?CustomErrorWidget(onPressed: ()=>controller.getRegions(), message: "Connection Error") :Container(
                          width: width*0.7,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Select Your Region',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.black),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.regions.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == controller.regions.length) {
                                    // Display "other" option
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      child: ElevatedButton(
                                        onPressed: () => controller
                                            .updateSelectedRegion(index),
                                        child: Text(
                                          'Other',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                color: controller
                                                            .selectedRegionIndex ==
                                                        index
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              controller.selectedRegionIndex ==
                                                      index
                                                  ? CustomColors.red
                                                  : Color(0xFFEEEEEE),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: height*0.01,
                                            horizontal: width*0.02,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    // Display region option
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric( vertical: height*0.01,),
                                      child: ElevatedButton(
                                        onPressed: () => controller
                                            .updateSelectedRegion(index),
                                        child: Text(
                                          controller.regions[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                color: controller
                                                            .selectedRegionIndex ==
                                                        index
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              controller.selectedRegionIndex ==
                                                      index
                                                  ? CustomColors.red
                                                  : Color(0xFFEEEEEE),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: height*0.01,
                                            horizontal: width*0.02,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              controller.selectedRegionIndex ==
                                      controller.regions.length
                                  ?
                                  // Display custom region input
                                  Form(
                                      key: controller.otherRegionFormKey,
                                      child: CustomTextFormField(controller: controller.otherRegionController,
                                        validator: (value) {
                                          if (controller.otherRegionController.text.isEmpty) {
                                            log(value.toString());
                                            log('Please select');
                                            // check if value is null or empty
                                            return "This field cannot be empty";
                                          }
                                          return null;
                                        },
                                        label: "Your Region",
                                        color: Colors.grey, context: context,
                                      ),
                                    )
                                  :
                                  // Hide custom region input
                                  SizedBox.shrink(),
                            ],
                          ),
                        ),
                )
              : FittedBox(
            child: controller.loading
                ? LoadingScreen(width * 0.1)
                : Container(
              width: width*0.45,
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Select Your Region',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: height*0.5,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.regions.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.regions.length) {
                        // Display "other" option
                        return Padding(
                          padding:
                          EdgeInsets.symmetric(   vertical: height*0.01,
                         ),
                          child: ElevatedButton(
                            onPressed: () => controller
                                .updateSelectedRegion(index),
                            child: Text(
                              'Other',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                color: controller
                                    .selectedRegionIndex ==
                                    index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              controller.selectedRegionIndex ==
                                  index
                                  ? CustomColors.red
                                  : Color(0xFFEEEEEE),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: height*0.01,
                                horizontal: width*0.02,
                              ),
                            ),
                          ),
                        );
                      } else {
                        // Display region option
                        return Padding(
                          padding:
                          EdgeInsets.symmetric(   vertical: height*0.01,
                        ),
                          child: ElevatedButton(
                            onPressed: () => controller
                                .updateSelectedRegion(index),
                            child: Text(
                              controller.regions[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                color: controller
                                    .selectedRegionIndex ==
                                    index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              controller.selectedRegionIndex ==
                                  index
                                  ? CustomColors.red
                                  : Color(0xFFEEEEEE),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: height*0.01,
                                horizontal: width*0.02,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  controller.selectedRegionIndex ==
                      controller.regions.length
                      ?
                  // Display custom region input
                  Form(
                    key: controller.otherRegionFormKey,
                    child: CustomTextFormField(
                      validator: (value) {
                        if (controller.otherRegion == null || controller.otherRegion.isEmpty) {
                          log(value.toString());
                          log('Please select');
                          // check if value is null or empty
                          return "This field cannot be empty";
                        }
                        return null;
                      },
                      label: "Your Region",
                      color: Colors.grey, context: context,
                    ),
                  )
                      :
                  // Hide custom region input
                  SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

//
//
// FittedBox(
// child: Container(width:45.w,
// alignment: Alignment.center,
// padding: EdgeInsets.all(20),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(8),
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Text(
// 'Select Your Region',
// style: Theme.of(context)
// .textTheme
//     .headlineLarge!
// .copyWith(color: Colors.black),
// ),
// SizedBox(
// height: 5.h,
// ),
// ListView.builder(
// shrinkWrap: true,
// itemCount: _regions.length,
// itemBuilder: (context, index) {
// return Padding(
// padding: EdgeInsets.symmetric(vertical: 1.h),
// child: ElevatedButton(
// onPressed: () {
// setState(() {
// _selectedRegionIndex = index;
// });
// },
// child: Text(
// _regions[index],
// style: Theme.of(context)
//     .textTheme
//     .displayMedium!
//     .copyWith(
// color: _selectedRegionIndex == index
// ? Colors.white
//     : Colors.black),
// ),
// style: ElevatedButton.styleFrom(
// backgroundColor: _selectedRegionIndex == index
// ? CustomColors.red
//     : Color(0xFFEEEEEE),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// padding: EdgeInsets.symmetric(
// vertical: 1.h,
// horizontal: 2.w,
// ),
// ),
// ),
// );
// },
// ),
// _selectedRegionIndex == 4
// ? CustomTextFormField(
// context: context,
// label: "Your Region",
// color: Colors.grey,
// )
// : SizedBox.shrink()
// ],
// ),
// ),
// );
