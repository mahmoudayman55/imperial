import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imperial/app_init_module/presentation/controller/region_controller.dart';

import '../../../app_init_module/domain/entities/region_entity.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import '../../data/models/register_request_model.dart';
import '../../data/remote_data_source/auth_remote_data_source.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../../domain/usecase/send_service_register_request_use_case.dart';

class ServiceRegisterController extends GetxController{
  @override
  void onInit() {
    final regionController= Get.find<AppDataController>();
    _selectedRegion=regionController.regions[0];
    super.onInit();
  }
  final GlobalKey<FormState> registerServiceFormKey = GlobalKey<FormState>();

  TextEditingController websiteController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController ownerNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  late Region _selectedRegion;
  onRegionChanged(Region region) {
    _selectedRegion = region;
    update();
  }


  bool registeringService = false;



  sendServiceRegistrationRequest() async {
    log(_selectedRegion.name.toString());
    if (registerServiceFormKey.currentState!.validate()) {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        customSnackBar(
          title: "error",
          message: "No internet connection",
          successful: false,
        );
        return;
      }
      registeringService = true;
      update();
      BaseAuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
      BaseAuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
      BaseAuthRepository authRepository =
      AuthRepository(authRemoteDataSource, authLocalDataSource);
      final result = await ServiceRegisterRequestUseCase(authRepository).execute(
          RegistrationRequestModel(
              ownerName: ownerNameController.text,
              name: nameController.text,
              regionId: _selectedRegion.id,
              about: aboutController.text,
              email: emailController.text,
              phone: phoneController.text,
              cover:
              'https://sanamurad.com/wp-content/themes/miyazaki/assets/images/default-fallback-image.png',
              address: addressController.text,
              website: websiteController.text));
      result.fold(
              (l) => customSnackBar(
            title: "error",
            message: l.message.toString(),
            successful: false,
          ), (r) {
        Get.offAllNamed("/home");
        customSnackBar(
          title: "",
          message: r.toString(),
          successful: true,
        );
      });
      registeringService = false;
      update();
    }
  }
}