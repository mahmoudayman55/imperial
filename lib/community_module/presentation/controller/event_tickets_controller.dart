import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperial/app_init_module/presentation/view/onboarding/intro_screen2.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../auth_module/data/models/notification_model.dart';
import '../../../auth_module/data/models/user_ticket_model.dart';
import '../../../auth_module/presentation/controller/notofication_controller.dart';
import '../../../core/utils/custom_colors.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../data/model/community_ticket_request_model.dart';
import '../../data/remote_data_source/community_remote_data_source.dart';
import '../../data/repository/community_repository.dart';
import '../../domain/repository/base_community_repository.dart';
import '../../domain/usecase/add_attendee_use_case.dart';
import '../../domain/usecase/get_event_tickets_use_case.dart';
import 'event_controller.dart';

class EventTicketsController extends GetxController{

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
                        SizedBox(
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
                        )
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
          title: "Ticket Request",
          body: 'Your ticket request has been accepted!',
          receiverToken: token));
      int i = tickets.indexWhere((element) => element.id == ticketId);
      tickets[i].status = 1;
      update();
    });

    addingAttendee = false;
    update();
  }

  List<CommunityTicketRequest> tickets = [];
  late int eventId;
  getEventTickets() async {
    gettingEventTickets = true;
    update();
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
  bool gettingEventTickets = false;

  @override
  void onInit() {
    eventId=Get.arguments;
    getEventTickets();
    super.onInit();
  }
}