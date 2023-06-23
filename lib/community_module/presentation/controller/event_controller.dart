import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:imperial/auth_module/data/models/notification_model.dart';
import 'package:imperial/auth_module/data/models/user_model.dart';
import 'package:imperial/auth_module/data/models/user_ticket_model.dart';
import 'package:imperial/auth_module/data/models/user_ticket_request_model.dart';
import 'package:imperial/auth_module/data/remote_data_source/auth_remote_data_source.dart';
import 'package:imperial/auth_module/data/repository/auth_repository.dart';
import 'package:imperial/auth_module/domain/entities/notification.dart';
import 'package:imperial/auth_module/domain/usecase/get_user_ticket_requests_use_case.dart';
import 'package:imperial/auth_module/presentation/controller/auth_controller.dart';
import 'package:imperial/auth_module/presentation/controller/notofication_controller.dart';
import 'package:imperial/community_module/data/model/adult_attendee_model.dart';
import 'package:imperial/community_module/data/model/community_event_model.dart';
import 'package:imperial/community_module/data/model/community_ticket_request_model.dart';
import 'package:imperial/community_module/data/model/new_event_model.dart';
import 'package:imperial/community_module/data/model/user_member_model.dart';
import 'package:imperial/community_module/domain/usecase/add_attendee_use_case.dart';
import 'package:imperial/community_module/domain/usecase/add_new_event_use_case.dart';
import 'package:imperial/community_module/domain/usecase/get_event_admins_use_case.dart';
import 'package:imperial/community_module/domain/usecase/get_event_tickets_use_case.dart';
import 'package:imperial/community_module/domain/usecase/remove_event_use_case.dart';
import 'package:imperial/core/utils/app_constants.dart';
import 'package:imperial/view/new_ticket_view.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/community_module/domain/usecase/get_event_of_community_use_case.dart';
import 'package:imperial/view/community_events_view.dart';
import 'package:imperial/view/event_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../app_init_module/data/local_data_source/hive/base_app_iti_local_data_source.dart';
import '../../../app_init_module/data/models/request_communities_model.dart';
import '../../../app_init_module/data/remote_data_source/app_init_remote_data_source.dart';
import '../../../app_init_module/data/repository/app_init_repository.dart';
import '../../../app_init_module/domain/entities/region_entity.dart';
import '../../../app_init_module/domain/repository/base_app_init_repository.dart';
import '../../../app_init_module/domain/usecases/get_selected_region_usecase.dart';
import '../../../auth_module/data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import '../../../core/utils/custom_colors.dart';
import '../../../view/community_join_requests_view.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../data/model/bank_account_model.dart';
import '../../data/model/event_model.dart';
import '../../data/model/event_ticket_request.dart';
import '../../data/model/kid_attendee_model.dart';
import '../../data/remote_data_source/community_remote_data_source.dart';
import '../../data/repository/community_repository.dart';
import '../../domain/repository/base_community_repository.dart';
import 'package:imperial/community_module/domain/entity/event.dart';

import '../../domain/usecase/get_event_by_id.dart';
import '../../domain/usecase/get_events_use_case.dart';
import '../../domain/usecase/send_ticket_request_use_case.dart';
import '../view/event_tickets_view.dart';

class EventController extends GetxController {
  late RxList<Event> _events;
  final newEventFormKey = GlobalKey<FormState>();
  final newAttendeeFormKey = GlobalKey<FormState>();

  resetNewAttendee() {
    attendeeOnTicketNameController.text = '';
    attendeeOnTicketAgeController.text = '';
    attendeeType = "adult";
    update();
  }

  late RxList<Event> _communityEvents;
  RxBool loadingHomeEvents = false.obs;
  bool gettingEvent = false;

  bool addingAttendee = false;

  scanTicketQr(BuildContext context, double height, double width) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    Barcode? result;
    QRViewController? controller;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: height * 0.4,
            width: width * 0.8,
            child: QRView(
              overlay: QrScannerOverlayShape(
                borderColor: CustomColors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.6,
              ),
              key: qrKey,
              onQRViewCreated: (QRViewController qrController) {
                controller = qrController;
                qrController.scannedDataStream.listen((scanData) {
                  if (result == null) {
                    result = scanData;
                    controller!.pauseCamera(); // pause the camera
                    Navigator.pop(context);
                  }
                });
              },
            ),
          ),
        );
      },
    ).then((value) {
      if (result != null) {
        // Handle the scanned QR code here
        log(result!.code.toString());
        showTicketDetails(result!.code.toString(), context, height,
            width); // close the dialog
      } else {}
      if (controller != null) {
        controller!.dispose(); // dispose of the controller when done
      }
    });
  }

  showTicketDetails(
      String token, BuildContext context, double height, double width) {
    UserTicketModel request;
    try {
      final jwt = JWT.verify(
          token, SecretKey('9-_U7JlTqZD7dRgJxRzawv7c3z8QOZLWq5pF2G7nLdI'));
      request = UserTicketModel.fromQrJson(jwt.payload);
      log(jwt.payload.toString());
    } on Exception catch (e) {
      customSnackBar(
          title: "error",
          message: "invalid QR code, try again",
          successful: false);
      return;
    }
    // customSnackBar(title: "", message: request.event.name, successful: true);
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              children: [
                Divider(),
                SizedBox(
                  child: DefaultTabController(
                    initialIndex: 0,
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                            labelStyle: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: CustomColors.red,
                                ),
                            labelColor: CustomColors.red,
                            unselectedLabelColor: Colors.black,
                            unselectedLabelStyle: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.black),
                            indicatorColor: CustomColors.red,
                            onTap: (index) {},
                            tabs: [
                              Tab(
                                  text:
                                      'Adults (${request.adultAttendees.length})'),
                              Tab(
                                  text:
                                      'Kids (${request.kidAttendees.length})'),
                            ]),
                        GetBuilder<EventController>(builder: (c) {
                          return SizedBox(
                            height: height * 0.6,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                request.adultAttendees.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No adult attendees",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(color: Colors.black),
                                        ),
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: SizedBox(
                                          width: width,
                                          child: DataTable(
                                            columnSpacing: width * 0.02,
                                            headingRowColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        CustomColors.red),
                                            columns: [
                                              DataColumn(
                                                  label: Text(
                                                '#',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Name',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              )),
                                            ],
                                            rows: (request.adultAttendees)
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final index = entry.key;

                                              final isOddRow = index % 2 == 1;

                                              final rowColor = isOddRow
                                                  ? Colors.grey.shade300
                                                  : Colors.white;

                                              return DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (states) => rowColor),
                                                cells: [
                                                  DataCell(
                                                    Text(
                                                      (index + 1).toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      request
                                                          .adultAttendees[index]
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                request.kidAttendees.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No adult attendees",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(color: Colors.black),
                                        ),
                                      )
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: SizedBox(
                                          width: width,
                                          child: DataTable(
                                            columnSpacing: width * 0.02,
                                            headingRowColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        CustomColors.red),
                                            columns: [
                                              DataColumn(
                                                  label: Text(
                                                '#',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Name',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'age',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              )),
                                            ],
                                            rows: request.kidAttendees
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final index = entry.key;

                                              final event = entry.value;

                                              final isOddRow = index % 2 == 1;

                                              final rowColor = isOddRow
                                                  ? Colors.grey.shade300
                                                  : Colors.white;

                                              return DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (states) => rowColor),
                                                cells: [
                                                  DataCell(
                                                    Text(
                                                      (index + 1).toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      request
                                                          .kidAttendees[index]
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      request
                                                          .kidAttendees[index]
                                                          .age
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
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
                request.bankHolder != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bank account holder:",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Colors.black),
                          ),

                          Text(
                            request.bankHolder!,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.black),
                          ),

                          // ListView.separated(itemBuilder: (context,index){

                          //   return

                          //

                          // }, separatorBuilder: separatorBuilder, itemCount: itemCount)
                        ],
                      )
                    : SizedBox(),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Adult tickets cost:",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.black),
                    ),

                    Text(
                      request.adultTicketPrice.toString(),
                      style: Theme.of(context)
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "kids tickets cost:",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.black),
                    ),

                    Text(
                      request.kidTicketPrice.toString(),
                      style: Theme.of(context)
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "total:",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.black),
                    ),

                    Text(
                      (request.kidTicketPrice + request.adultTicketPrice)
                          .toString(),
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.black),
                    ),

                    // ListView.separated(itemBuilder: (context,index){

                    //   return

                    //

                    // }, separatorBuilder: separatorBuilder, itemCount: itemCount)
                  ],
                )
              ],
            ),
          );
        });
  }

  Future<void> generateQRCodeFromObject(
    BuildContext context,
    UserTicketModel ticket,
  ) async {
    final authC = Get.find<AuthController>();
    final jwt = JWT(
      // Payload
      ticket.toJson(),
    );
    String token =
        jwt.sign(SecretKey('9-_U7JlTqZD7dRgJxRzawv7c3z8QOZLWq5pF2G7nLdI'));

    // Generate a QR code image from the JWT token
    final qrCode = QrImageView(
      data: token,
      version: QrVersions.auto,
      embeddedImage: AssetImage("assets/images/logoqr.jpg.png"),
      embeddedImageStyle: const QrEmbeddedImageStyle(
        size: Size(75, 25),
      ),
      size: 300,
    );
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: qrCode,
          );
        });
  }

  addEventAttendee(
      {required int eventId,
      required int userId,
      required int ticketId,
      required String token}) async {
    addingAttendee = true;
    update();
    final result = await AddEventAttendeeUseCase(
            CommunityRepository(CommunityRemoteDataSource()))
        .execute(eventId: eventId, userId: userId, ticketId: ticketId);
    result.fold(
        (l) => customSnackBar(
            title: "error",
            message: l.message.toString(),
            successful: false), (r) {
      customSnackBar(title: "Done!", message: r, successful: true);
      NotificationController notificationController =
          Get.find<NotificationController>();
      notificationController.sendNotification(NotificationModel(
          body: "Ticket Request",
          title: 'Your ticket request has been accepted!',
          receiverToken: token));
      int i = tickets.indexWhere((element) => element.id == ticketId);
      tickets[i].status = 1;
      update();
    });

    addingAttendee = false;
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

  removeInstruction(int index) {
    instructionsFormFields.removeAt(index);
    instructionsTextEditingControllers.removeAt(index);
    update();
  }

  addInstruction(BuildContext context) {
    final controller = TextEditingController();
    instructionsTextEditingControllers.add(controller);
    instructionsFormFields.add(CustomTextFormField(
      validator: (value) {
        if (controller.text.isEmpty) {
          return "this field cannot be empty, remove it instead.";
        }
      },
      controller: controller,
      context: context,
      label: '',
      labelColor: Colors.black,
      color: Colors.grey.shade400,
    ));
    update();
  }

  onSelectMembersOnly(bool newValue) {
    onlyMembersCanAttend = newValue;
    update();
  }

  onSelectUnderFive(bool newValue) {
    freeUnder5 = newValue;
    update();
  }

  onSelectLanguage(bool value, int index) {
    final speakingLanguageController = Get.find<AuthController>();

    value
        ? allowedLanguages
            .add(speakingLanguageController.speakingLanguages[index].id)
        : allowedLanguages
            .remove(speakingLanguageController.speakingLanguages[index].id);
    update();
  }

  addImages() async {
    images.addAll(await ImagePicker().pickMultiImage(imageQuality: 50));
    update();
  }

  RxList<Event> get communityEvents => _communityEvents;

  set communityEvents(RxList<Event> value) {
    _communityEvents = value;
  }

  late EventModel selectedEvent;
  int currentEventCover = 0;

  onCoverChanged(int index) {
    currentEventCover = index;
    update();
  }

  bool gettingCommunityEvents = false;

  getCommunityEvents(int id) async {
    gettingCommunityEvents = true;
    update();
    Get.to(CommunityEventsView());

    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);

    final result =
        await GetCommunityEventUseCase(communityRepository).execute(id);
    result.fold((l) => null, (r) => _communityEvents.assignAll(r));
    _communityEvents.refresh();
    gettingCommunityEvents = false;
    update();
  }

  String getMonthName(int monthNumber) {
    String monthName;
    switch (monthNumber) {
      case 1:
        monthName = "January";
        break;
      case 2:
        monthName = "February";
        break;
      case 3:
        monthName = "March";
        break;
      case 4:
        monthName = "April";
        break;
      case 5:
        monthName = "May";
        break;
      case 6:
        monthName = "June";
        break;
      case 7:
        monthName = "July";
        break;
      case 8:
        monthName = "August";
        break;
      case 9:
        monthName = "September";
        break;
      case 10:
        monthName = "October";
        break;
      case 11:
        monthName = "November";
        break;
      case 12:
        monthName = "December";
        break;
      default:
        monthName = "Invalid month number";
    }
    return monthName.substring(0, 3);
  }

  getEvent(int id) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      customSnackBar(
        title: "error",
        message: "No internet connection",
        successful: false,
      );
      return;
    }
    Get.to(EventView());
    gettingEvent = true;
    update();
    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);

    final result = await GetEventByIdUseCase(communityRepository).execute(id);
    result.fold((l) => null, (r) => selectedEvent = (r as EventModel));
    gettingEvent = false;
    update();
  }

  bool sendingTicketRequest = false;
  List<CommunityTicketRequest> tickets = [];

  bool gettingEventTickets = false;

  getEventTickets(int eventId) async {
    gettingEventTickets = true;
    update();
    Get.to(EventsTicketsView(eventId));
    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);
    final result =
        await GetEventTicketsUseCase(communityRepository).execute(eventId);
    result.fold((l) => null, (r) => tickets = r);

    gettingEventTickets = false;
    update();
  }

  sendTicketRequest() async {
    final authC = Get.find<AuthController>();
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


      Get.offAllNamed("/home");
    });

    sendingTicketRequest = false;

    update();
  }

//new event fields controllers
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventOrganizerPhoneController = TextEditingController();
  TextEditingController eventAddressController = TextEditingController();
  TextEditingController eventAdultTicketPriceController =
      TextEditingController();
  TextEditingController eventReferenceNumberController =
      TextEditingController();
  TextEditingController eventKidTicketPriceController = TextEditingController();
  TextEditingController eventMaxAttendeesController = TextEditingController();
  TextEditingController eventDetailsController = TextEditingController();
  String eventDate = "date";
  String eventTime = "time";
  List<CustomTextFormField> instructionsFormFields = [];
  List<TextEditingController> instructionsTextEditingControllers = [];
  bool onlyMembersCanAttend = false;
  bool freeUnder5 = false;
  Map<CustomTextFormField, String> instructions = {};
  List<int> allowedLanguages = [];
  List<XFile> images = [];

  // Future<void> uploadEventCovers() async {
  //   final fileList = await Future.wait(images.map((e) async {
  //     final file = dio.MultipartFile.fromFile(e.path,
  //         filename: e.name, contentType: MediaType('image', 'jpeg'));
  //     return file;
  //   }));
  //
  //   final formData = dio.FormData.fromMap({
  //     "name": "Annual Charity Walk2",
  //     "appointment": "2023-06-12 10:00:00+00:00",
  //     "phone": "555-1234",
  //     "address": "123 Elm St",
  //     "details": "Help support our local charity by joining us for a 5k walk!",
  //     "ticket_price": 25.99,
  //     "community_id": 1,
  //     "max_attendees": 50,
  //     "members_only": false,
  //     "instructions": [
  //       "Please arrive on time to ensure a prompt start",
  //       "Please keep the venue clean and tidy, and dispose of any rubbish in the appropriate bins",
  //       "Food and drinks are not allowed in the event venue",
  //       "Please do not take photographs or record the event without the consent of the organizers and the speaker",
  //       "If you require any special accommodations, please inform the organizers before the event",
  //       "Have fun and enjoy the event!"
  //     ],
  //     "languages": [1, 2],
  //     'covers': fileList,
  //   });
  //
  //   // Send the FormData object using dio
  //   dio.Dio dio2 = dio.Dio();
  //
  //   dio.Response response = (await dio2.post(
  //     AppConstants.eventsRoute,
  //     data: formData,
  //   ));
  // }

  bool creatingEvent = false;

  createEvent() async {
    if (newEventFormKey.currentState!.validate()) {
      if (instructionsTextEditingControllers.isEmpty) {
        customSnackBar(
            title: "",
            message: "You have to add at least 1 instruction",
            successful: false);
      } else if (allowedLanguages.isEmpty) {
        customSnackBar(
            title: "",
            message: "You have to add at least 1 allowed language",
            successful: false);
      } else if (eventDate == "date") {
        customSnackBar(
            title: "",
            message: "You did not select event date",
            successful: false);
      } else if (eventTime == "time") {
        customSnackBar(
            title: "",
            message: "You did not select event time",
            successful: false);
      } else if (images.isEmpty) {
        customSnackBar(
            title: "",
            message: "You have to add at least 1 image",
            successful: false);
      } else {
        creatingEvent = true;
        update();
        String dateString = '$eventDate $eventTime';
        log(dateString);
        DateTime dateTime =
            DateFormat('MMMM dd, yyyy h:mm a').parse(dateString);
        log('eventDate: $dateTime');
        BaseCommunityRemoteDataSource communityRemoteDataSource =
            CommunityRemoteDataSource();
        BaseCommunityRepository communityRepository =
            CommunityRepository(communityRemoteDataSource);
        final authController = Get.find<AuthController>();

        final result =
            await AddNewEventUseCase(communityRepository).execute(NewEventModel(
          instructions:
              instructionsTextEditingControllers.map((e) => e.text).toList(),
          languages: allowedLanguages,
          images: images,
          communityId: authController.currentUser!.community!.id,
          name: eventNameController.text,
          appointment: dateTime,
          phone: eventOrganizerPhoneController.text,
          address: eventAddressController.text,
          details: eventDetailsController.text,
          adultTicketPrice: double.parse(eventAdultTicketPriceController.text),
          membersOnly: onlyMembersCanAttend,
          maxAttendees: int.parse(eventMaxAttendeesController.text),
          kidTicketPrice: double.parse(eventKidTicketPriceController.text),
          underFiveFree: freeUnder5,
          referenceNumber: eventReferenceNumberController.text,
        ));
        result.fold(
            (l) => customSnackBar(
                title: "error",
                message: l.message.toString(),
                successful: false), (r) {
          customSnackBar(title: "Done", message: r, successful: true);
          Get.offAllNamed('/home');
        });
        creatingEvent = false;
        update();
      }
    }
  }

  void showPaymentDialog(BuildContext context, double width, double height) {
    final authC = Get.find<AuthController>();

    if (authC.currentUser == null) {
      customSnackBar(
          title: "",
          message: "You have to login to be able to buy a ticket",
          successful: false);
      return;
    }
    else if (authC.currentUser!.role == "admin" &&
        authC.currentUser!.community!.id == selectedEvent.community.id) {
      customSnackBar(
          title: "",
          message:
          "You cannot buy ticket for your event.",
          successful: false);
      return;
    }
    else if (!(selectedEvent.speakingLanguages
        .map((e) => e.id)
        .toList()
        .contains(authC.currentUser!.speakingLanguage!.id))) {
      customSnackBar(
          title: "",
          message:
              "This event is only for certain language speakers, not including yours, please check allowed languages",
          successful: false);
      return;
    }
  else if (selectedEvent.appointment.isAtSameMomentAs(DateTime.now()) ||
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
                      adultAttendees.clear();
                      kidsAttendees.clear();
                      adultAttendees
                          .add(AdultAttendeeModel(authC.currentUser!.name));
                      Get.to(NewTicketView());
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

  bool removingEvent = false;

  removeEvent(int id) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      customSnackBar(
        title: "error",
        message: "No internet connection",
        successful: false,
      );
      return;
    }
    removingEvent = true;
    update();
    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);
    final result = await RemoveEventUseCase(communityRepository).execute(id);
    result.fold(
        (l) => customSnackBar(
            title: "", message: l.message.toString(), successful: false),
        (r) => customSnackBar(title: "", message: r, successful: true));
    communityEvents.removeWhere((element) => element.id == id);
    removingEvent = false;
    update();
  }

  List<Event> get events => _events.toList();
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

  set setEvents(RxList<Event> value) {
    _events = value;
  }

  removeImage(int index) {
    images.removeAt(index - 1);
    update();
  }

  getEvents() async {
    loadingHomeEvents.value = true;
    loadingHomeEvents.refresh();
    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);

    BaseAppInitRemoteDataSource appInitRemoteDataSource =
        AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
        AppInitLocalDataSource();
    BaseAppInitRepository appInitRepository =
        AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    final selectedRegionResult =
        await GetSelectedRegionUseCase(appInitRepository).execute();
    late Region region;
    selectedRegionResult.fold((l) => log(l.toString()), (r) => region = r);

    LimitParametersModel queryParameters = LimitParametersModel(
        regionId: region.id, limit: 3, offset: _events.length);
    final result =
        await GetEventsUseCase(communityRepository).execute(queryParameters);
    result.fold((l) => null, (r) => _events.assignAll(r));
    loadingHomeEvents.value = false;
    loadingHomeEvents.refresh();
    // This line will update any UI that is observing the communities field.
    _events.refresh();
  }

  @override
  void onInit() {
    _events = <Event>[].obs;
    _communityEvents = <Event>[].obs;
    getEvents();
    super.onInit();
  }
}
