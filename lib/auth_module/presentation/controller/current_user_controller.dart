import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app_init_module/domain/entities/city.dart';
import '../../../app_init_module/domain/entities/group_age_entity.dart';
import '../../../app_init_module/domain/entities/region_entity.dart';
import '../../../app_init_module/presentation/controller/region_controller.dart';
import '../../../core/utils/app_constants.dart';
import '../../../user_module/data/data_source/user_remote_data_source.dart';
import '../../../user_module/data/repository/user_repository.dart';
import '../../../user_module/domain/repository/baseUserRepository.dart';
import '../../../user_module/domain/use_case/upadte_cover_use_case.dart';
import '../../../user_module/domain/use_case/update_user_pic_use_case.dart';
import '../../../user_module/domain/use_case/update_user_use_case.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import '../../data/models/user_model.dart';
import '../../data/remote_data_source/auth_remote_data_source.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../../domain/usecase/change_current_password_use_case.dart';
import '../../domain/usecase/get_current_user_use_case.dart';
import '../../domain/usecase/remove_device_token_use_case.dart';
import '../../domain/usecase/save_user_token_use_case.dart';
import '../../domain/usecase/update_user_token_use_case.dart';
import '../../domain/usecase/user_logout_use_case.dart';

class CurrentUserController extends GetxController{
  @override
  Future<void> onInit() async {
await getCurrentUser();
    super.onInit();
  }
  User? currentUser;
  getCurrentUser() async {
    BaseAuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
    BaseAuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
    BaseAuthRepository authRepository =
    AuthRepository(authRemoteDataSource, authLocalDataSource);
    final result = await GetCurrentUserUseCase(authRepository).execute();
    result.fold((l) {
      currentUser = null;
      update();
    }, (r) {
      currentUser = r;
      update();
    });

    return currentUser;
  }
  logout() async {
    BaseAuthRepository userRepository =
    AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource());
    log("id is" + currentUser!.id.toString());
    final result =
    await RemoveDeviceTokenUseCase(userRepository).execute(currentUser!.id);
    result.fold((l) => log("message is:" + l.message.toString()), (r) async {
      await UserLogoutUseCase(userRepository).execute();
      await getCurrentUser();

      //Get.back();
      Get.offAllNamed('/home');
      update();

    });
  }


  TextEditingController profilePasswordController = TextEditingController();
  TextEditingController profileConfirmPasswordController =
  TextEditingController();
  TextEditingController profileUserEmailController = TextEditingController();
  TextEditingController profileUserNameController = TextEditingController();
  TextEditingController profilePhoneController = TextEditingController();
  TextEditingController profileZipController = TextEditingController();

  updateUserToken() async {
    log("token up to date");
    BaseAuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();

    BaseAuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
    BaseAuthRepository authRepository =
    AuthRepository(authRemoteDataSource, authLocalDataSource);
    final result =
    await UpdateUserTokenUseCase(authRepository).execute(currentUser!.id);
    result.fold((l) => log(l.message.toString()), (r) async {
      await SaveUserTokenUseCase(authRepository).execute(r);
      log("token saved done");
    });
  }

  late Region profileSelectedRegion;
  late GroupAge profileSelectedGroupAge;
  late City profileSelectedCity;
  bool updatingUserInfo = false;
  updatePic() async {
    updatingUserInfo = true;
    update();
    XFile? newPic = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (newPic != null) {
      final result =
      await UpdateUserPicUseCase(UserRepository(UserRemoteDataSource()))
          .execute(currentUser!.id, newPic);
      result.fold(
              (l) => customSnackBar(
              title: "",
              message: l.message.toString(),
              successful: false), (r) async {
        customSnackBar(title: "", message: r.toString(), successful: true);
        await updateUserToken();
        getCurrentUser();
      });
    }
    updatingUserInfo = false;
    update();
  }
  ///Todo: fix goto profile
  goToProfile() async {
    // var connectivityResult = await Connectivity().checkConnectivity();
    // if (connectivityResult == ConnectivityResult.none) {
    //   customSnackBar(
    //     title: "error",
    //     message: "No internet connection",
    //     successful: false,
    //   );
    //   return;
    // }
    // /// loadingAppInit = true;
    // update();
    final currentUserController= Get.find<CurrentUserController>();
    await currentUserController.initUserProfile();
    Get.toNamed(AppConstants.userProfilePage);


    // await getCurrentUser();
    // //await getInitialData();
    //
    // await initUserProfile();
    // // loadingAppInit = false;
    // update();
  }
  updateCoverPic() async {
    updatingUserInfo = true;
    update();
    XFile? newPic = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (newPic != null) {
      final result =
      await UpdateUserCoverUseCase(UserRepository(UserRemoteDataSource()))
          .execute(currentUser!.id, newPic as XFile);
      result.fold(
              (l) => customSnackBar(
              title: "",
              message: l.message.toString(),
              successful: false), (r) async {
        customSnackBar(title: "", message: r.toString(), successful: true);
        await updateUserToken();
        getCurrentUser();
      });
    }
    updatingUserInfo = false;
    update();
  }
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  ///todo: user selected region to update
  updateUser() async {
    if (profileFormKey.currentState!.validate()) {
      updatingUserInfo = true;
      update();
      BaseUserRemoteDataSource userRemoteDataSource = UserRemoteDataSource();
      BaseUserRepository userRepository = UserRepository(userRemoteDataSource);

      final result = await UpdateUserUseCase(userRepository).execute(UserModel(
          name: profileUserNameController.text,
          email: profileUserEmailController.text,
          region: Region(id: -1, name: "region"),
          zip: profileZipController.text,
          phone: profilePhoneController.text,
          groupAge: profileSelectedGroupAge,
          city: profileSelectedCity,
          speakingLanguage: currentUser!.speakingLanguage,
          id: currentUser!.id,
          coverPicUrl: currentUser!.coverPicUrl,
          picUrl: currentUser!.picUrl,
          deviceToken:
          (await FirebaseMessaging.instance.getToken()).toString()));
      result.fold(
              (l) => customSnackBar(
              title: "",
              message: l.message.toString(),
              successful: false), (r) async {
        await updateUserToken();
        await getCurrentUser();
        await initUserProfile();

        customSnackBar(title: "Done!", message: r, successful: true);
      });
      updatingUserInfo = false;
      update();
    }
  }
  onProfileRegionChanged(Region region) {
    profileSelectedRegion = region;
    update();
  }

  onProfileCityChanged(City city) {
    profileSelectedCity = city;
    update();
  }
  initUserProfile() async {
    profileUserEmailController.text = currentUser!.email;
    profileUserNameController.text = currentUser!.name;
    profileZipController.text = currentUser!.zip;
    profilePhoneController.text = currentUser!.phone;

    ///todo:fix
    final appDataController=Get.find<AppDataController>();
    log("length of regions: ${appDataController.regions.length}");
    profileSelectedRegion = appDataController.  regions.firstWhere((element) => element.id == currentUser!.region!.id);
    profileSelectedGroupAge = appDataController.groupAges
        .firstWhere((element) => element.id == currentUser!.groupAge!.id);
    log("profile selected group age is: $profileSelectedGroupAge");
    profileSelectedCity =
        appDataController. cities.firstWhere((element) => element.id == currentUser!.city!.id);
    update();
  }
  onProfileGroupAgeChanged(GroupAge groupAge) {
    profileSelectedGroupAge = groupAge;
    update();
  }
}