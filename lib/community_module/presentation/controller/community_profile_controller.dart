import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:imperial/auth_module/presentation/controller/current_user_controller.dart';

import '../../../core/utils/app_constants.dart';
import '../../data/model/send_request_model.dart';
import '../../data/remote_data_source/community_remote_data_source.dart';
import '../../data/repository/community_repository.dart';
import '../../domain/entity/community.dart';
import '../../domain/repository/base_community_repository.dart';
import '../../domain/usecase/ask_to_join_use_case.dart';
import '../../../view/community_profile_view.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../../auth_module/data/models/notification_model.dart';
import '../../../auth_module/presentation/controller/user_join_requests_controller.dart';
import '../../../auth_module/presentation/controller/notofication_controller.dart';
import '../../domain/usecase/get_community_by_id.dart';

class CommunityProfileController extends GetxController{
  late Community selectedCommunity;
  bool sendingJoinRequest = false;
  RxBool gettingCommunity = false.obs;

  askToJoin() async {
    final authController = Get.find<CurrentUserController>();
    if (authController.currentUser == null) {
      customSnackBar(
          title: "",
          message: "You have to login before ask to join to this community",
          successful: false);
      return;
    }
    sendingJoinRequest = true;
    update();
    BaseCommunityRemoteDataSource communityRemoteDataSource =
    CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
    CommunityRepository(communityRemoteDataSource);
    final result = await AskToJoinUseCase(communityRepository).execute(
        RequestModel(
            userId: authController.currentUser!.id,
            communityId: selectedCommunity.id,
            status: 2));

    result.fold((l) {
      customSnackBar(
          title: "", message: l.message.toString(), successful: false);
    }, (r) async {

      customSnackBar(title: "", message: r, successful: true);
      final notiController = Get.find<NotificationController>();
      await  notiController.sendNotification(NotificationModel(
          body:
          "${authController.currentUser!.name} requested to join your community",
          title: "New join request",
          receiverToken: selectedCommunity.admins[0].deviceToken));

      authController.updateUserToken();
      Get.off(CommunityProfileView());
    });
    sendingJoinRequest = false;
    update();
  }
  getCommunity(int id) async {
    gettingCommunity.value = true;
    update();
    BaseCommunityRemoteDataSource communityRemoteDataSource =
    CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
    CommunityRepository(communityRemoteDataSource);

    final result =
    await GetCommunityByIdUseCase(communityRepository).execute(id);
    result.fold((l) {
      customSnackBar(
        title: "error",
        message: l.message.toString(),
        successful: false,
      );
    }, (r) {
      selectedCommunity=r;
      update();
    });
    gettingCommunity.value = false;
    update();
  }

  @override
  Future<void> onInit() async {



    await  getCommunity(Get.arguments);
    super.onInit();

  }
}