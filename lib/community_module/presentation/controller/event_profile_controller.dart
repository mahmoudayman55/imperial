import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth_module/presentation/controller/user_join_requests_controller.dart';
import '../../../auth_module/presentation/controller/current_user_controller.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/custom_colors.dart';
import '../../../view/new_ticket_view.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../data/model/bank_account_model.dart';
import '../../data/model/community_event_model.dart';
import '../../data/model/event_model.dart';
import '../../data/remote_data_source/community_remote_data_source.dart';
import '../../data/repository/community_repository.dart';
import '../../domain/repository/base_community_repository.dart';
import '../../domain/usecase/get_event_by_id.dart';

class EventProfileController extends GetxController {
  @override
  void onInit() {
    selectedEventId = Get.arguments;
    getEvent();
    super.onInit();
  }

  late EventModel selectedEvent;
  late int selectedEventId;
  int currentEventCover = 0;
  bool gettingEvent = false;

  getEvent() async {
    // var connectivityResult = await Connectivity().checkConnectivity();
    // if (connectivityResult == ConnectivityResult.none) {
    //   customSnackBar(
    //     title: "error",
    //     message: "No internet connection",
    //     successful: false,
    //   );
    //   return;
    // }

    gettingEvent = true;
    update();
    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);

    final result =
        await GetEventByIdUseCase(communityRepository).execute(selectedEventId);
    result.fold((l) => null, (r) {
      selectedEvent = r as EventModel;
    });
    gettingEvent = false;
    update();
  }

  onCoverChanged(int index) {
    currentEventCover = index;
    update();
  }

  void showPaymentDialog(BuildContext context, double width, double height) {
    final authC = Get.find<CurrentUserController>();

    if (authC.currentUser == null) {
      customSnackBar(
          title: "",
          message: "You have to login to be able to buy a ticket",
          successful: false);
      return;
    } else if (authC.currentUser!.role == "admin" &&
        authC.currentUser!.community!.id == selectedEvent.community.id) {
      customSnackBar(
          title: "",
          message: "You cannot buy ticket for your event.",
          successful: false);
      return;
    } else if (!(selectedEvent.speakingLanguages
        .map((e) => e.id)
        .toList()
        .contains(authC.currentUser!.speakingLanguage!.id))) {
      customSnackBar(
          title: "",
          message:
              "This event is only for certain language speakers, not including yours, please check allowed languages",
          successful: false);
      return;
    } else if (selectedEvent.appointment.isAtSameMomentAs(DateTime.now()) ||
        selectedEvent.appointment.isBefore(DateTime.now())) {
      customSnackBar(
          title: "",
          message:
              "Event already passed.Book tickets early to avoid missing out.",
          successful: false);
      return;
    } else if (selectedEvent.membersOnly) {
      if (authC.currentUser!.role == null ||
          authC.currentUser!.community!.id != selectedEvent.community.id) {
        customSnackBar(
            title: "",
            message:
                "You have to be a member of ${selectedEvent.community.name} community to be able to buy a ticket",
            successful: false);
        return;
      }
    } else if (selectedEvent.attendees >= selectedEvent.maxAttendees) {
      customSnackBar(
          title: "", message: "All tickets sold out", successful: false);
      return;
    }

    log(selectedEvent.toJson().toString());
    log((selectedEvent.community as CommunityEventModel).toJson().toString());

    BankAccount bankAccount =
        (selectedEvent.community as CommunityEventModel).bankAccount!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text(
                //   'Send ticket price to this bank account',
                //   textAlign: TextAlign.center,
                //   style: Theme
                //       .of(context)
                //       .textTheme
                //       .bodyLarge!
                //       .copyWith(color: Colors.black),
                // ),
                // SizedBox(height: 20.0),
                // Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           'Account name:',
                //           style: Theme
                //               .of(context)
                //               .textTheme
                //               .bodyLarge!
                //               .copyWith(color: Colors.black),
                //         ),
                //         Text(
                //           '${bankAccount.accountName}',
                //           style: Theme
                //               .of(context)
                //               .textTheme
                //               .bodyMedium!
                //               .copyWith(color: Colors.black),
                //         ),
                //       ],
                //     ),
                //     SizedBox(height: 10.0),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           'Account Number:',
                //           style: Theme
                //               .of(context)
                //               .textTheme
                //               .bodyLarge!
                //               .copyWith(color: Colors.black),
                //         ),
                //         Text(
                //           '${bankAccount.accountNumber}',
                //           style: Theme
                //               .of(context)
                //               .textTheme
                //               .bodyMedium!
                //               .copyWith(color: Colors.black),
                //         ),
                //       ],
                //     ),
                //     SizedBox(height: 10.0),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           'Swift:',
                //           style: Theme
                //               .of(context)
                //               .textTheme
                //               .bodyLarge!
                //               .copyWith(color: Colors.black),
                //         ),
                //         Text(
                //           '${bankAccount.swift}',
                //           style: Theme
                //               .of(context)
                //               .textTheme
                //               .bodyMedium!
                //               .copyWith(color: Colors.black),
                //         ),
                //       ],
                //     ),
                //     SizedBox(height: 10.0),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           'IBAN:',
                //           style: Theme
                //               .of(context)
                //               .textTheme
                //               .bodyLarge!
                //               .copyWith(color: Colors.black),
                //         ),
                //         Text(
                //           '${bankAccount.iban}',
                //           style: Theme
                //               .of(context)
                //               .textTheme
                //               .bodyMedium!
                //               .copyWith(color: Colors.black),
                //         ),
                //       ],
                //     ),
                //     SizedBox(height: 10.0),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           'Bank Name:',
                //           style: Theme
                //               .of(context)
                //               .textTheme
                //               .bodyLarge!
                //               .copyWith(color: Colors.black),
                //         ),
                //         Text(
                //           '${bankAccount.bankName}',
                //           style: Theme
                //               .of(context)
                //               .textTheme
                //               .bodyMedium!
                //               .copyWith(color: Colors.black),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20.0),
                Text(
                  'Please note this is a manual transfer , fill all your ticket information and submit it to the event organizer bank account and he will send you your ticket once he gets your payment',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: CustomColors.red),
                ),
                const SizedBox(height: 20.0),
                CustomButton(
                    useGradient: false,
                    textPadding: 0,
                    height: height * 0.03,
                    width: width * 0.30,
                    onPressed: () {
                      /*      adultAttendees.clear();
                      kidsAttendees.clear();
                    */
                      Get.toNamed(AppConstants.newTicketPage);
                    },
                    label: "continue"),
              ],
            ),
          ),
        );
      },
    );
    //    showModalBottomSheet(
    //
    //      context: context,
    //      builder: (BuildContext context) {
    //        return ;
    //      },
    // // set the background color of the Bottom Sheet
    //    );
  }
}
