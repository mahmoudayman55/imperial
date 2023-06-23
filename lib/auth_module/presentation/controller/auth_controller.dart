import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imperial/app_init_module/domain/entities/city.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/app_init_module/domain/usecases/get_cities_usecase.dart';
import 'package:imperial/app_init_module/domain/usecases/get_group_ages_usecase.dart';
import 'package:imperial/app_init_module/domain/usecases/get_speaking_languages_usecase.dart';
import 'package:imperial/app_init_module/presentation/controller/region_controller.dart';
import 'package:imperial/auth_module/data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import 'package:imperial/auth_module/data/models/register_request_model.dart';
import 'package:imperial/auth_module/data/models/user_login_model.dart';
import 'package:imperial/auth_module/data/models/user_register_model.dart';
import 'package:imperial/auth_module/data/models/user_ticket_model.dart';
import 'package:imperial/auth_module/domain/entities/register_request.dart';
import 'package:imperial/auth_module/domain/usecase/get_current_user_use_case.dart';
import 'package:imperial/auth_module/domain/usecase/get_user_by_id_use_case.dart';
import 'package:imperial/auth_module/domain/usecase/get_user_join_requests_use_case.dart';
import 'package:imperial/auth_module/domain/usecase/remove_device_token_use_case.dart';
import 'package:imperial/auth_module/domain/usecase/save_user_token_use_case.dart';
import 'package:imperial/auth_module/domain/usecase/send_register_request_use_case.dart';
import 'package:imperial/auth_module/domain/usecase/update_user_token_use_case.dart';
import 'package:imperial/auth_module/domain/usecase/user_login_cuse_case.dart';
import 'package:imperial/auth_module/presentation/view/login.dart';
import 'package:imperial/auth_module/presentation/view/registration/Individual/Individual_register_2.dart';
import 'package:imperial/community_module/data/model/community_model.dart';
import 'package:imperial/community_module/data/remote_data_source/community_remote_data_source.dart';
import 'package:imperial/community_module/data/repository/community_repository.dart';
import 'package:imperial/community_module/domain/usecase/get_community_by_id.dart';
import 'package:imperial/core/utils/app_constants.dart';
import 'package:imperial/user_module/data/data_source/user_remote_data_source.dart';
import 'package:imperial/user_module/data/repository/user_repository.dart';
import 'package:imperial/user_module/domain/repository/baseUserRepository.dart';
import 'package:imperial/user_module/domain/use_case/upadte_cover_use_case.dart';
import 'package:imperial/user_module/domain/use_case/update_community_cover_use_case.dart';
import 'package:imperial/user_module/domain/use_case/update_community_use_case.dart';
import 'package:imperial/user_module/domain/use_case/update_user_pic_use_case.dart';
import 'package:imperial/user_module/domain/use_case/update_user_use_case.dart';
import 'package:imperial/view/home_view.dart';
import 'package:imperial/view/user_ticket_requests_view.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';

import '../../../app_init_module/data/local_data_source/hive/base_app_iti_local_data_source.dart';
import '../../../app_init_module/data/remote_data_source/app_init_remote_data_source.dart';
import '../../../app_init_module/data/repository/app_init_repository.dart';
import '../../../app_init_module/domain/entities/group_age_entity.dart';
import '../../../app_init_module/domain/entities/region_entity.dart';
import '../../../app_init_module/domain/repository/base_app_init_repository.dart';
import '../../../app_init_module/domain/usecases/get_regions_usecase.dart';
import '../../../app_init_module/domain/usecases/get_selected_region_usecase.dart';
import '../../../community_module/data/model/update_community_model.dart';
import '../../../core/utils/nework_exception.dart';
import '../../../view/community_profile_update_view.dart';
import '../../../view/user_join_requests_view.dart';
import '../../../view/user_profile_view.dart';
import '../../data/models/user_join_request_model.dart';
import '../../data/models/user_model.dart';
import '../../data/remote_data_source/auth_remote_data_source.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/base_auth_repository.dart';
import '../../domain/usecase/change_current_password_use_case.dart';
import '../../domain/usecase/get_user_ticket_requests_use_case.dart';
import '../../domain/usecase/user_logout_use_case.dart';
import '../../domain/usecase/user_register_usecase.dart';
import '../view/registration/Individual/Individual_register_1.dart';
import '../view/registration/business _registration_view.dart';
import '../view/registration/community_registration.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:libphonenumber/libphonenumber.dart';

class AuthController extends GetxController {
  final userRegisterPhase1FormKey = GlobalKey<FormState>();
  final userRegisterPhase2FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerCommunityFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerServiceFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  int selectedType = -1;
  final GlobalKey<FormState> changePasswordFrom = GlobalKey<FormState>();
  TextEditingController currentPasswordController      = TextEditingController();
  TextEditingController newPasswordController           = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  changePassword() async {
    if (changePasswordFrom.currentState!.validate()) {
      final result = await ChangeCurrentPasswordUseCase(
          AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource()))
          .execute(email: currentUser!.email,
          newPassword: newPasswordController.text,
          currentPassword: currentPasswordController.text);

      result.fold((l) => customSnackBar(title: "error", message: l.message.toString(), successful: false), (r) {
       Get.back();
       currentPasswordController.text="";
       newPasswordController.text="";
       confirmNewPasswordController.text="";
       customSnackBar(title: "Done", message: r, successful: true);
      });
    }
  }
  logout() async {
    BaseAuthRepository userRepository =
        AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource());
    log("id is"+currentUser!.id.toString());
  final  result= await RemoveDeviceTokenUseCase(userRepository).execute(currentUser!.id);
result.fold((l) => log("message is:"+l.message.toString()), (r) async {
  await UserLogoutUseCase(userRepository).execute();
  await getCurrentUser();

  //Get.back();
  Get.offAllNamed('/home');
  update();
});

  }

  late User selectedUser;
  bool gettingPerson = false;

  openPersonScreen(int id) async {
    log("message");
    gettingPerson = true;
    update();
    Get.toNamed("/person");
    final result = await GetUserByIdUseCase(
            AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource()))
        .execute(id);
    result.fold(
        (l) => customSnackBar(
            title: "", message: l.message.toString(), successful: false),
        (r) => selectedUser = r);
    gettingPerson = false;
    update();
    update();
  }

  late RxList<UserJoinRequest> userJoinRequests;
  bool gettingUserRequests = false;

  geUserJoinRequests() async {
    Get.to(UserJoinRequestsView());
    gettingUserRequests = true;
    update();
    BaseAuthRepository userRepository =
        AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource());
    final results = await GetUserJoinRequestsUseCase(userRepository)
        .execute(currentUser!.id);
    results.fold((l) => null, (r) => userJoinRequests.assignAll(r));
    gettingUserRequests = false;
    update();
    update();
  }

  final List<String> types = [
    'Individual',
    'Community',
    'Business',
  ];
  late Region _selectedRegion;
  late City _selectedCity;
  late SpeakingLanguage _selectedLang;
  late GroupAge _selectedGroupAge;

  late Region profileSelectedRegion;
  late GroupAge profileSelectedGroupAge;
  late City profileSelectedCity;

  onProfileRegionChanged(Region region) {
    profileSelectedRegion = region;
    update();
  }

  onProfileCityChanged(City city) {
    profileSelectedCity = city;
    update();
  }

  onProfileGroupAgeChanged(GroupAge groupAge) {
    profileSelectedGroupAge = groupAge;
    update();
  }

  updatePic() async {
    updatingUserInfo = true;
    update();
    XFile? newPic = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50);
    if (newPic != null) {
      final result =
          await UpdateUserPicUseCase(UserRepository(UserRemoteDataSource()))
              .execute(currentUser!.id, newPic );
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

  updateCoverPic() async {
    updatingUserInfo = true;
    update();
    XFile? newPic = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50);
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
  updateCommunityCover() async {
    updatingCommunity = true;
    update();
    XFile? newPic = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50);
    if (newPic != null) {
      final result =
          await UpdateCommunityCoverUseCase(UserRepository(UserRemoteDataSource()))
          .execute(currentCommunity.id, newPic );
      result.fold(
              (l) => customSnackBar(
              title: "",
              message: l.message.toString(),
              successful: false), (r) async {
        customSnackBar(title: "", message: r.toString(), successful: true);
        await updateUserToken();
        getCurrentUser();
        initCommunityProfile();
      });
    }
    updatingCommunity = false;
    update();
  }
  updateUser() async {
  if( profileFormKey.currentState!.validate())  {
      updatingUserInfo = true;
      update();
      BaseUserRemoteDataSource userRemoteDataSource = UserRemoteDataSource();
      BaseUserRepository userRepository = UserRepository(userRemoteDataSource);

      final result = await UpdateUserUseCase(userRepository).execute(UserModel(
          name: profileUserNameController.text,
          email: profileUserEmailController.text,
          region: _selectedRegion,
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

  TextEditingController passwordController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userLoginEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController userRegisterPhoneController = TextEditingController();

  TextEditingController communityOwnerNameController = TextEditingController();
  TextEditingController communityAddressController = TextEditingController();
  TextEditingController serviceAddressController = TextEditingController();
  TextEditingController communityNameController = TextEditingController();
  TextEditingController communityEmailController = TextEditingController();
  TextEditingController communityPhoneController = TextEditingController();
  TextEditingController communityAboutController = TextEditingController();
  TextEditingController communityWebsiteController = TextEditingController();
  TextEditingController serviceWebsiteController = TextEditingController();
  TextEditingController serviceOwnerNameController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceEmailController = TextEditingController();
  TextEditingController servicePhoneController = TextEditingController();
  TextEditingController serviceAboutController = TextEditingController();
  late Region _communitySelectedRegion;
  late Region _serviceSelectedRegion;

  PhoneNumber number = PhoneNumber(isoCode: "GB");

  RxList<UserTicketModel> get userTicketRequests => _userTicketRequests; //
  // String getIsoCodeFromDialCode(String dialCode) {
  //   try {
  //     final phoneNumber = PhoneNumberUtil().parse(dialCode, null);
  //     return PhoneNumberUtil
  //   } on Exception catch (_) {
  //     return null;
  //   }
  // }
  late RxList<UserTicketModel> _userTicketRequests;
  RxBool gettingUserTicketRequests = false.obs;

  getUserTicketRequests() async {
    Get.to(UserTicketRequestsView());
    gettingUserTicketRequests.value = true;
    gettingUserTicketRequests.refresh();
    final result = await GetUserTicketRequestsUseCase(
            AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource()))
        .execute(currentUser!.id);
    result.fold((l) => null, (r) => _userTicketRequests.assignAll(r));
    _userTicketRequests.refresh();
    gettingUserTicketRequests.value = false;
    gettingUserTicketRequests.refresh();
  }

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
        if (regions.isEmpty ||
            groupAges.isEmpty ||
            speakingLanguages.isEmpty ||
            cities.isEmpty) {
          Get.to(IndividualRegistration2View());
          loadingAppInit = true;
          update();
          await getInitialData();
        } else {
          Get.to(IndividualRegistration2View());
        }
      }

      loadingAppInit = false;
      update();
    }
  }

  bool gettingCommunityRegions = false;
  bool registeringCommunity = false;

  bool gettingServiceRegions = false;
  bool registeringService = false;

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
      final result = await RegisterRequestUseCase(authRepository).execute(
          RegistrationRequestModel(
              ownerName: communityOwnerNameController.text,
              name: communityNameController.text,
              website: communityWebsiteController.text,
              regionId: _communitySelectedRegion.id,
              about: communityAboutController.text,
              email: communityEmailController.text,
              phone: communityPhoneController.text,
              cover:
                  'https://sanamurad.com/wp-content/themes/miyazaki/assets/images/default-fallback-image.png',
              address: communityAddressController.text));
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

  sendServiceRegistrationRequest() async {
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
      final result = await RegisterRequestUseCase(authRepository).execute(
          RegistrationRequestModel(
              ownerName: serviceOwnerNameController.text,
              name: serviceNameController.text,
              regionId: _serviceSelectedRegion.id,
              about: serviceAboutController.text,
              email: serviceEmailController.text,
              phone: servicePhoneController.text,
              cover:
                  'https://sanamurad.com/wp-content/themes/miyazaki/assets/images/default-fallback-image.png',
              address: serviceAddressController.text, website:serviceWebsiteController.text));
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

  goToProfile() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      customSnackBar(
        title: "error",
        message: "No internet connection",
        successful: false,
      );
      return;
    }
    loadingAppInit = true;
    update();
    Get.to(UserProfileView());

    await getCurrentUser();
    await getInitialData();

    await initUserProfile();
    loadingAppInit = false;
    update();
  }

  ///community update
  final updateCommunityFormKey=GlobalKey<FormState>();
  TextEditingController communityUpdateNameController = TextEditingController();
  TextEditingController communityUpdateAddressController =
      TextEditingController();
  TextEditingController communityUpdateAboutController =
      TextEditingController();
  TextEditingController communityUpdateWebUrlController =
      TextEditingController();



  TextEditingController profilePasswordController = TextEditingController();
  TextEditingController profileConfirmPasswordController =
      TextEditingController();
  TextEditingController profileUserEmailController = TextEditingController();
  TextEditingController profileUserNameController = TextEditingController();
  TextEditingController profilePhoneController = TextEditingController();
  TextEditingController profileZipController = TextEditingController();
  late PhoneNumber profileNumber;

  onAccountTypeChange(int index) {
    selectedType = index;
    update();
  }

  submitAccountType() async {
    if (selectedType == 0) {
      Get.to(IndividualRegister1View());
    } else if (selectedType == 1) {
      Get.to(CommunityRegistrationView());

      gettingCommunityRegions = true;
      update();
      await getRegions();
      gettingCommunityRegions = false;
      update();
      // customSnackBar(
      //   title: "",
      //   message: "working on this feature",
      //   successful: false,
      // );
    } else if (selectedType == 2) {
      // customSnackBar(
      //   title: "",
      //   message: "working on this feature",
      //   successful: false,
      // );
      Get.to(BusinessRegistrationView());

      gettingServiceRegions = true;
      update();
      await getRegions();
      gettingServiceRegions = false;
      update();
    } else if (selectedType == -1) {
      customSnackBar(
        title: "",
        message: "You did not select any type",
        successful: false,
      );
    }
  }

  late List<Region> regions;
  late List<SpeakingLanguage> speakingLanguages;
  late List<City> cities;
  late List<GroupAge> groupAges;

  onUserRegionChanged(Region region) {
    _selectedRegion = region;
    update();
  }

  onCommunityRegionChanged(Region region) {
    _communitySelectedRegion = region;
    update();
  }

  onServiceRegionChanged(Region region) {
    _serviceSelectedRegion = region;
    update();
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

  bool registeringUser = false;

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
          title: 'Register field',
          message: l.message.toString(),
          successful: false,
        );
      }, (r) {
        userEmailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        Get.offAll(LogInView());
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

  User? currentUser;

  RxBool loggingIn = false.obs;

  userLogin() async {
    if (loginFormKey.currentState!.validate()) {
      loggingIn.value = true;
      update();

      BaseAuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();

      BaseAuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
      BaseAuthRepository authRepository =
          AuthRepository(authRemoteDataSource, authLocalDataSource);
      final result = await UserLoginUseCase(authRepository).execute(
          UserLoginModel(
              email: userLoginEmailController.text,
              password: loginPasswordController.text,
              deviceToken:
                  (await FirebaseMessaging.instance.getToken()).toString()));
      result.fold(
          (l) => customSnackBar(
                title: "Login failed",
                message: l.message.toString(),
                successful: false,
              ), (r) async {
        SaveUserTokenUseCase(authRepository).execute(r);
        final user = await GetCurrentUserUseCase(authRepository).execute();
        user.fold((l) => log(l.toString()), (r) {
          log((r as UserModel).toJson().toString());
          getCurrentUser();
          userLoginEmailController.clear();
          loginPasswordController.clear();
          Get.offAllNamed('/home');
        });
      });
      loggingIn.value = false;
      update();
    }
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
      _selectedLang = speakingLanguages[0];
    });
  }

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
      _selectedCity = r[0];
    });
  }

  bool updatingCommunity = false;

  updateCommunity() async {
    if (updateCommunityFormKey.currentState!.validate()) {
      updatingCommunity = true;
      update();
      final result =
          await UpdateCommunityUseCase(UserRepository(UserRemoteDataSource()))
              .execute(UpdateCommunityModel(
        id: currentUser!.community!.id,
        name: communityUpdateNameController.text,
        websiteUrl: communityUpdateWebUrlController.text,
        about: communityUpdateAboutController.text,
        address: communityUpdateAddressController.text,
      ));
      result.fold(
          (l) => customSnackBar(
              title: "",
              message: l.message.toString(),
              successful: false), (r) async {
        customSnackBar(title: "", message: r, successful: true);
        await updateUserToken();
        getCurrentUser();
      });
      updatingCommunity = false;
      update();
    }
  }

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

  late CommunityModel currentCommunity;

  initCommunityProfile() async {
    updatingCommunity = true;
    update();
    Get.to(CommunityUpdateProfileView());

    final result = await GetCommunityByIdUseCase(
            CommunityRepository(CommunityRemoteDataSource()))
        .execute(currentUser!.community!.id);
    result.fold((l) => null, (r) {
      currentCommunity = r as CommunityModel;
      communityUpdateNameController.text = currentCommunity.name;
      communityUpdateAddressController.text = currentCommunity.address;
      communityUpdateAboutController.text = currentCommunity.about;
      communityUpdateWebUrlController.text = currentCommunity.websiteUrl;
    });
    updatingCommunity = false;
    update();
  }

  initUserProfile() async {
    profileUserEmailController.text = currentUser!.email;
    profileUserNameController.text = currentUser!.name;
    profileZipController.text = currentUser!.zip;
    profilePhoneController.text = currentUser!.phone;
    profileNumber = PhoneNumber(phoneNumber:currentUser!.phone ,dialCode: "+44", isoCode: "GB");

     profileSelectedRegion = regions
         .firstWhere((element) =>
     element.id == currentUser!.region!.id);
     profileSelectedGroupAge = groupAges
         .firstWhere((element) =>
     element.id == currentUser!.groupAge!.id);
     profileSelectedCity = cities
         .firstWhere((element) =>
     element.id == currentUser!.city!.id);
    update();

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
      _selectedGroupAge = groupAges[0];
    });
  }

  getRegions() async {
    BaseAppInitRemoteDataSource appInitRemoteDataSource =
        AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
        AppInitLocalDataSource();
    BaseAppInitRepository appInitRepository =
        AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    final _regions = await GetRegionsUseCase(appInitRepository).execute();

    _regions.fold((l) {
      customSnackBar(
        title: "error",
        message: l.message.toString(),
        successful: false,
      );
    }, (r) {
      regions = r;
      _selectedRegion = regions[0];
      _communitySelectedRegion = _selectedRegion;
      _serviceSelectedRegion = _selectedRegion;
      update();
    });
  }

  bool loadingAppInit = false;

  getInitialData() async {
    await getSpeakingLanguages();

    await getCities();

    await getGroupAges();

    await getRegions();
  }

  bool updatingUserInfo = false;

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

  @override
  onInit() {
    regions = <Region>[].obs;
    groupAges = <GroupAge>[].obs;
    cities = <City>[].obs;

    _userTicketRequests = <UserTicketModel>[].obs;
    speakingLanguages = <SpeakingLanguage>[].obs;
    userJoinRequests = <UserJoinRequest>[].obs;

    getCurrentUser();
    super.onInit();
  }
}
