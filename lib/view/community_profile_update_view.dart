import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:imperial/auth_module/presentation/controller/user_join_requests_controller.dart';
import 'package:imperial/community_module/presentation/controller/update_community_profile_controller.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
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

class CommunityUpdateProfileView extends StatelessWidget {

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
        body: GetBuilder<UpdateCommunityProfileController>(builder: (c) {
          return c.updatingCommunity
              ? SizedBox(
                  width: width,
                  height: height,
                  child: Center(child: LoadingScreen(width * 0.1)))
              : SizedBox(height: height,
                child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomCachedNetworkImage(
                                imageUrl: c
                                    .currentCommunity.coverUrl,
                                width: width,
                                height: height),
                            Container(
                              width: width,
                              height: height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: const LinearGradient(
                                  colors: [Colors.black, Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () =>c.updateCommunityCover(),
                                child: Container(
                                  width: width,
                                  height: width * 0.08,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  child: Icon(
                                    Icons.camera_enhance_outlined,
                                    size: width * 0.06,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ),
                            Container(padding: EdgeInsets.all(8 ),
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4),borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                c.currentCommunity.name,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 1,
                        child: Container(decoration: BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(color: Colors.grey.shade200,blurRadius: 2,spreadRadius: 2,offset: Offset.fromDirection(0,5))],borderRadius:
                        BorderRadius.only(bottomLeft:Radius.circular(10) ,bottomRight: Radius.circular(10))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Members",
                                    textAlign: TextAlign.center,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text(
                                   c.currentCommunity.membersNumber.toString(),
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
                              Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Events",
                                    textAlign: TextAlign.center,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text(
                                    c.currentCommunity.eventsNumber.toString(),
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
                              Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Admins",
                                    textAlign: TextAlign.center,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text(
                                    c.currentCommunity.admins.length.toString(),
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
                      Expanded(
                        flex:10,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(height: height*0.64,
                              child: Form(key: c.updateCommunityFormKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextFormField(
                                        validator: (v){
                                          if(c.communityUpdateNameController.text.isEmpty){
                                            return "This filed cannot be empty";
                                          }
                                          return null;
                                        },
                                        controller: c.communityUpdateNameController,
                                        context: context,
                                        label: "Community Name",
                                        labelColor: Colors.black,
                                        textColor: Colors.black,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextFormField(  validator: (v){
                                        if(c.communityUpdateAddressController.text.isEmpty){
                                          return "This filed cannot be empty";
                                        }
                                        return null;
                                      },
                                        controller:
                                        c.communityUpdateAddressController,
                                        context: context,
                                        label: "address",
                                        labelColor: Colors.black,
                                        textColor: Colors.black,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextFormField(validator: (v){
                                        if(c.communityUpdateWebUrlController.text.isEmpty){
                                          return "This filed cannot be empty";
                                        }
                                        return null;
                                      },
                                        controller:
                                        c.communityUpdateWebUrlController,
                                        context: context,keyboardType: TextInputType.url,
                                        label: "Website URL",
                                        labelColor: Colors.black,
                                        textColor: Colors.black,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextFormField(validator: (v){
                                        if(c.communityUpdateAboutController.text.isEmpty){
                                          return "This filed cannot be empty";
                                        }
                                        return null;
                                      },
                                        controller:
                                        c.communityUpdateAboutController,
                                        context: context,
                                        label: "About",
                                        labelColor: Colors.black,
                                        maxLines: 5,
                                        textColor: Colors.black,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: CustomButton(
                                        height: height * 0.06,
                                        width: width,
                                        onPressed: () {
                                          c.updateCommunity();
                                        },
                                        label: 'Update',
                                        useGradient: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              );
        }),
      );
    });
  }
}
