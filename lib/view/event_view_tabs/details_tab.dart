import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';
import 'package:sizer/sizer.dart';

class DetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      final double height = 100.h;
      final double width = 100.w;
      return GetBuilder<EventController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            controller.selectedEvent.details,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Colors.black),
          ),
        );
      });
    });
  }
}
