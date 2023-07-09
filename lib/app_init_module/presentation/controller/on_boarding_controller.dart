import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imperial/app_init_module/data/models/app_init_model.dart';
import 'package:imperial/app_init_module/data/models/on_boarding_model.dart';
import 'package:imperial/app_init_module/data/models/region_model.dart';
import 'package:imperial/app_init_module/domain/entities/app_init_entity.dart';
import 'package:imperial/app_init_module/domain/entities/onboarding_entity.dart';
import 'package:imperial/app_init_module/domain/repository/base_app_init_repository.dart';
import 'package:imperial/app_init_module/domain/usecases/get_app_initial_usecase.dart';
import 'package:imperial/app_init_module/domain/usecases/get_app_version_use_case.dart';
import 'package:imperial/app_init_module/domain/usecases/get_on_boards_usecase.dart';
import 'package:imperial/app_init_module/presentation/controller/region_controller.dart';
import 'package:imperial/core/utils/nework_exception.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../view/app_update_view.dart';
import '../../../view/home_view.dart';
import '../../data/local_data_source/hive/base_app_iti_local_data_source.dart';
import '../../data/remote_data_source/app_init_remote_data_source.dart';
import '../../data/repository/app_init_repository.dart';
import '../../domain/entities/region_entity.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController();

  int currentPage = 0;

  List<OnBoarding> onBoards = [];
  List<Region> regions = [];
  bool loading = false;
  bool networkError = false;

  updateCurrentPage(page) {
    currentPage = page;
    pageController.jumpToPage(page);
    update();
  }

  getOnBoardsData() async {
    loading = true;
    update();
    BaseAppInitRemoteDataSource appInitRemoteDataSource =
        AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
        AppInitLocalDataSource();
    BaseAppInitRepository appInitRepository =
        AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    final Either<ErrorMessageModel, List<OnBoarding>> onBoardings =
        await GetOnBoardsUseCase(appInitRepository).execute();
    onBoardings.fold((l) {

      loading = false;
      networkError = true;
      update();
    }, (r) {
      (log((r).toString()));

      onBoards = r;
      loading = false;
      networkError = false;
      update();
    });
  }

  submit()async {
    final _regionsController = Get.find<AppDataController>();
    await    _regionsController.submit();
   await _regionsController.getCurrentRegion();

    update();
  }

  @override
  void onInit() {
    getOnBoardsData();
    super.onInit();
  }
}
