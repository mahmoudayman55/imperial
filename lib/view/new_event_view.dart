import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
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
import '../auth_module/presentation/controller/auth_controller.dart';
import '../core/utils/uk_number_validator.dart';

class NewEventView extends StatefulWidget {
  @override
  State<NewEventView> createState() => _NewEventViewState();
}

class _NewEventViewState extends State<NewEventView> {
  final speakingLanguageController = Get.find<AuthController>();

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
                  title: Text(
                    "Create New Event",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
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
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: height + (height * 0.7),
                    child: GetBuilder<EventController>(builder: (controller) {
                      return Form(key: controller.newEventFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomTextFormField(validator: (value){
                                if(controller.eventNameController.text.isEmpty){
                                  return"this field cannot be empty";
                                }
                              },
                                controller: controller.eventNameController,
                                context: context,
                                label: 'Event name',
                                labelColor: Colors.black,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          Expanded(
                            flex: 3,
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
                                    controller: controller
                                        .eventOrganizerPhoneController,
                                    context: context,
                                    label: "phone",
                                    labelColor: Colors.black,
                                    textColor: Colors.black,
                                    color: Colors.grey,
                                    validator: (v) {
                                      if (!isUkPhoneNumber(
                                          "+44${controller
                                              .eventOrganizerPhoneController
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
                              flex: 3,
                              child: CustomTextFormField( validator: (value){
                                if(controller.eventAddressController.text.isEmpty){
                                  return"this field cannot be empty";
                                }
                              },
                                controller: controller.eventAddressController,
                                context: context,
                                label: 'Address',
                                labelColor: Colors.black,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomTextFormField(

                                keyboardType: const TextInputType.numberWithOptions(signed: false),
                                validator: (value){
                                if(controller.eventAdultTicketPriceController.text.isEmpty){
                                  return"this field cannot be empty";
                                }
                              },
                                controller: controller.eventAdultTicketPriceController,
                                context: context,
                                label: 'Adult Ticket price',
                                labelColor: Colors.black,
                                color: Colors.grey.shade400,
                              ),
                            ),       Expanded(
                              flex: 3,
                              child: CustomTextFormField( keyboardType: const TextInputType.numberWithOptions(signed: false),validator: (value){
                                if(controller.eventKidTicketPriceController.text.isEmpty){
                                  return"this field cannot be empty";
                                }
                                return null;
                              },
                                controller: controller.eventKidTicketPriceController,
                                context: context,
                                label: 'Kid Ticket price',
                                labelColor: Colors.black,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomTextFormField(validator: (value){


                                if(controller.eventMaxAttendeesController.text.isEmpty){
                                  return"this field cannot be empty";
                                }
                              }, keyboardType:const TextInputType.numberWithOptions(signed: false),
                                controller:
                                    controller.eventMaxAttendeesController,
                                context: context,
                                label: 'Max attendees',
                                labelColor: Colors.black,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomTextFormField(validator: (value){
                                if(controller.eventReferenceNumberController.text.isEmpty){
                                  return"this field cannot be empty";
                                }
                              },
                                controller: controller.eventReferenceNumberController,
                                context: context,
                                label: 'reference number',
                                labelColor: Colors.black,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: CustomTextFormField(validator: (value){
                                if(controller.eventDetailsController.text.isEmpty){
                                  return"this field cannot be empty";
                                }
                              },
                                controller:
                                    controller.eventDetailsController,
                                context: context,
                                label: 'Details',maxLines: 5,
                                labelColor: Colors.black,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Appointment',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: CustomButton(
                                          height: height,iconSize: 0.05,
                                          width: width,fontWeight: FontWeight.normal,
                                          onPressed: () {
                                            controller.creatingEvent=false;
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(
                                                    DateTime.now().year,
                                                    DateTime.now().month,
                                                    DateTime.now().day),
                                                onConfirm: (date) {
                                              controller.eventDate =
                                                  DateFormat('MMMM d, y')
                                                      .format(date);
                                              controller.update();
                                            },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.en);
                                          },
                                          label: controller.eventDate,
                                          useGradient: false,
                                          color: CustomColors.green,
                                          icon: Icons.date_range,
                                          circleIcon: false)),
                                  Expanded(
                                      flex: 3,
                                      child: CustomButton(
                                          height: height,
                                          width: width, iconSize: 0.05,
                                       fontWeight: FontWeight.normal,
                                          onPressed: () {
                                            DatePicker.showTime12hPicker(context,
                                                showTitleActions: true,
                                                onConfirm: (date) {
                                              controller.eventTime =
                                                  DateFormat('h:mm a')
                                                      .format(date);
                                              controller.update();
                                            },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.en);
                                          },
                                          label: controller.eventTime,
                                          useGradient: false,
                                          color: CustomColors.green,
                                          icon: Icons.access_time,
                                          circleIcon: false)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Instructions',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: CustomColors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: IconButton(
                                          onPressed: () =>controller.addInstruction(context),
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.white,size: width*0.05,
                                          )),
                                    ),
                                    // CustomButton(
                                    //   useGradient: false,
                                    //   borderRadius: 0,
                                    //   height: height,
                                    //   width: width * 0.5,
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       _fields.add(CustomTextFormField(
                                    //         context: context,
                                    //         label: 'Field ${_fields.length + 1}',
                                    //         labelColor: Colors.black,
                                    //         color: Colors.grey.shade400,
                                    //       ));
                                    //     });
                                    //   },
                                    //   label: 'Add instruction',
                                    // )
                                  ],
                                ),
                              ),
                            ),
                            controller.instructionsFormFields.isEmpty
                                ? Text(
                                    "You did not add any instructions",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.black54),
                                  )
                                : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.instructionsFormFields.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: controller
                                                  .instructionsFormFields[index]),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: CustomColors.red,size: width*0.05,
                                            ),
                                            onPressed: () =>controller.removeInstruction(index),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                            Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CheckboxListTile(
                                    activeColor: CustomColors.red,
                                    title: Text(
                                      'Community members only can attend',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                    value: controller.onlyMembersCanAttend,
                                    onChanged: (bool? newValue) =>
                                        controller.onSelectMembersOnly(newValue!),
                                  ),
                                )), Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CheckboxListTile(
                                    activeColor: CustomColors.red,
                                    title: Text(
                                      'free ticket for kids under 5',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                    value: controller.freeUnder5,
                                    onChanged: (bool? newValue) =>
                                        controller.onSelectUnderFive(newValue!),
                                  ),
                                )),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButton(
                                      height: height,
                                      textPadding: 0,
                                      color: CustomColors.green,
                                      width: width * 0.55,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (c) {
                                              return GetBuilder<EventController>(
                                                  builder: (controller) {
                                                return Dialog(
                                                  child: Container(
                                                    padding: EdgeInsets.all(16.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Select Items:',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .displayMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        SizedBox(height: 8.0),
                                                        Column(
                                                          children: List.generate(
                                                            speakingLanguageController
                                                                .speakingLanguages
                                                                .length,
                                                            (index) =>
                                                                CheckboxListTile(
                                                              title: Text(
                                                                speakingLanguageController
                                                                    .speakingLanguages[
                                                                        index]
                                                                    .name,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black),
                                                              ),
                                                              value: controller
                                                                  .allowedLanguages
                                                                  .contains(speakingLanguageController
                                                                      .speakingLanguages[
                                                                          index]
                                                                      .id),
                                                              onChanged: (value) =>
                                                                  controller
                                                                      .onSelectLanguage(
                                                                          value!,
                                                                          index),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                            });
                                      },
                                      useGradient: false,
                                      label: "Allowed Languages"),
                                  Text(
                                    '${controller.allowedLanguages.length} selected',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return index == 0
                                          ? InkWell(
                                              onTap: () => controller.addImages(),
                                              child: Container(
                                                width: width * 0.6,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: CustomColors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Stack(clipBehavior: Clip.antiAlias,
                                                children: [
                                                  SizedBox(
                                                      width: width * 0.6,
                                                      child: Image.file(
                                                          fit: BoxFit.cover,
                                                          File(controller
                                                              .images[index - 1]
                                                              .path))),     Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Container(padding: EdgeInsets.all(5), width: width*0.07,height: width*0.07,alignment: Alignment.center,
                                                      decoration:  BoxDecoration(
                                                      shape: BoxShape.rectangle,  borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                      color: Colors.red,
                                                    ),
                                                      child: IconButton(padding: EdgeInsets.zero,
                                                        icon: Icon(Icons.delete_forever,color: Colors.white,size: width*0.04,),
                                                        onPressed: () =>controller.removeImage(index),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: 0.06 * width,
                                      );
                                    },
                                    itemCount: controller.images.length + 1),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomButton(
                                    height: height * 0.5,useGradient: false,
                                    width: width,enabled: !controller.creatingEvent,
                                    onPressed: () => controller.createEvent(),
                                    label:controller.creatingEvent?"Loading...": "Add new event"),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ))
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
