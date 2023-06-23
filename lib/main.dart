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
import 'package:imperial/auth_module/presentation/controller/notofication_controller.dart';
import 'package:imperial/auth_module/presentation/view/registration/Individual/Individual_register_1.dart';
import 'package:imperial/auth_module/presentation/view/registration/Individual/Individual_register_2.dart';
import 'package:imperial/auth_module/presentation/view/registration/choose_account%20type.dart';
import 'package:imperial/community_module/data/remote_data_source/community_remote_data_source.dart';
import 'package:imperial/community_module/data/repository/community_repository.dart';
import 'package:imperial/community_module/domain/usecase/get_communities_use_case.dart';
import 'package:imperial/core/utils/app_constants.dart';
import 'package:imperial/core/utils/theme.dart';
import 'package:imperial/auth_module/presentation/view/login.dart';
import 'package:imperial/search_module/presentation/controller/search_controller.dart';
import 'package:imperial/service_module/presentation/controller/service_controller.dart';
import 'package:imperial/view/community_events_view.dart';
import 'package:imperial/view/community_profile_view.dart';
import 'package:imperial/view/home_view.dart';
import 'package:imperial/view/new_event_view.dart';
import 'package:imperial/view/person_profile.dart';
import 'package:imperial/view/service_profile_view.dart';
import 'package:imperial/view/test.dart';
import 'package:imperial/app_init_module/presentation/components/region_selector.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'app_init_module/data/local_data_source/hive/base_app_iti_local_data_source.dart';
import 'app_init_module/data/models/region_model.dart';
import 'app_init_module/data/remote_data_source/app_init_remote_data_source.dart';
import 'app_init_module/data/repository/app_init_repository.dart';
import 'app_init_module/domain/repository/base_app_init_repository.dart';
import 'app_init_module/presentation/controller/region_controller.dart';
import 'app_init_module/presentation/view/onboarding/onboarding_view.dart';
import 'auth_module/data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import 'auth_module/data/models/user_model.dart';
import 'auth_module/domain/usecase/user_register_usecase.dart';
import 'auth_module/presentation/controller/auth_controller.dart';
import 'auth_module/presentation/controller/reset_password_controller.dart';
import 'community_module/domain/repository/base_community_repository.dart';
import 'community_module/presentation/controller/community_controller.dart';
import 'community_module/presentation/controller/event_controller.dart';
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
              name: '/person',
              page: () => PersonProfileView(),
            ),
            GetPage(
              name: '/new_event',
              page: () => NewEventView(),
            ),
            GetPage(
              name: '/Community_profile',
              page: () => CommunityProfileView(),
            ),
            GetPage(
              name: '/onboarding',
              page: () => OnBoardingView(),
              binding: BindingsBuilder(() {
              Get.put(AppUpdateController());
            }),
            ),
            GetPage(
              name: '/accountType',
              page: () => ChooseAccountView(),
            ),
            GetPage(
              name: '/user_register2',
              page: () => IndividualRegistration2View(),
            ),
            GetPage(
              name: '/user_register1',
              page: () => IndividualRegister1View(),
            ),
            GetPage(
              name: '/login',
              page: () => LogInView(),   binding: BindingsBuilder(() {
              Get.lazyPut(()=>ResetPasswordController(),fenix: true);
              Get.put(AuthController(), permanent: true);
            }),
            ),
            GetPage(
              name: '/home',
              binding: BindingsBuilder(() {
                Get.put(NotificationController(), permanent: true);
                Get.put(AuthController(), permanent: true);
                Get.put(RegionController(), permanent: true);
                Get.put(CommunityController(), permanent: true);
                Get.put(ServiceController(), permanent: true);
                Get.put(EventController(), permanent: true);
                Get.put(HomeSearchController(), permanent: true);
                Get.put(AppUpdateController(),permanent: true);
                Get.find<AppUpdateController>();

              }),
              page: () => HomeView(),
            ),
            GetPage(
              name: '/serviceProfile',
              page: () => ServiceProfileView(),
            ),
            GetPage(
              name: '/community_events',
              page: () => CommunityEventsView(),
            ),
          ],
        );
      },
    );
  }
}
