import 'dart:ui';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';

import 'package:imperial/view/home_view.dart';
import 'package:imperial/view/new_event_view.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/account_type_selector.dart';
import 'package:imperial/widgets/community_ticket_request_widget.dart';
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

import '../../../../core/utils/custom_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class EventsTicketsView extends StatelessWidget {
  int eventId;
  final eventC=Get.find<EventController>();

  EventsTicketsView(this.eventId);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      double width = 100.w;
      double height = 100.h;

      return deviceType == DeviceType.mobile
          ? Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () =>eventC.scanTicketQr(context, height, width),
              child: Icon(
                Icons.qr_code_scanner,
                size: width * 0.05,
                color: Colors.white,
              ),
              backgroundColor: CustomColors.red),
          appBar: AppBar(
              title: Text(
                "Events Tickets",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
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
            child: GetBuilder<EventController>(builder: (controller) {
              return controller.gettingEventTickets ||
                  controller.addingAttendee
                  ? Center(child: LoadingScreen(width * 0.1))
                  : (controller.tickets.isNotEmpty
                  ? ListView.builder(
                  itemCount: controller.tickets.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommunityTicketRequestWidget(
                          request: controller.tickets[index],
                          width: width,
                          eventId: eventId,
                          height: height * 0.3),
                    );
                  })
                  : Center(
                  child: Text(
                    "No Tickets yet",
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.black),
                  )));
            }),
          ))
          : SizedBox();
    });
  }
}
// Todo:Tablet
