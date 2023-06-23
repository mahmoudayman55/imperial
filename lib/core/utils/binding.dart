import 'package:get/get.dart';
import 'package:imperial/app_init_module/presentation/controller/on_boarding_controller.dart';
import 'package:imperial/auth_module/presentation/controller/auth_controller.dart';

import '../../app_init_module/presentation/controller/region_controller.dart';
import '../../community_module/presentation/controller/community_controller.dart';
import '../../community_module/presentation/controller/event_controller.dart';
import '../../service_module/presentation/controller/service_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
    Get.lazyPut<RegionController>(() => RegionController(),fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(),fenix: true);
    Get.lazyPut<CommunityController>(() => CommunityController(),fenix: true);
    Get.lazyPut<EventController>(() => EventController(),fenix: true);
    Get.lazyPut<ServiceController>(() => ServiceController(),fenix: true);
   // Get.put<RegionController>(RegionController());
  //  Get.put<AuthController>(AuthController());
  //   Get.put<CommunityController>(CommunityController());
  //   Get.put<EventController>(EventController());
  //   Get.put<ServiceController>(ServiceController());
  }
}