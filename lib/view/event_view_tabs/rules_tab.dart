import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sizer/sizer.dart';

import '../../community_module/presentation/controller/event_controller.dart';
import '../../core/utils/custom_colors.dart';

class RulesTab extends StatelessWidget {
  double width;
  double height;

  RulesTab({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      final double height = 100.h;
      final double width = 100.w;
      return deviceType == DeviceType.mobile
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<EventController>(builder: (controller) {
                return Column(
                  children: [
                    for (int i = 0;
                        i < controller.selectedEvent.instructions.length;
                        i++)
                      Row(
                        children: [
                          Container(
                            width: width * 0.03,
                            height: width * 0.03,
                            margin:  EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 2.w),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColors.red,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              controller.selectedEvent.instructions[i],
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          )
                        ],
                      )
                  ],
                );
              }),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  for (int i = 0; i < 6; i++)
                    Row(
                      children: [
                        Container(
                          width: width * 0.02,
                          height: width * 0.02,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: width * 0.01),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.red,
                          ),
                        ),
                        Text(
                          "rule number $i",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.black),
                        )
                      ],
                    )
                ],
              ),
            );
    });
  }
}
