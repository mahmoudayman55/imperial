import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imperial/app_init_module/presentation/controller/region_controller.dart';
import 'package:imperial/core/utils/app_constants.dart';

import '../../../app_init_module/domain/entities/city.dart';
import '../../../app_init_module/domain/entities/group_age_entity.dart';
import '../../../app_init_module/domain/entities/language_entity.dart';
import '../../../app_init_module/domain/entities/region_entity.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import '../../data/models/user_register_model.dart';
import '../../data/remote_data_source/auth_remote_data_source.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../../domain/usecase/user_register_usecase.dart';
import '../view/login.dart';
import '../view/registration/Individual/Individual_register_2.dart';

class UserRegisterController extends GetxController{
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController userRegisterPhoneController = TextEditingController();
  late Region _selectedRegion;
  late City _selectedCity;
  late SpeakingLanguage _selectedLang;
  late GroupAge _selectedGroupAge;
  bool registeringUser = false;

  final userRegisterPhase2FormKey = GlobalKey<FormState>();

  userRegisterPhase1Submit() async {
    userRegisterPhase1FormKey.currentState!.save();
    if (userRegisterPhase1FormKey.currentState!.validate()) {
      update();
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        customSnackBar(
          title: "error",
          message: "No Internet Connection",
          successful: false,
        );
      } else {

          Get.toNamed(AppConstants.userRegister2Page);
          update();

      }

    }
  }
  onUserRegionChanged(Region region) {
    _selectedRegion = region;
    update();
  }

  final userRegisterPhase1FormKey = GlobalKey<FormState>();


  registerUserPhase2() async {
    if (userRegisterPhase2FormKey.currentState!.validate()) {
      registeringUser = true;
      update();
      BaseAuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
      BaseAuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
      BaseAuthRepository authRepository =
      AuthRepository(authRemoteDataSource, authLocalDataSource);
      final result = await UserRegisterUseCase(authRepository).execute(
          UserRegisterModel(
              name: userNameController.text,
              email: userEmailController.text,
              password: passwordController.text,
              region: _selectedRegion,
              zip: zipController.text,
              phone: userRegisterPhoneController.text,
              groupAge: _selectedGroupAge,
              city: _selectedCity,
              speakingLanguage: _selectedLang,
              coverPicUrl: 'url',
              picUrl: 'https://i.ibb.co/9HVLC1F/20171206-01.jpg',
              deviceToken:
              (await FirebaseMessaging.instance.getToken()).toString()));
      result.fold((l) {
        registeringUser = false;
        update();
        Get.back();

        customSnackBar(
          title: 'Registration field',
          message: l.message.toString(),
          successful: false,
        );
      }, (r) {
        userEmailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        Get.offAllNamed(AppConstants.loginPage);
        customSnackBar(
          title: 'Account created successfully',
          message: "You can Login now",
          successful: true,
        );
      });
      registeringUser = false;
      update();
    }
  }

  onCityChanged(City city) {
    _selectedCity = city;
    log("city is ${city}");
    update();
  }

  onGroupAgeChanged(GroupAge groupAge) {
    _selectedGroupAge = groupAge;
    update();
  }

  onSpeakingLanguageChanged(SpeakingLanguage speakingLanguage) {
    _selectedLang = speakingLanguage;
    update();
  }


  @override
  void onInit() {
final appDataController= Get.find<AppDataController>();
_selectedRegion=appDataController.regions[0];
_selectedCity=appDataController.cities[0];
_selectedGroupAge=appDataController.groupAges[0];
_selectedLang=appDataController.speakingLanguages[0];
    super.onInit();
  }

}