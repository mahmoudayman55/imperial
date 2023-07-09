import 'dart:developer';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../view/app_update_view.dart';
import '../../data/local_data_source/hive/base_app_iti_local_data_source.dart';
import '../../data/remote_data_source/app_init_remote_data_source.dart';
import '../../data/repository/app_init_repository.dart';
import '../../domain/usecases/get_app_version_use_case.dart';

class AppUpdateController extends GetxController{
  @override
  void onInit() {
/*
    checkCurrentVersion();
*/
    super.onInit();
  }



/*  checkCurrentVersion() async {
    log("inittt2");

    final result =await GetAppVersionUseCase(AppInitRepository(AppInitRemoteDataSource(),AppInitLocalDataSource())).execute();
    result.fold((l) => log(l.message.toString()), (r) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      log("new vers: $r");
      if(packageInfo.version==r){
        Get.offAll(AppUpdateView());
      }
    });
  }*/

}