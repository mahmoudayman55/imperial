import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:imperial/auth_module/data/models/user_model.dart';
import 'package:imperial/auth_module/presentation/controller/user_join_requests_controller.dart';
import 'package:imperial/community_module/presentation/controller/community_controller.dart';
import 'package:imperial/user_module/presentation/controller/persone_profile_controller.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import 'package:imperial/widgets/data_viewer_widget.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import '../core/utils/custom_colors.dart';
import '../widgets/community_admin_widget.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/event_slider.dart';
import '../widgets/event_widget.dart';
import '../widgets/onBoarding_next_Button.dart';
import 'package:get/get.dart';

class PersonProfileView extends StatelessWidget {

  PersonProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      double width = 100.w;
      double height = 100.h;
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NextButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icons.arrow_back_ios_rounded,
              ),
            )),
        backgroundColor: Colors.grey.shade100,
        body: GetBuilder<PersonProfileController>(builder: (c) {
          return c.gettingPerson
              ? SizedBox(
              width: width,
              height: height,
              child: Center(child: LoadingScreen(width * 0.1)))
              : Column(
            children: [
              SizedBox(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    CustomCachedNetworkImage(
                        imageUrl: c.selectedUser.coverPicUrl,
                        width: width,
                        height: height * 0.3),
                    Container(
                      width: width,
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -height * 0.08,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            ClipOval(
                              child: CustomCachedNetworkImage(
                                imageUrl: c.selectedUser.picUrl,
                                width: width * 0.3,
                                height: width * 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: height*0.7,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 1,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.07,
                          ),
                          Text(
                            c.selectedUser.name,
                            textAlign: TextAlign.center,
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(color: Colors.black),
                          ),
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: c.selectedUser.community == null
                                        ? "Not Member Of Any Community"
                                        : '${c.selectedUser.role} of ',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                        color:
                                        c.selectedUser.community == null
                                            ? Colors.red
                                            : Colors.grey)),
                                TextSpan(
                                    text: c.selectedUser.community == null
                                        ? ""
                                        : c.selectedUser.community!.name,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(color: Colors.black)),
                              ])),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.1,
                                vertical: height * 0.03),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Region",
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                        c.selectedUser.region!.name,
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const VerticalDivider(
                                    color: CustomColors.red,
                                    thickness: 1,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Age",
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                        c.selectedUser.groupAge!.groupAge,
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const VerticalDivider(
                                    thickness: 1,
                                    color: CustomColors.red,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Language",
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                        c.selectedUser.speakingLanguage!.name,
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 2,
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DataViewerWidget(
                            iconSize: width * 0.06,
                            data: c.selectedUser.email,
                            iconData: Icons.email_outlined,
                          ),
                          Divider(),
                          DataViewerWidget(
                              iconSize: width * 0.06,
                              data: c.selectedUser.phone,
                              iconData: Icons.phone_outlined),
                          Divider(),
                          DataViewerWidget(
                              iconSize: width * 0.06,
                              data: c.selectedUser.city!.name,
                              iconData: Icons.location_city), Divider(),
                          DataViewerWidget(
                              iconSize: width * 0.06,
                              data: c.selectedUser.zip,
                              iconData: Icons.location_on_outlined),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
