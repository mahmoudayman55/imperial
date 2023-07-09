import 'package:flutter/material.dart';
import 'package:imperial/auth_module/presentation/controller/home_controller.dart';
import 'package:imperial/community_module/data/model/event_table_model.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:imperial/community_module/presentation/controller/community_events_controller.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';
import 'package:imperial/core/utils/custom_colors.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../community_module/presentation/controller/event_profile_controller.dart';
import '../core/utils/app_constants.dart';

class EventTable extends StatelessWidget {
  final List<Event> events;
  final c = Get.find<CommunityEventsController>();
  final homeController = Get.find<HomeController>();

  EventTable({required this.events});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      double width = 100.w;
      double height = 100.h;
      return c.removingEvent
          ? LoadingScreen(width * 0.1)
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: width * 0.02,
          headingRowColor:
          MaterialStateColor.resolveWith((states) => CustomColors.red),
          columns: [
            DataColumn(
                label: Text(
                  '',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                )),
            DataColumn(
                label: Text(
                  'Event Name',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                )),

            DataColumn(
                label: Text(
                  'Date',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                )), DataColumn(
                label: Text(
                  'tickets',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                )),
            DataColumn(
                label: Text(
                  'Go to event',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                )),
          ],
          rows: events
              .asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final event = entry.value;
            final isOddRow = index % 2 == 1;
            final rowColor = isOddRow ? Colors.grey.shade300 : Colors.white;
            return DataRow(
              color: MaterialStateProperty.resolveWith<Color>(
                      (states) => rowColor),
              cells: [
                DataCell(
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(padding: EdgeInsets.zero,
                        onPressed: () => c.removeEvent(event.id),
                        icon: Icon(
                          Icons.delete_forever,
                          color: CustomColors.red, size: width * 0.04,
                        )),
                  ),
                ),
                DataCell(
                  Text(
                    event.name,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),

                DataCell(
                  Text(
                    DateFormat('dd/MM/yyyy').format(event.appointment),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                DataCell(
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(padding: EdgeInsets.zero,
                        onPressed: () =>Get.toNamed(AppConstants.eventTicketsPage,arguments: event.id),
                        icon: Icon(
                          Icons.sticky_note_2_outlined,
                          color: CustomColors.red, size: width * 0.04,
                        )),
                  ),
                ), DataCell(
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(padding: EdgeInsets.zero,
                        onPressed: () =>
                            Get.toNamed(AppConstants.eventProfilePage,
                                arguments: event.id)
                        ,
                        icon: Icon(
                          Icons.double_arrow,
                          color: CustomColors.red, size: width * 0.04,
                        )),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      );
    });
  }
}
