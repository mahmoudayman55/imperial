
import 'package:flutter/material.dart';

import 'dart:developer';
import 'package:imperial/auth_module/data/models/notification_model.dart';
import 'package:imperial/auth_module/presentation/controller/notofication_controller.dart';
import 'package:imperial/community_module/data/model/adult_attendee_model.dart';
import 'package:imperial/community_module/domain/usecase/get_event_admins_use_case.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imperial/core/utils/app_constants.dart';


import '../../../auth_module/presentation/controller/current_user_controller.dart';

import '../../../widgets/custom_snack_bar.dart';
import '../../data/model/event_model.dart';
import '../../data/model/event_ticket_request.dart';
import '../../data/model/kid_attendee_model.dart';
import '../../data/remote_data_source/community_remote_data_source.dart';
import '../../data/repository/community_repository.dart';
import '../../domain/repository/base_community_repository.dart';

import '../../domain/usecase/send_ticket_request_use_case.dart';
import 'event_profile_controller.dart';
class NewTicketController extends GetxController {





  final newAttendeeFormKey = GlobalKey<FormState>();

  resetNewAttendee() {
    attendeeOnTicketNameController.text = '';
    attendeeOnTicketAgeController.text = '';
    attendeeType = "adult";
    update();
  }

  removeAdultAttendee(int index) {
    adultAttendees.removeAt(index);
    update();
  }

  removeKidAttendee(int index) {
    kidsAttendees.removeAt(index);
    update();
  }

  bool sendingTicketRequest = false;
  sendTicketRequest() async {
    final authC = Get.find<CurrentUserController>();
    if (authC.currentUser == null) {
      customSnackBar(
          title: "",
          message: "You have to login to be able to buy a ticket",
          successful: false);
    }
    sendingTicketRequest = true;
    update();

    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);
    double total = ((selectedEvent.underFiveFree
                ? kidsAttendees.where((element) => element.age >= 5).length
                : kidsAttendees.length) *
            selectedEvent.kidTicketPrice) +
        ((adultAttendees.length + 1) * selectedEvent.adultTicketPrice);
    EventTicketRequest ticketRequest = EventTicketRequest(
        userId: authC.currentUser!.id,
        eventId: selectedEvent.id,
        bankHolderName: bankHolderNameController.text,
        adults: adultAttendees,
        kids: kidsAttendees,
        total: total);
    final result = await SendTicketRequestUseCase(communityRepository)
        .execute(ticketRequest);
    result.fold(
        (l) => customSnackBar(
            title: "",
            message: l.type == "UniqueConstraintError"
                ? "you already asked for ticket, Your request is being reviewed"
                : l.message.toString(),
            successful: false), (r) async {
      customSnackBar(title: "", message: r, successful: true);
      final result= await GetEventAdminsUseCase(CommunityRepository(CommunityRemoteDataSource())).execute(selectedEvent.community.id);
      result.fold((l) => null, (r) {
        NotificationController notificationController =
        Get.find<NotificationController>();
for (var admin in r) {
  notificationController.sendNotification(NotificationModel(
      body:'${authC.currentUser!.name} requested to attend ${selectedEvent.name} event',
      title:
      "New Ticket Request!"     ,
      receiverToken: admin.deviceToken));


}
      });


      Get.offAllNamed(AppConstants.homePage);
    });

    sendingTicketRequest = false;

    update();
  }

  TextEditingController attendeeOnTicketNameController =
      TextEditingController();
  TextEditingController attendeeOnTicketAgeController = TextEditingController();
  TextEditingController bankHolderNameController = TextEditingController();
  List<KidAttendeeModel> kidsAttendees = [];
  List<AdultAttendeeModel> adultAttendees = [];

  addAttendee() {
    if (newAttendeeFormKey.currentState!.validate()) {
      String attendeeName = attendeeOnTicketNameController.text;
      bool isDuplicate = false;

      // Check for duplicates in adult attendees list
      for (var attendee in adultAttendees) {
        if (attendee.name == attendeeName) {
          isDuplicate = true;
          break;
        }
      }

      // Check for duplicates in kids attendees list
      for (var attendee in kidsAttendees) {
        if (attendee.name == attendeeName) {
          isDuplicate = true;
          break;
        }
      }

      if (!isDuplicate) {
        if (attendeeType == "adult") {
          adultAttendees.add(AdultAttendeeModel(attendeeName));
        } else {
          kidsAttendees.add(KidAttendeeModel(attendeeName,
              age: int.parse(attendeeOnTicketAgeController.text),
              cost: selectedEvent.underFiveFree
                  ? (double.parse(attendeeOnTicketAgeController.text) < 5
                      ? 0
                      : selectedEvent.kidTicketPrice)
                  : selectedEvent.kidTicketPrice));
        }
        resetNewAttendee();
        Get.back();
        update();
      } else {
        customSnackBar(
            title: "",
            message: "attendee exist with the same name",
            successful: false);
      }
    }
  }

  String attendeeType = "adult";

  onAttendeeTypeChange(String value) {
    attendeeType = value;
    log(attendeeType);
    update();
  }


late EventModel selectedEvent;

  @override
  void onInit() {
    final eventProfileController= Get.find<EventProfileController>();
    final authC = Get.find<CurrentUserController>();

    selectedEvent = eventProfileController.selectedEvent;
    adultAttendees
        .add(AdultAttendeeModel(authC.currentUser!.name));
    super.onInit();
  }
}
