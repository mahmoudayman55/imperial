import 'dart:ui';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:imperial/community_module/presentation/controller/community_controller.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';

import 'package:imperial/view/home_view.dart';
import 'package:imperial/view/new_event_view.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/account_type_selector.dart';
import 'package:imperial/widgets/community_join_request.dart';
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
import '../widgets/event_table.dart';

class CommunityJoinRequestsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      double width = 100.w;
      double height = 100.h;

      return deviceType == DeviceType.mobile
          ? Scaffold(
              appBar: AppBar(
                  title: Text(
                    "Join requests",
                    style: Theme.of(context).textTheme.headlineMedium,
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
                child: GetBuilder<CommunityController>(builder: (controller) {
                  return controller.gettingJoinRequests
                      ? Center(child: LoadingScreen(width * 0.1))
                      : controller.communityJoinRequests.isEmpty? Center(
                    child: Text(
                      "You do not have any join requests yet",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ): ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CommunityJoinRequestWidget(
                                  request:
                                      controller.communityJoinRequests[i],
                                  width: width,
                                  height: height),
                            );
                          },
                          itemCount:
                              controller.communityJoinRequests.length,
                        );
                }),
              ))
          : SizedBox();
    });
  }
}
// Todo:Tablet
