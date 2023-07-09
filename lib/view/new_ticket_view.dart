import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/community_module/data/model/adult_attendee_model.dart';
import 'package:imperial/community_module/presentation/controller/event_profile_controller.dart';
import 'package:imperial/community_module/presentation/controller/new_event_controller.dart';
import 'package:imperial/widgets/custom_drop_down.dart';
import 'package:imperial/widgets/data_viewer_widget.dart';
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
import '../auth_module/presentation/controller/user_join_requests_controller.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';

import '../auth_module/presentation/controller/current_user_controller.dart';
import '../widgets/custom_snack_bar.dart';

class NewTicketView extends StatelessWidget {
  final authC = Get.find<CurrentUserController>();
  final eventController = Get.find<EventProfileController>();

  NewTicketView({super.key});

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
                "Book a ticket",
                style: Theme
                    .of(context)
                    .textTheme
                    .displayLarge,
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GetBuilder<NewTicketController>(builder: (controller) {
                return Column(
                  children: [
                    Expanded(
                      flex: 14,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "adult ticket price:",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                Text(
                                  "${eventController.selectedEvent
                                      .adultTicketPrice} £",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: Colors.black),
                                ),

                                // ListView.separated(itemBuilder: (context,index){
                                //   return
                                //
                                // }, separatorBuilder: separatorBuilder, itemCount: itemCount)
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "kid ticket price:",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                Text(
                                  "${eventController.selectedEvent
                                      .kidTicketPrice} £",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: Colors.black),
                                ),

                                // ListView.separated(itemBuilder: (context,index){
                                //   return
                                //
                                // }, separatorBuilder: separatorBuilder, itemCount: itemCount)
                              ],
                            ),
                            eventController.selectedEvent.underFiveFree
                                ? Column(
                              children: [
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      "kids under 5:",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "free",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                          color: Colors.black),
                                    ),

                                    // ListView.separated(itemBuilder: (context,index){
                                    //   return
                                    //
                                    // }, separatorBuilder: separatorBuilder, itemCount: itemCount)
                                  ],
                                ),
                              ],
                            )
                                : SizedBox.shrink(),
                            Divider(),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ticket Owner:",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                Text(
                                  authC.currentUser!.name,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: Colors.black),
                                ),

                                // ListView.separated(itemBuilder: (context,index){
                                //   return
                                //
                                // }, separatorBuilder: separatorBuilder, itemCount: itemCount)
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add attendees on the ticket",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: CustomColors.green,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: IconButton(
                                      onPressed: () {
                                        if (eventController.selectedEvent.attendees +
                                            controller.   adultAttendees.length +
                                            controller.   kidsAttendees.length ==
                                            eventController.    selectedEvent.maxAttendees -
                                                eventController.        selectedEvent.attendees){
                                          customSnackBar(
                                              title: "",
                                              message:
                                              "No tickets available.",
                                              successful: false);

                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {

                                                return Dialog(
                                                  child: Container(
                                                    height: height * 0.45,
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: GetBuilder<
                                                        NewTicketController>(
                                                        builder:
                                                            (controller) {
                                                          return Form(
                                                            key: controller
                                                                .newAttendeeFormKey,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    "Add attendees on the ticket",
                                                                    style: Theme
                                                                        .of(
                                                                        context)
                                                                        .textTheme
                                                                        .displayMedium!
                                                                        .copyWith(
                                                                        color:
                                                                        Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                  CustomTextFormField(
                                                                    controller:
                                                                    controller
                                                                        .attendeeOnTicketNameController,
                                                                    context:
                                                                    context,
                                                                    validator:
                                                                        (v) {
                                                                      if (controller
                                                                          .attendeeOnTicketNameController
                                                                          .text
                                                                          .isEmpty) {
                                                                        return "this field cannot be empty";
                                                                      }
                                                                      return null;
                                                                    },
                                                                    label: "Name",
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                        0.2),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                  CustomDropdownWidget(
                                                                    label:
                                                                    "adult / kid",
                                                                    items: const [
                                                                      "adult",
                                                                      "kid"
                                                                    ],
                                                                    onChanged: (
                                                                        v) =>
                                                                        controller
                                                                            .onAttendeeTypeChange(
                                                                            v),
                                                                    dark: true,
                                                                  ),
                                                                ),
                                                                controller
                                                                    .attendeeType ==
                                                                    "kid"
                                                                    ? Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                  CustomTextFormField(
                                                                    controller:
                                                                    controller
                                                                        .attendeeOnTicketAgeController,
                                                                    context:
                                                                    context,
                                                                    validator:
                                                                        (v) {
                                                                      if (controller
                                                                          .attendeeOnTicketAgeController
                                                                          .text
                                                                          .isEmpty) {
                                                                        return "this field cannot be empty";
                                                                      }
                                                                      return null;
                                                                    },
                                                                    label:
                                                                    "Age",
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                        0.2),
                                                                  ),
                                                                )
                                                                    : SizedBox(),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: CustomButton(
                                                                        useGradient:
                                                                        false,
                                                                        height:
                                                                        height *
                                                                            0.02,
                                                                        width:
                                                                        width,
                                                                        onPressed: () {
                                                                          controller
                                                                                .addAttendee();
                                                                        },
                                                                        label:
                                                                        "Add Attendee"))
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                );
                                              });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,size: width*0.05,
                                      )),
                                ),
                                // ListView.separated(itemBuilder: (context,index){
                                //   return
                                //
                                // }, separatorBuilder: separatorBuilder, itemCount: itemCount)
                              ],
                            ),
                            DefaultTabController(
                              initialIndex: 0,
                              length: 2,
                              child: SizedBox(
                                width: width,
                                child: Column(
                                  children: [
                                    TabBar(
                                        labelStyle: Theme
                                            .of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                          color: CustomColors.red,
                                        ),
                                        labelColor: CustomColors.red,
                                        unselectedLabelColor:
                                        Colors.black,
                                        unselectedLabelStyle:
                                        Theme
                                            .of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                            color: Colors.black),
                                        indicatorColor: CustomColors.red,
                                        onTap: (index) {},
                                        tabs: [
                                          Tab(
                                              text:
                                              'Adults (${controller
                                                  .adultAttendees.length})'),
                                          Tab(
                                              text:
                                              'Kids (${controller
                                                  .kidsAttendees.length})'),
                                        ]),
                                    GetBuilder<NewTicketController>(
                                        builder: (controller) {
                                          return SizedBox(
                                            height: height * 0.4,
                                            child: TabBarView(
                                              physics:
                                              NeverScrollableScrollPhysics(),
                                              children: [
                                                controller.adultAttendees
                                                    .isEmpty
                                                    ? Center(
                                                  child: Text(
                                                    "No adult attendees",
                                                    style: Theme
                                                        .of(
                                                        context)
                                                        .textTheme
                                                        .displayMedium!
                                                        .copyWith(
                                                        color: Colors
                                                            .black),
                                                  ),
                                                )
                                                    : SingleChildScrollView(
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  child: SizedBox(
                                                    width: width,
                                                    child: DataTable(
                                                      columnSpacing:
                                                      width * 0.02,
                                                      headingRowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                          CustomColors
                                                              .red),
                                                      columns: [
                                                        DataColumn(
                                                            label: Text(
                                                              '#',
                                                              style: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            )),
                                                        DataColumn(
                                                            label: Text(
                                                              'Name',
                                                              style: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            )),
                                                        DataColumn(
                                                            label: Text(
                                                              '',
                                                              style: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            )),
                                                      ],
                                                      rows: (controller
                                                          .adultAttendees)
                                                          .asMap()
                                                          .entries
                                                          .map((entry) {
                                                        final index =
                                                            entry.key;
                                                        final isOddRow =
                                                            index % 2 ==
                                                                1;
                                                        final rowColor =
                                                        isOddRow
                                                            ? Colors
                                                            .grey
                                                            .shade300
                                                            : Colors
                                                            .white;
                                                        return DataRow(
                                                          color: MaterialStateProperty
                                                              .resolveWith<
                                                              Color>(
                                                                  (states) =>
                                                              rowColor),
                                                          cells: [
                                                            DataCell(
                                                              Text(
                                                                (index +
                                                                    1)
                                                                    .toString(),
                                                                style: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            DataCell(
                                                              Text(
                                                                controller
                                                                    .adultAttendees[index]
                                                                    .name,
                                                                style: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            DataCell(
                                                              controller
                                                                  .adultAttendees[index]
                                                                  .name ==
                                                                  authC
                                                                      .currentUser!
                                                                      .name
                                                                  ? SizedBox():Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                                child: IconButton(
                                                                    padding: EdgeInsets
                                                                        .zero,
                                                                    onPressed: () =>
                                                                        controller
                                                                            .removeAdultAttendee(
                                                                            index),
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete_forever,
                                                                      color: CustomColors
                                                                          .red,
                                                                      size: width *
                                                                          0.04,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),
                                                controller
                                                    .kidsAttendees.isEmpty
                                                    ? Center(
                                                  child: Text(
                                                    "No adult attendees",
                                                    style: Theme
                                                        .of(
                                                        context)
                                                        .textTheme
                                                        .displayMedium!
                                                        .copyWith(
                                                        color: Colors
                                                            .black),
                                                  ),
                                                )
                                                    : SingleChildScrollView(
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  child: SizedBox(
                                                    width: width,
                                                    child: DataTable(
                                                      columnSpacing:
                                                      width * 0.02,
                                                      headingRowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                          CustomColors
                                                              .red),
                                                      columns: [
                                                        DataColumn(
                                                            label: Text(
                                                              '#',
                                                              style: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            )),
                                                        DataColumn(
                                                            label: Text(
                                                              'Name',
                                                              style: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            )),
                                                        DataColumn(
                                                            label: Text(
                                                              'age',
                                                              style: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            )),
                                                        DataColumn(
                                                            label: Text(
                                                              'cost',
                                                              style: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            )),
                                                        DataColumn(
                                                            label: Text(
                                                              '',
                                                              style: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            )),
                                                      ],
                                                      rows: controller
                                                          .kidsAttendees
                                                          .asMap()
                                                          .entries
                                                          .map((entry) {
                                                        final index =
                                                            entry.key;
                                                        final event =
                                                            entry.value;
                                                        final isOddRow =
                                                            index % 2 ==
                                                                1;
                                                        final rowColor =
                                                        isOddRow
                                                            ? Colors
                                                            .grey
                                                            .shade300
                                                            : Colors
                                                            .white;
                                                        return DataRow(
                                                          color: MaterialStateProperty
                                                              .resolveWith<
                                                              Color>(
                                                                  (states) =>
                                                              rowColor),
                                                          cells: [
                                                            DataCell(
                                                              Text(
                                                                (index +
                                                                    1)
                                                                    .toString(),
                                                                style: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            DataCell(
                                                              Text(
                                                                controller
                                                                    .kidsAttendees[index]
                                                                    .name,
                                                                style: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            DataCell(
                                                              Text(
                                                                controller
                                                                    .kidsAttendees[index]
                                                                    .age
                                                                    .toString(),
                                                                style: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            DataCell(
                                                              Text(
                                                                controller
                                                                    .kidsAttendees[index]
                                                                    .cost
                                                                    .toString(),
                                                                style: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            DataCell(
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                                child: IconButton(
                                                                    padding: EdgeInsets
                                                                        .zero,
                                                                    onPressed: () =>
                                                                        controller
                                                                            .removeKidAttendee(
                                                                            index),
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete_forever,
                                                                      color: CustomColors
                                                                          .red,
                                                                      size: width *
                                                                          0.04,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "adult tickets:",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                Text(
                                  "${((controller.adultAttendees.length ) *
                                      eventController.selectedEvent
                                          .adultTicketPrice).toString()} £",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: Colors.black),
                                ),

                                // ListView.separated(itemBuilder: (context,index){
                                //   return
                                //
                                // }, separatorBuilder: separatorBuilder, itemCount: itemCount)
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "kids tickets:",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                Text(
                                  "${((eventController.selectedEvent.underFiveFree
                                      ? controller.kidsAttendees
                                      .where((element) => element.age >= 5)
                                      .length
                                      : controller.kidsAttendees.length) *
                                      eventController.selectedEvent.kidTicketPrice)
                                      .toString()} £",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: Colors.black),
                                ),

                                // ListView.separated(itemBuilder: (context,index){
                                //   return
                                //
                                // }, separatorBuilder: separatorBuilder, itemCount: itemCount)
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total: ",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                Text(
                                  "${((eventController.selectedEvent.underFiveFree
                                      ? controller.kidsAttendees
                                      .where((element) => element.age >= 5)
                                      .length
                                      : controller.kidsAttendees.length) *
                                      eventController.selectedEvent
                                          .kidTicketPrice) +
                                      ((controller.adultAttendees.length) * eventController.selectedEvent
                                          .adultTicketPrice)}£",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: Colors.black),
                                ),

                                // ListView.separated(itemBuilder: (context,index){
                                //   return
                                //
                                // }, separatorBuilder: separatorBuilder, itemCount: itemCount)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: CustomButton(
                            useGradient: false,
                            height: height * 0.05,
                            width: width,
                            onPressed: () =>
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(

                                          padding: const EdgeInsets.all(8.0),
                                          child: GetBuilder<NewTicketController>(
                                              builder: (controller) {
                                                return Form(
                                                  key: controller
                                                      .newAttendeeFormKey,
                                                  child: ListView(

                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.all(
                                                        5),

                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .center,
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .all(5.0),
                                                          child: Text(
                                                            "Send total ticket price to this bank details",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme
                                                                .of(
                                                                context)
                                                                .textTheme
                                                                .displayMedium!
                                                                .copyWith(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Account Name",
                                                            style: Theme
                                                                .of(
                                                                context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          DataViewerWidget(
                                                              iconSize:
                                                              width * 0.04,
                                                              data: eventController
                                                                  .selectedEvent
                                                                  .community
                                                                  .bankAccount!
                                                                  .accountName,
                                                              iconData:
                                                              Icons.person),
                                                        ],
                                                      ),
                                                      Divider(),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Account Number",
                                                            style: Theme
                                                                .of(
                                                                context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          DataViewerWidget(
                                                              iconSize:
                                                              width * 0.04,
                                                              data: eventController
                                                                  .selectedEvent
                                                                  .community
                                                                  .bankAccount!
                                                                  .accountNumber,
                                                              iconData:
                                                              Icons.numbers),
                                                        ],
                                                      ), Divider(),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Reference number",
                                                            style: Theme
                                                                .of(
                                                                context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          DataViewerWidget(
                                                              iconSize:
                                                              width * 0.04,
                                                              data: eventController
                                                                  .selectedEvent
                                                                  .referenceNumber,
                                                              iconData:
                                                              Icons.numbers),
                                                        ],
                                                      ), Divider(),

                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Sort code",
                                                            style: Theme
                                                                .of(
                                                                context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          DataViewerWidget(
                                                              iconSize:
                                                              width * 0.04,
                                                              data: eventController
                                                                  .selectedEvent
                                                                  .community
                                                                  .bankAccount!
                                                                  .sortCode,
                                                              iconData:
                                                              Icons.numbers),
                                                        ],
                                                      ), Divider(),

                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Bank",
                                                            style: Theme
                                                                .of(
                                                                context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          DataViewerWidget(
                                                              iconSize:
                                                              width * 0.04,
                                                              data: eventController
                                                                  .selectedEvent
                                                                  .community
                                                                  .bankAccount!
                                                                  .bankName,
                                                              iconData:
                                                              Icons
                                                                  .location_city),
                                                        ],
                                                      ), Divider(),

                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Bank address",
                                                            style: Theme
                                                                .of(
                                                                context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          DataViewerWidget(
                                                              iconSize:
                                                              width * 0.04,
                                                              data: eventController
                                                                  .selectedEvent
                                                                  .community
                                                                  .bankAccount!
                                                                  .bankAddress,
                                                              iconData:
                                                              Icons
                                                                  .location_on_outlined),
                                                        ],
                                                      ), Divider(),

                                                      CustomTextFormField(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        context: context,
                                                        label: "your bank account name (optional)",
                                                        controller: controller
                                                            .bankHolderNameController,),
                                                      Divider(),

                                                      CustomButton(
                                                          useGradient: false,
                                                          height: height *
                                                              0.04,
                                                          width: width,
                                                          enabled: !controller
                                                              .sendingTicketRequest,
                                                          onPressed: () =>
                                                              controller
                                                                  .sendTicketRequest(),
                                                          label: controller
                                                              .sendingTicketRequest
                                                              ? "Loading..."
                                                              : "Send Ticket Request")


                                                    ],
                                                  ),);
                                              }),
                                        ),
                                      );
                                    }),
                            label: "Submit"))
                  ],
                );
              }),
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
// Theme.of(context).textTheme.displayMedium,
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
//     .displayMedium!
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
// Theme.of(context).textTheme.displayMedium,
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
