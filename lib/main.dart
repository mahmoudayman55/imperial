import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hive/hive.dart';
import 'package:imperial/app_init_module/data/models/request_communities_model.dart';
import 'package:imperial/app_init_module/domain/entities/region_entity.dart';
import 'package:imperial/app_init_module/domain/usecases/get_selected_region_usecase.dart';
import 'package:imperial/app_init_module/presentation/controller/app_update_controller.dart';
import 'package:imperial/auth_module/data/remote_data_source/auth_remote_data_source.dart';
import 'package:imperial/auth_module/data/repository/auth_repository.dart';
import 'package:imperial/auth_module/domain/entities/user_entity.dart';
import 'package:imperial/auth_module/domain/repository/base_auth_repository.dart';
import 'package:imperial/auth_module/domain/usecase/get_current_user_use_case.dart';
import 'package:imperial/auth_module/presentation/controller/choose_account_controller.dart';
import 'package:imperial/auth_module/presentation/controller/community_register_controller.dart';
import 'package:imperial/auth_module/presentation/controller/current_user_controller.dart';
import 'package:imperial/auth_module/presentation/controller/login_controller.dart';
import 'package:imperial/auth_module/presentation/controller/notofication_controller.dart';
import 'package:imperial/auth_module/presentation/controller/service_register_controller.dart';
import 'package:imperial/auth_module/presentation/controller/user_register_controller.dart';
import 'package:imperial/auth_module/presentation/view/registration/Individual/Individual_register_1.dart';
import 'package:imperial/auth_module/presentation/view/registration/Individual/Individual_register_2.dart';
import 'package:imperial/auth_module/presentation/view/registration/business%20_registration_view.dart';
import 'package:imperial/auth_module/presentation/view/registration/choose_account%20type.dart';
import 'package:imperial/auth_module/presentation/view/registration/community_registration.dart';
import 'package:imperial/community_module/data/remote_data_source/community_remote_data_source.dart';
import 'package:imperial/community_module/data/repository/community_repository.dart';
import 'package:imperial/community_module/domain/usecase/get_communities_use_case.dart';
import 'package:imperial/community_module/presentation/controller/community_events_controller.dart';
import 'package:imperial/community_module/presentation/controller/community_profile_controller.dart';
import 'package:imperial/community_module/presentation/controller/event_tickets_controller.dart';
import 'package:imperial/community_module/presentation/controller/new_event_controller.dart';
import 'package:imperial/community_module/presentation/controller/update_community_profile_controller.dart';
import 'package:imperial/community_module/presentation/controller/user_ticket_requests_controller.dart';
import 'package:imperial/community_module/presentation/view/event_tickets_view.dart';
import 'package:imperial/core/utils/app_constants.dart';
import 'package:imperial/core/utils/theme.dart';
import 'package:imperial/auth_module/presentation/view/login.dart';
import 'package:imperial/search_module/presentation/controller/search_controller.dart';
import 'package:imperial/service_module/presentation/controller/service_profile_controller.dart';
import 'package:imperial/user_module/presentation/controller/persone_profile_controller.dart';
import 'package:imperial/view/community_events_view.dart';
import 'package:imperial/view/community_join_requests_view.dart';
import 'package:imperial/view/community_profile_update_view.dart';
import 'package:imperial/view/community_profile_view.dart';
import 'package:imperial/community_module/presentation/view/event_profile_view.dart';
import 'package:imperial/view/home_view.dart';
import 'package:imperial/community_module/presentation/view/new_event_view.dart';
import 'package:imperial/view/new_ticket_view.dart';
import 'package:imperial/view/person_profile.dart';
import 'package:imperial/view/service_profile_view.dart';
import 'package:imperial/view/test.dart';
import 'package:imperial/app_init_module/presentation/components/region_selector.dart';
import 'package:imperial/auth_module/presentation/view/user_profile_view.dart';
import 'package:imperial/view/user_join_requests_view.dart';
import 'package:imperial/view/user_ticket_requests_view.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'app_init_module/data/local_data_source/hive/base_app_iti_local_data_source.dart';
import 'app_init_module/data/models/region_model.dart';
import 'app_init_module/data/remote_data_source/app_init_remote_data_source.dart';
import 'app_init_module/data/repository/app_init_repository.dart';
import 'app_init_module/domain/repository/base_app_init_repository.dart';
import 'app_init_module/presentation/controller/on_boarding_controller.dart';
import 'app_init_module/presentation/controller/region_controller.dart';
import 'app_init_module/presentation/view/onboarding/onboarding_view.dart';
import 'auth_module/data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import 'auth_module/data/models/user_model.dart';
import 'auth_module/domain/usecase/user_register_usecase.dart';
import 'auth_module/presentation/controller/user_join_requests_controller.dart';
import 'auth_module/presentation/controller/home_controller.dart';
import 'auth_module/presentation/controller/reset_password_controller.dart';
import 'auth_module/presentation/view/forgot_password_view.dart';
import 'community_module/domain/repository/base_community_repository.dart';
import 'community_module/presentation/controller/community_controller.dart';
import 'community_module/presentation/controller/event_controller.dart';
import 'community_module/presentation/controller/event_profile_controller.dart';
import 'core/utils/binding.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
//
//   String appName = packageInfo.appName;
//   String packageName = packageInfo.packageName;
  String version = packageInfo.version;
//   String buildNumber = packageInfo.buildNumber;
 log("version is: $version");
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    log('User granted provisional permission');
  } else {
    log('User declined or has not accepted permission');
  }

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.registerAdapter(RegionAdapter());
  await Hive.openBox<Region>('regionBox', path: appDocumentDir.path);
  await Hive.openBox<String>(AppConstants.userTokenBoxName,
      path: appDocumentDir.path);
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 300));

  runApp(DevicePreview(
    builder: (context) => MyApp(),
    enabled: !kReleaseMode,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          locale: DevicePreview.locale(context),
          fallbackLocale: const Locale('en'),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: true,
          useInheritedMediaQuery: true,
          initialBinding: AppBinding(),
          initialRoute:
              Hive.box<Region>('regionBox').isEmpty ? '/onboarding' : '/home',
          theme: Themes.lightTheme,
          getPages: [
            GetPage(
              name: AppConstants.homePage,
              binding: BindingsBuilder(() {
                Get.put(AppDataController(),permanent: true);
                Get.put(CurrentUserController(),permanent: true);
                Get.put(NotificationController(), permanent: true);
                Get.put(HomeController());
                Get.put(HomeSearchController(), permanent: true);

              }),
              page: () => HomeView(),
            ),
            GetPage(
              name: AppConstants.eventTicketsPage,
              binding: BindingsBuilder(() {
                Get.put(EventTicketsController());


              }),
              page: () => EventsTicketsView(),
            ),
            GetPage(
              name: AppConstants.communityRegisterPage,
              page: () => CommunityRegistrationView(),
              binding: BindingsBuilder(() {
              Get.lazyPut(()=>AppDataController());
              Get.put(CommunityRegisterController());
            }),
            ),
            GetPage(
              name: AppConstants.serviceRegisterPage,
              page: () => BusinessRegistrationView(),
              binding: BindingsBuilder(() {
              Get.lazyPut(()=>AppDataController());
              Get.put(ServiceRegisterController());
            }),
            ),       GetPage(
              name: AppConstants.updateCommunityProfilePage,
              page: () => CommunityUpdateProfileView(),
              binding: BindingsBuilder(() {
              Get.put(UpdateCommunityProfileController());
            }),
            ),

            GetPage(
              name: AppConstants.personProfilePage,
              page: () => PersonProfileView(),
              binding: BindingsBuilder(() {
              Get.put(PersonProfileController());
            }),
            ),  GetPage(
              name:AppConstants.communityJoinRequestsPage,
              page: () => CommunityJoinRequestsView(),
              binding: BindingsBuilder(() {
              Get.put(CommunityJoinRequestsController());
            }),
            ),
            GetPage(
              name:  AppConstants.newEventPage,
              page: () => NewEventView(),
              binding: BindingsBuilder(() {
                Get.put(NewEventController());
              }),
            ),
            GetPage(
              name: AppConstants.communityProfilePage,
              page: () => CommunityProfileView(),
              binding: BindingsBuilder(() {
              Get.put(CommunityProfileController());
            }),
            ),
            GetPage(
              name: '/onboarding',
              page: () => OnBoardingView(),
              binding: BindingsBuilder(() {
              Get.put(OnBoardingController());
              Get.lazyPut(()=>AppDataController());
            }),
            ),
            GetPage(
              name: AppConstants.accountTypePage,
              page: () => ChooseAccountView(),
              binding: BindingsBuilder(() {
                Get.put(ChooseAccountTypeController());
              }),
            ),
            GetPage(
              name: AppConstants.userRegister2Page,
              page: () => UserRegisterPhaseTwoView(), binding: BindingsBuilder(() {
              Get.find<UserRegisterController>();

            }),

            ),    GetPage(
              name: AppConstants.eventProfilePage,
              page: () => EventProfileView(),
              binding: BindingsBuilder(() {
              Get.put(EventProfileController());

            }),

            ),
            GetPage(
              name: AppConstants.userRegister1Page,
              page: () => UserRegisterPhaseOneView(),
              binding: BindingsBuilder(() {
              Get.put(UserRegisterController());
            }),
            ),
            GetPage(
              name: AppConstants.loginPage,
              page: () => LogInView(),   binding: BindingsBuilder(() {
              Get.put(LoginController());
            }),
            ),    GetPage(
              name: AppConstants.forgotPasswordPage,
              page: () => ForgotPasswordView(),
              binding: BindingsBuilder(() {

              Get.put(ResetPasswordController());
            }),
            ),

            GetPage(
              name:AppConstants.serviceProfilePage,
              page: () => ServiceProfileView(),    binding: BindingsBuilder(() {
              Get.put(ServiceProfileController());


            }),
            ),
            GetPage(
              name:AppConstants.userProfilePage,
              page: () => UserProfileView(),    binding: BindingsBuilder(() {
              Get.find<CurrentUserController>();


            }),
            ),
            GetPage(
              name:AppConstants.userTicketsPage,
              page: () => UserTicketRequestsView(),
              binding: BindingsBuilder(() {
              Get.put(UserTicketRequestsController());


            }),
            ),
            GetPage(
              name:AppConstants.userJoinRequestPage,
              page: () => UserJoinRequestsView(),
              binding: BindingsBuilder(() {
              Get.put(UserJoinRequestsController());


            }),
            ),
            GetPage(
              name: AppConstants.communityEventsPage,
              page: () => CommunityEventsView(),
              binding: BindingsBuilder(() {

                
              Get.put(CommunityEventsController());


            }),
            ),
            GetPage(
              name: AppConstants.newTicketPage,
              page: () => NewTicketView(),
              binding: BindingsBuilder(() {


              Get.put(NewTicketController());


            }),
            ),
          ],
        );
      },
    );
  }

}
