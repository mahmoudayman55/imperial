import 'dart:developer';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imperial/app_init_module/presentation/controller/app_update_controller.dart';
import 'package:imperial/app_init_module/presentation/controller/region_controller.dart';
import 'package:imperial/auth_module/presentation/controller/user_join_requests_controller.dart';
import 'package:imperial/auth_module/presentation/controller/current_user_controller.dart';
import 'package:imperial/auth_module/presentation/controller/notofication_controller.dart';
import 'package:imperial/core/utils/custom_url_luncher.dart';
import 'package:imperial/service_module/data/model/service_category_model.dart';
import 'package:imperial/service_module/presentation/controller/service_profile_controller.dart';
import 'package:imperial/view/community_events_view.dart';
import 'package:imperial/view/community_join_requests_view.dart';
import 'package:imperial/view/new_ticket_view.dart';
import 'package:imperial/view/loading_screen.dart';
import 'package:imperial/auth_module/presentation/view/user_profile_view.dart';
import 'package:imperial/widgets/account_type_selector.dart';
import 'package:imperial/widgets/change_region_button.dart';
import 'package:imperial/widgets/community_widget.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:imperial/widgets/error_widget.dart';
import 'package:imperial/widgets/menu_button.dart';
import 'package:imperial/widgets/onBoarding_next_Button.dart';
import 'package:imperial/app_init_module/presentation/components/region_selector.dart';
import 'package:imperial/widgets/search_bar.dart' as se;
import 'package:imperial/widgets/service_icon_widget.dart';
import 'package:imperial/widgets/service_widget.dart';
import 'package:imperial/widgets/sign_with_button.dart';
import 'package:imperial/widgets/swipe_up_button.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../app_init_module/domain/entities/region_entity.dart';
import '../auth_module/domain/entities/user_entity.dart';
import '../auth_module/presentation/controller/home_controller.dart';
import '../auth_module/presentation/view/registration/choose_account type.dart';
import '../community_module/domain/entity/community.dart';
import '../community_module/presentation/controller/community_controller.dart';
import '../community_module/presentation/controller/event_controller.dart';
import '../core/utils/app_constants.dart';
import '../core/utils/custom_colors.dart';
import '../../../widgets/custom_password_field.dart';
import '../search_module/presentation/controller/search_controller.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/event_slider.dart';
import '../widgets/event_widget.dart';
import '../widgets/user_info_widget.dart';
import '../auth_module/presentation/view/login.dart';
import 'package:imperial/auth_module/presentation/controller/notofication_controller.dart';

class HomeView extends StatelessWidget {
  AppDataController appDataController = Get.find<AppDataController>();
  CurrentUserController currentUserController =
      Get.find<CurrentUserController>();
  NotificationController notificationC = Get.find<NotificationController>();
  HomeSearchController searchController = Get.find<HomeSearchController>();
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    Future<bool> checkInternetConnection() async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection');
      }
      return true;
    }

    return Sizer(builder: (context, orientation, deviceType) {
      final double height = 100.h;
      final double width = 100.w;

      // List<ServiceIconWidget> mobileServicesIcons = [
      //   ServiceIconWidget(
      //     width: 25.w,
      //     name: 'Restaurants',
      //     iconData: Icons.fastfood_outlined,
      //     color: CustomColors.red,
      //     textColor: Colors.white,
      //   ),
      //   ServiceIconWidget(
      //     width: 25.w,
      //     name: 'Hotels',
      //     iconData: Icons.hotel_outlined,
      //   ),
      //   ServiceIconWidget(
      //     width: 25.w,
      //     name: 'Sport',
      //     iconData: Icons.sports,
      //   ),
      //   ServiceIconWidget(
      //     width: 25.w,
      //     name: 'Family',
      //     iconData: Icons.family_restroom,
      //   ),
      // ];
      // List<ServiceIconWidget> tabServicesIcons = [
      //   ServiceIconWidget(
      //     iconSize: 3,
      //     width: 25.w,
      //     name: 'Restaurants',
      //     iconData: Icons.fastfood_outlined,
      //     color: CustomColors.red,
      //     textColor: Colors.white,
      //   ),
      //   ServiceIconWidget(
      //     width: 25.w,
      //     iconSize: 3,
      //     name: 'Hotels',
      //     iconData: Icons.hotel_outlined,
      //   ),
      //   ServiceIconWidget(
      //     width: 25.w,
      //     iconSize: 3,
      //     name: 'Sport',
      //     iconData: Icons.sports,
      //   ),
      //   ServiceIconWidget(
      //     width: 25.w,
      //     iconSize: 3,
      //     name: 'Family',
      //     iconData: Icons.family_restroom,
      //   ),
      // ];

      // List<CommunityWidget> tabCommunities = [
      //   CommunityWidget(
      //     width: 50.w,
      //     height: 18.h,
      //     name: 'Urdu community of London',
      //     about:
      //         'For Urdu Community to share events, renting,news, jobs, services and more',
      //     events: [
      //       EventWidget(
      //         width: 40.w,
      //         height: 50.h,
      //         whiteLayer: false,
      //         showDetails: false,
      //         image: 'assets/images/evp.png',
      //       )
      //     ],
      //     bg: 'assets/images/aur.jpg',
      //   ),
      //   CommunityWidget(
      //     width: 50.w,
      //     height: 18.h,
      //     name: 'Bengali community of London',
      //     about:
      //         'For bengali Community to share events, renting,news, jobs, services and more',
      //     events: [
      //       EventWidget(
      //         width: 40.w,
      //         height: 50.h,
      //         whiteLayer: false,
      //         showDetails: false,
      //         image: 'assets/images/ege.jpg',
      //       )
      //     ],
      //     bg: 'assets/images/beng.jpg',
      //   ),
      //   CommunityWidget(
      //     width: 50.w,
      //     height: 18.h,
      //     name: 'Urdu community of London',
      //     about:
      //         'For Urdu Community to share events, renting,news, jobs, services and more',
      //     events: [
      //       EventWidget(
      //         width: 40.w,
      //         height: 50.h,
      //         whiteLayer: false,
      //         showDetails: false,
      //         image: 'assets/images/evp.png',
      //       )
      //     ],
      //     bg: 'assets/images/aur.jpg',
      //   ),
      //   CommunityWidget(
      //     width: 50.w,
      //     height: 18.h,
      //     name: 'Bengali community of London',
      //     about:
      //         'For bengali Community to share events, renting,news, jobs, services and more',
      //     events: [
      //       EventWidget(
      //         width: 40.w,
      //         height: 50.h,
      //         whiteLayer: false,
      //         showDetails: false,
      //         image: 'assets/images/ege.jpg',
      //       )
      //     ],
      //     bg: 'assets/images/beng.jpg',
      //   ),
      // ];
      // List<ServiceWidget> mobileServices = [
      //   ServiceWidget(
      //     width: 40.w,
      //     height: 20.h,
      //     imageUrl:
      //         'https://cdn.vox-cdn.com/thumbor/ua5OCiukaOjrq2kf3kHWpVNvFNM=/0x0:2324x1549/1200x0/filters:focal(0x0:2324x1549):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/11641919/DSC_0195_3.jpg',
      //     name: 'Ikoyi Restaurant',
      //     about:
      //         "Ikoyi is a restaurant in central London, St James's and it is founded by friends Iré Hassan-Odukale and Chef Jeremy Chan. We combine bold heat and umami to create our own perspective on seasonality. Ikoyi builds its own spice-based cuisine around British micro-seasonality: vegetables slowly grown for flavour, sustainable, line-caught fish and aged native beef. Our kitchen aims to serve produce in its optimal state, harnessing as much flavour as possible while respecting the true nature of the ingredient.The foundation for our menu is a vast collection of spices with a focus on sub-Saharan West Africa, which we have meticulously sourced over the past few year",
      //     address: '180 Strand, Temple, London WC2R 1EA',
      //   ),
      //   ServiceWidget(
      //     width: 40.w,
      //     height: 15.h,
      //     imageUrl:
      //         'https://ichef.bbci.co.uk/news/976/cpsprodpb/045F/production/_124791110_clos.jpg',
      //     name: 'Clos Maggiore',
      //     about:
      //         "The world's most romantic restaurant, with a open fire and beautiful floral ceiling display in the conservatory and first floor dining room. Perfect for dates, or dinner with friends and colleagues. Excellent, warm service and world class food led by executive chef Marcellin",
      //     address: '33 King St, London WC2E 8JD',
      //   )
      // ];
      // List<ServiceWidget> tabServices = [
      //   ServiceWidget(
      //     iconSize: 3,
      //     width: 20.w,
      //     height: 20.h,
      //     imageUrl:
      //         'https://cdn.vox-cdn.com/thumbor/ua5OCiukaOjrq2kf3kHWpVNvFNM=/0x0:2324x1549/1200x0/filters:focal(0x0:2324x1549):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/11641919/DSC_0195_3.jpg',
      //     name: 'Ikoyi Restaurant',
      //     about:
      //         "Ikoyi is a restaurant in central London, St James's and it is founded by friends Iré Hassan-Odukale and Chef Jeremy Chan. We combine bold heat and umami to create our own perspective on seasonality. Ikoyi builds its own spice-based cuisine around British micro-seasonality: vegetables slowly grown for flavour, sustainable, line-caught fish and aged native beef. Our kitchen aims to serve produce in its optimal state, harnessing as much flavour as possible while respecting the true nature of the ingredient.The foundation for our menu is a vast collection of spices with a focus on sub-Saharan West Africa, which we have meticulously sourced over the past few year",
      //     address: '180 Strand, Temple, London WC2R 1EA',
      //   ),
      //   ServiceWidget(
      //     iconSize: 3,
      //     width: 20.w,
      //     height: 20.h,
      //     imageUrl:
      //         'https://cdn.vox-cdn.com/thumbor/ua5OCiukaOjrq2kf3kHWpVNvFNM=/0x0:2324x1549/1200x0/filters:focal(0x0:2324x1549):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/11641919/DSC_0195_3.jpg',
      //     name: 'Ikoyi Restaurant',
      //     about:
      //         "Ikoyi is a restaurant in central London, St James's and it is founded by friends Iré Hassan-Odukale and Chef Jeremy Chan. We combine bold heat and umami to create our own perspective on seasonality. Ikoyi builds its own spice-based cuisine around British micro-seasonality: vegetables slowly grown for flavour, sustainable, line-caught fish and aged native beef. Our kitchen aims to serve produce in its optimal state, harnessing as much flavour as possible while respecting the true nature of the ingredient.The foundation for our menu is a vast collection of spices with a focus on sub-Saharan West Africa, which we have meticulously sourced over the past few year",
      //     address: '180 Strand, Temple, London WC2R 1EA',
      //   ),
      //   ServiceWidget(
      //     iconSize: 3,
      //     width: 20.w,
      //     height: 20.h,
      //     imageUrl:
      //         'https://cdn.vox-cdn.com/thumbor/ua5OCiukaOjrq2kf3kHWpVNvFNM=/0x0:2324x1549/1200x0/filters:focal(0x0:2324x1549):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/11641919/DSC_0195_3.jpg',
      //     name: 'Ikoyi Restaurant',
      //     about:
      //         "Ikoyi is a restaurant in central London, St James's and it is founded by friends Iré Hassan-Odukale and Chef Jeremy Chan. We combine bold heat and umami to create our own perspective on seasonality. Ikoyi builds its own spice-based cuisine around British micro-seasonality: vegetables slowly grown for flavour, sustainable, line-caught fish and aged native beef. Our kitchen aims to serve produce in its optimal state, harnessing as much flavour as possible while respecting the true nature of the ingredient.The foundation for our menu is a vast collection of spices with a focus on sub-Saharan West Africa, which we have meticulously sourced over the past few year",
      //     address: '180 Strand, Temple, London WC2R 1EA',
      //   ),
      //   ServiceWidget(
      //     iconSize: 3,
      //     width: 20.w,
      //     height: 20.h,
      //     imageUrl:
      //         'https://cdn.vox-cdn.com/thumbor/ua5OCiukaOjrq2kf3kHWpVNvFNM=/0x0:2324x1549/1200x0/filters:focal(0x0:2324x1549):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/11641919/DSC_0195_3.jpg',
      //     name: 'Ikoyi Restaurant',
      //     about:
      //         "Ikoyi is a restaurant in central London, St James's and it is founded by friends Iré Hassan-Odukale and Chef Jeremy Chan. We combine bold heat and umami to create our own perspective on seasonality. Ikoyi builds its own spice-based cuisine around British micro-seasonality: vegetables slowly grown for flavour, sustainable, line-caught fish and aged native beef. Our kitchen aims to serve produce in its optimal state, harnessing as much flavour as possible while respecting the true nature of the ingredient.The foundation for our menu is a vast collection of spices with a focus on sub-Saharan West Africa, which we have meticulously sourced over the past few year",
      //     address: '180 Strand, Temple, London WC2R 1EA',
      //   ),
      //   ServiceWidget(
      //     width: 20.w,
      //     iconSize: 3,
      //     height: 20.h,
      //     imageUrl:
      //         'https://ichef.bbci.co.uk/news/976/cpsprodpb/045F/production/_124791110_clos.jpg',
      //     name: 'Clos Maggiore',
      //     about:
      //         "The world's most romantic restaurant, with a open fire and beautiful floral ceiling display in the conservatory and first floor dining room. Perfect for dates, or dinner with friends and colleagues. Excellent, warm service and world class food led by executive chef Marcellin",
      //     address: '33 King St, London WC2E 8JD',
      //   )
      // ];
      return deviceType == DeviceType.mobile
          ? Scaffold(
              drawer: Drawer(
                child: SafeArea(
                  child: SizedBox(
                    height: height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GetBuilder<CurrentUserController>(builder: (c) {
                        return Column(
                          children: [
                            if (c.currentUser != null)
                              Expanded(
                                flex: 1,
                                child: UserInfoHeader(
                                  user: c.currentUser as User,
                                  height: height * 0.1,
                                  width: width * 0.8,
                                ),
                              ),
                            Expanded(
                              flex: 10,
                              child: ListView(children: [
                                MenuButton(
                                  height: height * 0.05,
                                  width: width * 0.65,
                                  useGradient: false,
                                  onPressed: () {},
                                  icon: Icons.home_outlined,
                                  label: 'Home',
                                ),
                                Divider(),
                                if (c.currentUser == null)
                                  MenuButton(
                                    height: height * 0.05,
                                    width: width * 0.65,
                                    useGradient: false,
                                    onPressed: () {
                                      Get.toNamed(AppConstants.loginPage);
                                    },
                                    icon: Icons.login,
                                    label: 'Sign In',
                                    color: Colors.grey.shade300,
                                    textColor: Colors.black,
                                  ),
                                if (c.currentUser == null) const Divider(),
                                if (c.currentUser == null)
                                  MenuButton(
                                    height: height * 0.05,
                                    width: width * 0.65,
                                    useGradient: false,
                                    onPressed: () {
                                      Get.toNamed(AppConstants.accountTypePage);
                                    },
                                    icon: Icons.app_registration,
                                    label: 'Register',
                                    color: Colors.grey.shade300,
                                    textColor: Colors.black,
                                  ),
                                if (c.currentUser == null) Divider(),
                                if (c.currentUser != null)
                                  MenuButton(
                                    height: height * 0.05,
                                    width: width * 0.65,
                                    useGradient: false,
                                    onPressed: () async {
                                      c.goToProfile();
                                    },
                                    icon: Icons.person_outline,
                                    label: 'Profile',
                                    color: Colors.grey.shade300,
                                    textColor: Colors.black,
                                  ),
                                if (c.currentUser != null) Divider(),
                                if (c.currentUser != null &&
                                    c.currentUser!.role != "admin")
                                  MenuButton(
                                    height: height * 0.05,
                                    width: width * 0.65,
                                    useGradient: false,
                                    onPressed: () async {
                                      Get.toNamed(AppConstants.userJoinRequestPage,arguments: currentUserController.currentUser!.id);
                                    },
                                    icon: Icons.group_add_outlined,
                                    label: 'My join requests',
                                    color: Colors.grey.shade300,
                                    textColor: Colors.black,
                                  ),
                                if (c.currentUser != null &&
                                    c.currentUser!.role != "admin")
                                  Divider(),
                                if (c.currentUser != null)
                                  MenuButton(
                                    height: height * 0.05,
                                    width: width * 0.65,
                                    useGradient: false,
                                    onPressed: () async {
                                      Get.toNamed(AppConstants.userTicketsPage,
                                          arguments: currentUserController
                                              .currentUser!.id);
                                    },
                                    icon: Icons.confirmation_num_outlined,
                                    label: 'My tickets',
                                    color: Colors.grey.shade300,
                                    textColor: Colors.black,
                                  ),
                                if (c.currentUser != null) Divider(),
                                if (c.currentUser != null)
                                  (c.currentUser!.role == 'admin'
                                      ? MenuButton(
                                          height: height * 0.05,
                                          width: width * 0.65,
                                          useGradient: false,
                                          onPressed: () {
                                            Get.toNamed(
                                                AppConstants
                                                    .communityEventsPage,
                                                arguments: currentUserController
                                                    .currentUser!
                                                    .community!
                                                    .id);
                                            // eventsController.getCommunityEvents(
                                            //     c.currentUser!
                                            //         .community!.id);
                                            // eventsController
                                            //     .uploadEventCovers();
                                          },
                                          icon: Icons.event,
                                          label: 'Events',
                                          color: Colors.grey.shade300,
                                          textColor: Colors.black,
                                        )
                                      : SizedBox()),
                                if (c.currentUser != null)
                                  (c.currentUser!.role == 'admin')
                                      ? Divider()
                                      : SizedBox(),
                                if (c.currentUser != null)
                                  (c.currentUser!.role == 'admin'
                                      ? MenuButton(
                                          height: height * 0.05,
                                          width: width * 0.65,
                                          useGradient: false,
                                          onPressed: () {
                                            Get.toNamed(
                                                AppConstants
                                                    .updateCommunityProfilePage,
                                                arguments: currentUserController
                                                    .currentUser!
                                                    .community!
                                                    .id);
                                          },
                                          icon: Icons.groups_2_outlined,
                                          label: 'Community Profile',
                                          color: Colors.grey.shade300,
                                          textColor: Colors.black,
                                        )
                                      : SizedBox()),
                                if (c.currentUser != null)
                                  (c.currentUser!.role == 'admin'
                                      ? Divider()
                                      : SizedBox()),
                                if (c.currentUser != null)
                                  (c.currentUser!.role == 'admin'
                                      ? MenuButton(
                                          height: height * 0.05,
                                          width: width * 0.65,
                                          useGradient: false,
                                          onPressed: () {
                                            // communityController
                                            //     .getCommunityJoinRequest(
                                            //     c.currentUser!
                                            //             .community!.id);
                                            // Get.to(CommunityJoinRequestsView());
                                            Get.toNamed(
                                                AppConstants
                                                    .communityJoinRequestsPage,
                                                arguments: currentUserController
                                                    .currentUser!
                                                    .community!
                                                    .id);
                                          },
                                          icon: Icons.message_outlined,
                                          label: 'Community Join Requests',
                                          color: Colors.grey.shade300,
                                          textColor: Colors.black,
                                        )
                                      : SizedBox()),
                                if (c.currentUser != null)
                                  (c.currentUser!.role == 'admin'
                                      ? Divider()
                                      : SizedBox()),
                                if (c.currentUser != null)
                                  MenuButton(
                                    height: height * 0.05,
                                    width: width * 0.65,
                                    useGradient: false,
                                    onPressed: () async {
                                      c.logout();
                                    },
                                    icon: Icons.logout,
                                    label: 'Logout',
                                    color: Colors.grey.shade300,
                                    textColor: Colors.black,
                                  ),
                                if (c.currentUser != null) Divider(),
                                MenuButton(
                                  height: height * 0.05,
                                  width: width * 0.65,
                                  useGradient: false,
                                  onPressed: () {
                                    CustomUrlLauncher.launchWebUrl(
                                        "https://imperialit.co.uk/contact-us.html");
                                  },
                                  icon: Icons.support,
                                  label: 'Support',
                                  color: Colors.grey.shade300,
                                  textColor: Colors.black,
                                ),
                                Divider(),
                                MenuButton(
                                  height: height * 0.05,
                                  width: width * 0.65,
                                  useGradient: false,
                                  onPressed: () {
                                    CustomUrlLauncher.launchWebUrl(
                                        "https://imperialit.co.uk/about-us.html");
                                  },
                                  icon: Icons.info_outline_rounded,
                                  label: 'About Us',
                                  color: Colors.grey.shade300,
                                  textColor: Colors.black,
                                ),
                              ]),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                centerTitle: false,
                title: SizedBox(
                    height: height * 0.1,
                    child: ChangeRegionButton(
                      iconSize: 6,
                      width: width,
                    )),
                iconTheme: IconThemeData(color: Colors.black),
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              backgroundColor: Colors.grey.shade100,
              body: SafeArea(
                child: FutureBuilder(
                    future: checkInternetConnection(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? RefreshIndicator(
                              onRefresh: () async {
                                appDataController.onInit();
                                homeController.onInit();

                                log("message");
                              },
                              color: CustomColors.red,
                              child: Container(
                                height: height,
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      se.SearchBar(
                                          controller:
                                              searchController.searchController,
                                          height: height * 0.04,
                                          width: width * 0.6,
                                          onTapSearch: () {
                                            searchController.search();
                                            // Hive.box<Region>('regionBox').clear();
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Upcoming Events',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            // Text(
                                            //   'see all',
                                            //   style: Theme
                                            //       .of(context)
                                            //       .textTheme
                                            //       .bodyLarge!
                                            //       .copyWith(color: Colors.black),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Obx(
                                        () => homeController
                                                .loadingHomeEvents.value
                                            ? LoadingScreen(width * 0.1)
                                            : (homeController.events.isEmpty
                                                ? Text(
                                                    "No events founded",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: CustomColors
                                                                .red),
                                                  )
                                                : EventSlider(
                                                    events:
                                                        homeController.events,
                                                    width: width,
                                                    height: height * 0.2,
                                                  )),
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Services',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            // Text(
                                            //   'see all',
                                            //   style: Theme
                                            //       .of(context)
                                            //       .textTheme
                                            //       .bodyLarge!
                                            //       .copyWith(color: Colors.black),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Obx(
                                        () =>
                                            homeController
                                                    .loadingHomeServices.value
                                                ? LoadingScreen(width * 0.1)
                                                : Column(
                                                    children: [
                                                      SizedBox(
                                                        width: width,
                                                        height: height * 0.04,
                                                        child:
                                                            ListView.separated(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: homeController
                                                                  .serviceCategories
                                                                  .length +
                                                              1,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return index == 0
                                                                ? InkWell(
                                                                    onTap: () =>
                                                                        homeController
                                                                            .onChangeServiceCategory(0),
                                                                    child:
                                                                        ServiceIconWidget(
                                                                      width: 0.25 *
                                                                          width,
                                                                      serviceCategory: ServiceCategoryModel(
                                                                          id: 0,
                                                                          name:
                                                                              "All",
                                                                          icon:
                                                                              "https://i.ibb.co/86BPtML/icons8-all-32.png"),
                                                                      color: homeController.selectedCategoryId == 0
                                                                          ? CustomColors
                                                                              .red
                                                                          : Colors
                                                                              .grey,
                                                                    ),
                                                                  )
                                                                : InkWell(
                                                                    onTap: () => homeController.onChangeServiceCategory(homeController
                                                                        .serviceCategories[
                                                                            index -
                                                                                1]
                                                                        .id),
                                                                    child:
                                                                        ServiceIconWidget(
                                                                      width: 0.25 *
                                                                          width,
                                                                      serviceCategory: homeController
                                                                              .serviceCategories[
                                                                          index -
                                                                              1],
                                                                      color: homeController.selectedCategoryId == homeController.serviceCategories[index - 1].id
                                                                          ? CustomColors
                                                                              .red
                                                                          : Colors
                                                                              .grey,
                                                                    ),
                                                                  );
                                                          },
                                                          separatorBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return SizedBox(
                                                                width: 16.0);
                                                          },
                                                        ),
                                                      ),
                                                      homeController
                                                              .services.isEmpty
                                                          ? Text(
                                                              "No services founded",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: CustomColors
                                                                          .red),
                                                            )
                                                          : GridView.count(
                                                              shrinkWrap: true,
                                                              crossAxisCount: 2,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              childAspectRatio:
                                                                  width /
                                                                      (height *
                                                                          0.8),
                                                              children:
                                                                  List.generate(
                                                                homeController
                                                                    .services
                                                                    .length,
                                                                (index) =>
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: ServiceWidget(
                                                                      width: width *
                                                                          0.4,
                                                                      height: 0.3 *
                                                                          height,
                                                                      service: homeController
                                                                              .services[
                                                                          index],
                                                                      onPressed: () => Get.toNamed(
                                                                          AppConstants
                                                                              .serviceProfilePage,
                                                                          arguments: homeController
                                                                              .services[index]
                                                                              .id)),
                                                                ),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                      ),
                                      SizedBox(
                                        height: 0.03 * height,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Explore Communities',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            // Text(
                                            //   'see all',
                                            //   style: Theme
                                            //       .of(context)
                                            //       .textTheme
                                            //       .bodyLarge!
                                            //       .copyWith(color: Colors.black),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Obx(() => homeController
                                              .loadingHomeCommunities.value
                                          ? LoadingScreen(width * 0.1)
                                          : (homeController.communities.isEmpty
                                              ? Text(
                                                  "No communities founded",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color:
                                                              CustomColors.red),
                                                )
                                              : ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          SizedBox(height: 20),
                                                  itemCount: homeController
                                                      .communities
                                                      .toList()
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return CommunityWidget(
                                                      width: width,
                                                      height: height * 0.3,
                                                      community: homeController
                                                          .communities
                                                          .toList()[index],
                                                    );
                                                  },
                                                ))),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: CustomErrorWidget(
                              onPressed: () {
                                appDataController.onInit();
                                homeController.onInit();
                                //communityController.onInit();
                                // eventsController.onInit();
                                // authController.onInit();
                                Get.offAllNamed("/home");
                              },
                              message: "No internet",
                              color: Colors.black,
                            ));
                    }),
              ),
            )
          : SizedBox();
    });
  }
}
//Todo:Tablet
// Scaffold(
// drawer: Drawer(
// width: width * 0.4,
// child: SafeArea(
// child: SizedBox(
// height: 100.h,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// children: [
// Expanded(
// flex: 1,
// child: UserInfoHeader(
// userName: 'mahmoud ayman',
// email: 'mahmoudayman9112000@gmail.com',
// imageUrl: ' imageUrl',
// height: 10.h,
// width: 36.w,
// ),
// ),
// Expanded(
// flex: 10,
// child: ListView.separated(
// itemCount: 6,
// itemBuilder: (context, index) {
// switch (index) {
// case 0:
// return MenuButton(
// height: 5.h,
// iconSize: 3,
// width: 65.w,
// useGradient: false,
// onPressed: () {},
// icon: Icons.home_outlined,
// label: 'Home',
// );
// case 1:
// return MenuButton(
// height: 5.h,
// iconSize: 3,
// width: 65.w,
// useGradient: false,
// onPressed: () {
// Get.to(LogInView());
// },
// icon: Icons.login,
// label: 'Sign In',
// color: Colors.grey.shade300,
// textColor: Colors.black,
// );
// case 2:
// return MenuButton(
// height: 5.h,
// iconSize: 3,
// width: 65.w,
// useGradient: false,
// onPressed: () {
// Get.to(ChooseAccountView());
// },
// icon: Icons.app_registration,
// label: 'Register',
// color: Colors.grey.shade300,
// textColor: Colors.black,
// );
// case 3:
// return MenuButton(
// height: 5.h,
// iconSize: 3,
// width: 65.w,
// useGradient: false,
// onPressed: () {
// Get.to(UserProfileView());
// },
// icon: Icons.person_outline,
// label: 'Profile',
// color: Colors.grey.shade300,
// textColor: Colors.black,
// );
// case 4:
// return MenuButton(
// height: 5.h,
// iconSize: 3,
// width: 65.w,
// useGradient: false,
// onPressed: () {},
// icon: Icons.info_outline_rounded,
// label: 'About Us',
// color: Colors.grey.shade300,
// textColor: Colors.black,
// );
// case 5:
// return MenuButton(
// height: 5.h,
// iconSize: 3,
// width: 65.w,
// useGradient: false,
// onPressed: () {},
// icon: Icons.support,
// label: 'Support',
// color: Colors.grey.shade300,
// textColor: Colors.black,
// );
// default:
// return SizedBox.shrink();
// }
// },
// separatorBuilder:
// (BuildContext context, int index) {
// return Divider();
// },
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// ),
// extendBodyBehindAppBar: true,
// appBar: AppBar(
// centerTitle: false,
// title: SizedBox(
// height: height * 0.2,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: ChangeRegionButton(
// iconSize: 3,
// ),
// )),
// iconTheme: IconThemeData(color: Colors.black),
// shadowColor: Colors.transparent,
// backgroundColor: Colors.transparent,
// elevation: 0,
// ),
// backgroundColor: Colors.grey.shade100,
// body: SafeArea(
// child: Container(
// height: 100.h,
// padding: const EdgeInsets.all(8.0),
// child: SingleChildScrollView(
// child: Column(
// children: [
// SearchBar(
// height: height * 0.04,
// width: width * 0.6,
// onTapSearch: () {},
// iconSize: 3),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// 'Upcoming Events',
// style: Theme.of(context)
// .textTheme
//     .displayLarge!
// .copyWith(color: Colors.black),
// ),
// Text(
// 'see all',
// style: Theme.of(context)
// .textTheme
//     .bodyLarge!
// .copyWith(color: Colors.black),
// ),
// ],
// ),
// ),
// EventSlider(
// events: [
// // EventWidget(
// //   width: 100.w,
// //   height: 27.h,
// //   whiteLayer: false,
// //   iconSize: 3,
// //   showDetails: true,
// //   image: 'assets/images/evp.png',
// // )
// ],
// width: 100.w,
// height: 20.h,
// ),
// SizedBox(
// height: 3.h,
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// 'Services',
// style: Theme.of(context)
// .textTheme
//     .displayLarge!
// .copyWith(color: Colors.black),
// ),
// Text(
// 'see all',
// style: Theme.of(context)
// .textTheme
//     .bodyLarge!
// .copyWith(color: Colors.black),
// ),
// ],
// ),
// ),
// SizedBox(
// width: 100.w,
// height: 3.h,
// child: ListView.separated(
// scrollDirection: Axis.horizontal,
// itemCount: 4,
// itemBuilder: (BuildContext context, int index) {
// return tabServicesIcons[index];
// },
// separatorBuilder:
// (BuildContext context, int index) {
// return SizedBox(width: 16.0);
// },
// ),
// ),
// SizedBox(
// height: height * 0.22,
// child: ListView(
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// children: List.generate(
// 5,
// (index) => Padding(
// padding: const EdgeInsets.all(8.0),
// child: tabServices[index],
// ),
// ),
// ),
// ),
// SizedBox(
// height: 3.h,
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// 'Explore Communities',
// style: Theme.of(context)
// .textTheme
//     .displayLarge!
// .copyWith(color: Colors.black),
// ),
// Text(
// 'see all',
// style: Theme.of(context)
// .textTheme
//     .bodyLarge!
// .copyWith(color: Colors.black),
// ),
// ],
// ),
// ),
// GridView.count(
// shrinkWrap: true,
// crossAxisCount: 2,
// physics: NeverScrollableScrollPhysics(),
// childAspectRatio: 100.w / (35.h),
// children: List.generate(
// 4,
// (index) => Padding(
// padding: const EdgeInsets.all(8.0),
// child: tabCommunities[index],
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// )
