import 'dart:developer';
import 'dart:math' as math;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imperial/app_init_module/domain/entities/region_entity.dart';
import 'package:imperial/app_init_module/domain/usecases/get_regions_usecase.dart';
import 'package:imperial/app_init_module/domain/usecases/get_selected_region_usecase.dart';
import 'package:imperial/app_init_module/domain/usecases/save_selected_region.dart';
import 'package:imperial/auth_module/presentation/controller/home_controller.dart';
import 'package:imperial/community_module/presentation/controller/community_controller.dart';
import 'package:imperial/community_module/presentation/controller/event_controller.dart';
import 'package:imperial/core/utils/app_constants.dart';
import 'package:imperial/service_module/presentation/controller/service_profile_controller.dart';
import 'package:imperial/view/home_view.dart';
import 'package:imperial/community_module/domain/entity/event.dart';

import '../../../widgets/custom_snack_bar.dart';
import '../../data/local_data_source/hive/base_app_iti_local_data_source.dart';
import '../../data/remote_data_source/app_init_remote_data_source.dart';
import '../../data/repository/app_init_repository.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/group_age_entity.dart';
import '../../domain/entities/language_entity.dart';
import '../../domain/repository/base_app_init_repository.dart';
import '../../domain/usecases/get_cities_usecase.dart';
import '../../domain/usecases/get_group_ages_usecase.dart';
import '../../domain/usecases/get_speaking_languages_usecase.dart';
import '../../domain/usecases/save_other_region_usecase.dart';

class AppDataController extends GetxController {
  int selectedRegionIndex = -1;
  bool loading = false;
  bool error = false;
  late String otherRegion;
  late Region selectedRegion;
  Region? currentRegion;
  TextEditingController otherRegionController = TextEditingController();

  getCurrentRegion() async {
    BaseAppInitRemoteDataSource appInitRemoteDataSource =
        AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
        AppInitLocalDataSource();
    final BaseAppInitRepository baseAppInitRepository =
        AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    final result =
        await GetSelectedRegionUseCase(baseAppInitRepository).execute();
    result.fold((l) => log("error: $l"), (r) {
      log("r= $r");
      currentRegion = r;

      log("current= $currentRegion");

      update();
    });
  }

  getGroupAges() async {
    BaseAppInitRemoteDataSource appInitRemoteDataSource =
    AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
    AppInitLocalDataSource();
    BaseAppInitRepository appInitRepository =
    AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    final onBoardings = await GetGroupAgesUseCase(appInitRepository).execute();
    onBoardings.fold((l) {
      customSnackBar(
        title: "error",
        message: l.message.toString(),
        successful: false,
      );
    }, (r) {
      (log((r).toString()));

      groupAges = r;
    });
  }



  bool loadingAppInit = false;

  getInitialData() async {
    await getRegions();
    await getCurrentRegion();
  await getSpeakingLanguages();
    await getCities();
    await getGroupAges();


  }
  final otherRegionFormKey = GlobalKey<FormState>();

  updateCurrentRegion(Region region) async {

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      customSnackBar(
        title: "error", message: "No internet connection", successful: false, );
      return;
    }
    log("updateCurrentRegion");
    BaseAppInitRemoteDataSource appInitRemoteDataSource =
        AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
        AppInitLocalDataSource();
    final BaseAppInitRepository baseAppInitRepository =
        AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    await SaveSelectedRegionUseCase(baseAppInitRepository).execute(region);
    currentRegion = region;

    //
    final homeController = Get.find<HomeController>();
    //
    homeController.communities = RxList();
    await homeController.getCommunities();
    homeController.communities.refresh();

    //
    homeController.setEvents = RxList();
    await homeController.getEvents();

    //
    homeController.services = RxList();
    await homeController.getServices();
    homeController.services.refresh();
    update();
  //  Get.offAllNamed("/home");
    // homeController.setEvents=RxList();
  }

  submit() async {
    loading = true;
    update();
//log('selected region : ' + (otherRegionFormKey.currentState!.validate()).toString());
    BaseAppInitRemoteDataSource appInitRemoteDataSource =
        AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
        AppInitLocalDataSource();
    final BaseAppInitRepository baseAppInitRepository =
        AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);

    if (selectedRegionIndex == regions.length) {
      log("RegionController: other region selected");
      if (otherRegionFormKey.currentState!.validate()) {
        otherRegion = otherRegionController.text;
        log("valid: $otherRegion");

        final saveSelectedRegionResult =
            await SaveSelectedRegionUseCase(baseAppInitRepository)
                .execute(regions[0]);

        saveSelectedRegionResult.fold((l) {
          
          loading = false;
          update();
        }, (r) async {
          final saveOtherRegionResult =
              await SaveOtherRegionUseCase(baseAppInitRepository)
                  .execute(otherRegion);
          saveOtherRegionResult.fold(
              (l) => customSnackBar(
                  title: "error",
                  message: l.message.toString(),
                  successful: false),
              (r) => log("saveOtherRegionResult: success"));
          Get.offAllNamed(AppConstants.homePage);

        });
      }
    } else if (selectedRegionIndex == -1) {
      customSnackBar(
          title: "Alert",
          message: "You didn't select any region",
          successful: false);
    } else {
      final saveSelectedRegionResult =
          await SaveSelectedRegionUseCase(baseAppInitRepository)
              .execute(selectedRegion);

      saveSelectedRegionResult.fold((l) {
        

        loading = false;
        update();
      }, (r) {
        log("saveSelectedRegionResult: success");
        Get.offAllNamed(AppConstants.homePage);

      });
    }

    loading = false;
    update();
  }

  updateSelectedRegion(int index) {
    selectedRegionIndex = index;
    if (selectedRegionIndex != regions.length) {
      selectedRegion = regions[selectedRegionIndex];
    } else {
      selectedRegion = regions[math.Random().nextInt((regions.length))];
      log(math.Random().nextInt((regions.length)).toString());
    }
    update();
  }
  getSpeakingLanguages() async {
    BaseAppInitRemoteDataSource appInitRemoteDataSource =
    AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
    AppInitLocalDataSource();
    BaseAppInitRepository appInitRepository =
    AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    final onBoardings =
    await GetSpeakingLanguagesUseCase(appInitRepository).execute();
    onBoardings.fold((l) {
      customSnackBar(
        title: "error",
        message: l.message.toString(),
        successful: false,
      );
    }, (r) {
      speakingLanguages = r;
    });
  }
  late List<SpeakingLanguage> speakingLanguages;
  late List<City> cities;
  late List<GroupAge> groupAges;
  getCities() async {
    BaseAppInitRemoteDataSource appInitRemoteDataSource =
    AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
    AppInitLocalDataSource();
    BaseAppInitRepository appInitRepository =
    AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    final onBoardings = await GetCitiesUseCase(appInitRepository).execute();
    onBoardings.fold((l) {
      customSnackBar(
        title: "error",
        message: l.message.toString(),
        successful: false,
      );
    }, (r) {
      cities = r;
    });
  }
  final RxList<Region> regions = <Region>[].obs;

  @override
  void onInit() {
    groupAges = <GroupAge>[].obs;
    cities = <City>[].obs;
    speakingLanguages = <SpeakingLanguage>[].obs;
getInitialData();

    super.onInit();
  }

  getRegions() async {
    error=false;
    loading = true;
    update();
    BaseAppInitRemoteDataSource appInitRemoteDataSource =
        AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
        AppInitLocalDataSource();
    BaseAppInitRepository appInitRepository =
        AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    try {
      final _regions = await GetRegionsUseCase(appInitRepository).execute();

      _regions.fold((l) {

        error=true;
        loading = false;

         update();
      }, (r) {
        (log((r).toString()));

        regions.assignAll(r);
        regions.refresh();
        log("length from app data ${regions.length.toString()}");
        loading = false;
        error = false;
        update();
      });
    } on Exception catch (e) {
      loading = false;
      error = true;
      update();
    }
  }
}
