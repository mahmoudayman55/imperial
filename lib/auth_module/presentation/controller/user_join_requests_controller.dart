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
import 'package:imperial/auth_module/domain/usecase/send_service_register_request_use_case.dart';
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
import '../view/user_profile_view.dart';
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

class UserJoinRequestsController extends GetxController {
  late RxList<UserJoinRequest> userJoinRequests;
  bool gettingUserRequests = false;
  late int userId;
  getUserJoinRequests() async {


    gettingUserRequests = true;
    update();
    BaseAuthRepository userRepository =
        AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource());
    final results = await GetUserJoinRequestsUseCase(userRepository)
        .execute(userId);
    results.fold((l) => null, (r) => userJoinRequests.assignAll(r));
    gettingUserRequests = false;
    update();
    update();
  }

  // String getIsoCodeFromDialCode(String dialCode) {
  //   try {
  //     final phoneNumber = PhoneNumberUtil().parse(dialCode, null);
  //     return PhoneNumberUtil
  //   } on Exception catch (_) {
  //     return null;
  //   }
  // }
  bool gettingCommunityRegions = false;

  //bool gettingServiceRegions = false;
  @override
  onInit() {
userId=Get.arguments;
getUserJoinRequests();

    userJoinRequests = <UserJoinRequest>[].obs;

    super.onInit();
  }
}
