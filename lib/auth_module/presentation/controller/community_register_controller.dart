import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imperial/auth_module/domain/usecase/send_community_register_request.dart';

import '../../../app_init_module/domain/entities/region_entity.dart';
import '../../../app_init_module/presentation/controller/region_controller.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import '../../data/models/register_request_model.dart';
import '../../data/remote_data_source/auth_remote_data_source.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../../domain/usecase/send_service_register_request_use_case.dart';

class CommunityRegisterController extends GetxController{

  @override
  void onInit() {
    final regionController=Get.find<AppDataController>();
    selectedRegion=regionController.regions[0];
    super.onInit();
  }

  final GlobalKey<FormState> registerCommunityFormKey = GlobalKey<FormState>();
  bool registeringCommunity = false;

  TextEditingController ownerNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  late Region selectedRegion;
  onCommunityRegionChanged(Region region) {
    selectedRegion = region;
    update();
  }
  sendCommunityRegistrationRequest() async {
    if (registerCommunityFormKey.currentState!.validate()) {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        customSnackBar(
          title: "error",
          message: "No internet connection",
          successful: false,
        );
        return;
      }
      registeringCommunity = true;
      update();
      BaseAuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
      BaseAuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
      BaseAuthRepository authRepository =
      AuthRepository(authRemoteDataSource, authLocalDataSource);
      final result = await CommunityRegisterRequestUseCase(authRepository).execute(
          RegistrationRequestModel(
              ownerName: ownerNameController.text,
              name: nameController.text,
              website: websiteController.text,
              regionId: selectedRegion.id,
              about: aboutController.text,
              email: emailController.text,
              phone: phoneController.text,
              cover:
              'https://sanamurad.com/wp-content/themes/miyazaki/assets/images/default-fallback-image.png',
              address: addressController.text));
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
      registeringCommunity = false;
      update();
    }
  }
}