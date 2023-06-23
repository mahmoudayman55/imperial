import 'package:flutter/cupertino.dart';
import 'package:imperial/auth_module/presentation/controller/auth_controller.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:imperial/community_module/data/model/community_ticket_request_model.dart';
import 'package:imperial/community_module/domain/entity/community_join_request.dart';
import 'package:imperial/community_module/presentation/controller/community_controller.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:get/get.dart';
import '../core/utils/custom_colors.dart';
import '../view/loading_screen.dart';

class CommunityTicketRequestWidget extends StatelessWidget {
  final CommunityTicketRequest request;
  final double width;
  final int eventId;
  final double height;
final authC=Get.find<AuthController>();
final eventC=Get.find<EventController>();
  CommunityTicketRequestWidget(
      {required this.request,
      required this.width,
      required this.height,
      required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    ClipOval(
                      child: CustomCachedNetworkImage(
                          imageUrl: request.user.picUrl,
                          width: width * 0.15,
                          height: width * 0.15),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.user.name,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            DateFormat('MMMM dd, yyyy h:mm a')
                                .format(request.sendingTime),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              request.status == 2
                  ? Expanded(
                      flex: 1,
                      child: GetBuilder<EventController>(builder: (controller) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(10)),
                                child: IconButton(
                                        onPressed: () =>
                                            controller.addEventAttendee(
                                                eventId: eventId,
                                                userId: request.user.id,
                                                ticketId: request.id, token: request.user.deviceToken,),
                                        icon: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: width * 0.06,
                                        ))),
                          ],
                        );
                      }),
                    )
                  : (request.status == 1
                      ? Text(
                          "Accepted",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.lightGreen),
                        )
                      : Text(
                          "Declined",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: CustomColors.red),
                        ))
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {

                          return Dialog(
                            child: ListView(shrinkWrap:  true,padding: EdgeInsets.all(10),
                              children: [
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
                                            unselectedLabelStyle:
                                                Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color: Colors.black),
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
                                        GetBuilder<EventController>(
                                            builder: (c) {
                                          return SizedBox(height: height*1.8,

                                            child: TabBarView(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              children: [
                                                request.adultAttendees.isEmpty
                                                    ? Center(
                                                        child: Text(
                                                          "No adult attendees",
                                                          style: Theme.of(
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
                                                                            CustomColors.red),
                                                            columns: [
                                                              DataColumn(
                                                                  label: Text(
                                                                '#',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                              )),
                                                              DataColumn(
                                                                  label: Text(
                                                                'Name',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                              )),
                                                            ],
                                                            rows: (request
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
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .copyWith(
                                                                              color: Colors.black),
                                                                    ),
                                                                  ),
                                                                  DataCell(
                                                                    Text(
                                                                      request
                                                                          .adultAttendees[
                                                                              index]
                                                                          .name,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .copyWith(
                                                                              color: Colors.black),
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
                                                          style: Theme.of(
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
                                                                            CustomColors.red),
                                                            columns: [
                                                              DataColumn(
                                                                  label: Text(
                                                                '#',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                              )),
                                                              DataColumn(
                                                                  label: Text(
                                                                'Name',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                              )),
                                                              DataColumn(
                                                                  label: Text(
                                                                'age',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                              )),
                                                            ],
                                                            rows: request
                                                                .kidAttendees
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
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .copyWith(
                                                                              color: Colors.black),
                                                                    ),
                                                                  ),
                                                                  DataCell(
                                                                    Text(
                                                                      request
                                                                          .kidAttendees[
                                                                              index]
                                                                          .name,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .copyWith(
                                                                              color: Colors.black),
                                                                    ),
                                                                  ),
                                                                  DataCell(
                                                                    Text(
                                                                      request
                                                                          .kidAttendees[
                                                                              index]
                                                                          .age
                                                                          .toString(),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .copyWith(
                                                                              color: Colors.black),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Adult tickets cost:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(color: Colors.black),
                                    ),

                                    Text(
                                      request.getTotalAdultPrice().toString(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "kids tickets cost:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(color: Colors.black),
                                    ),

                                    Text(
                                      request.getKidsTicketPrice().toString(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "total:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(color: Colors.black),
                                    ),

                                    Text(
                                     request.getTotalTicketPrice()
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
                  },
                  child: Text(
                    "more details",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.lightGreen),
                  )),
              TextButton(
                  onPressed: ()=>authC.openPersonScreen(request.user.id),
                  child: Text(
                    "visit profile",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: CustomColors.red),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
