import 'dart:developer' as d;
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:imperial/app_init_module/domain/usecases/get_selected_region_usecase.dart';
import 'package:imperial/auth_module/data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import 'package:imperial/auth_module/data/models/notification_model.dart';
import 'package:imperial/auth_module/data/remote_data_source/auth_remote_data_source.dart';
import 'package:imperial/auth_module/data/repository/auth_repository.dart';
import 'package:imperial/auth_module/domain/usecase/send_noti_use_case.dart';
import 'package:imperial/auth_module/presentation/controller/auth_controller.dart';
import 'package:imperial/auth_module/presentation/controller/notofication_controller.dart';
import 'package:imperial/community_module/data/model/community_card_model.dart';
import 'package:imperial/community_module/data/model/community_model.dart';
import 'package:imperial/community_module/data/model/event_ticket_request.dart';
import 'package:imperial/community_module/data/model/send_request_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/community_module/domain/entity/community_join_request.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:imperial/community_module/domain/entity/role.dart';
import 'package:imperial/community_module/domain/usecase/add_member_use_case.dart';
import 'package:imperial/community_module/domain/usecase/ask_to_join_use_case.dart';
import 'package:imperial/community_module/domain/usecase/get_community_by_id.dart';
import 'package:imperial/community_module/domain/usecase/get_events_use_case.dart';
import 'package:imperial/community_module/domain/usecase/send_ticket_request_use_case.dart';
import 'package:imperial/community_module/domain/usecase/update_request_status_use_case.dart';
import 'package:imperial/view/community_profile_view.dart';

import '../../../app_init_module/data/local_data_source/hive/base_app_iti_local_data_source.dart';
import '../../../app_init_module/data/models/request_communities_model.dart';
import '../../../app_init_module/data/remote_data_source/app_init_remote_data_source.dart';
import '../../../app_init_module/data/repository/app_init_repository.dart';
import '../../../app_init_module/domain/entities/region_entity.dart';
import '../../../app_init_module/domain/repository/base_app_init_repository.dart';
import '../../../auth_module/domain/entities/user_entity.dart';
import '../../../community_module/data/remote_data_source/community_remote_data_source.dart';
import '../../../community_module/data/repository/community_repository.dart';
import '../../../community_module/domain/repository/base_community_repository.dart';
import '../../../community_module/domain/usecase/get_communities_use_case.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../domain/usecase/get_community_join_requests.dart';

class CommunityController extends GetxController {
  late RxList<Community> communities;
  late RxList<CommunityJoinRequest> communityJoinRequests;
  RxBool loadingHomeCommunities = false.obs;
  bool gettingCommunity = false;
  late Community selectedCommunity;

  getCommunity(int id) async {
    getCommunityJoinRequest(id);
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      customSnackBar(
        title: "error",
        message: "No internet connection",
        successful: false,
      );
      return;
    }
    gettingCommunity = true;
    update();
    Get.toNamed('/Community_profile');

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
      selectedCommunity = r;
      d.log("got it");
    });
    gettingCommunity = false;
    d.log("community events:" + selectedCommunity.events.length.toString());
    update();
  }

  acceptJoinRequest(int userId, int requestId,String deviceToken) async {
    final authC = Get.find<AuthController>();
    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);
    gettingJoinRequests = true;
    update();
    final addMemberResult = await AddMemberUseCase(communityRepository).execute(
        Role(
            userId: userId,
            communityId: authC.currentUser!.community!.id,
            status: "member"));

    addMemberResult.fold((l) {
      customSnackBar(
          title: "error", message: l.message.toString(), successful: false);
      gettingJoinRequests = false;
      update();
      return;
    }, (r) async {
      final updateRequestStatusResult =
          await UpdateRequestStatusUseCase(communityRepository).execute(
          CommunityJoinRequest(
              status: 1, id: requestId, user: authC.currentUser!));
      updateRequestStatusResult.fold((l) {
        customSnackBar(
            title: "error", message: l.message.toString(), successful: false);
        gettingJoinRequests = false;
        update();
      }, (r) {
        final notiC =Get.find<NotificationController>();
        notiC.sendNotification(NotificationModel(body: "Your join request has been accepted!", title: "Request accepted", receiverToken:deviceToken ));
        customSnackBar(title: "Done", message: r, successful: true);
        getCommunityJoinRequest(authC.currentUser!.community!.id);
      });
    });

  }

  declineJoinRequest(int userId, int requestId,String deviceToken) async {
    gettingJoinRequests = true;
    update();
    final authC = Get.find<AuthController>();
    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);

    final updateRequestStatusResult =
        await UpdateRequestStatusUseCase(communityRepository).execute(
            CommunityJoinRequest(
                status: 0, id: requestId, user: authC.currentUser!));
    updateRequestStatusResult.fold(
        (l) => customSnackBar(
            title: "error", message: l.message.toString(), successful: false),
        (r) {
          final notiC =Get.find<NotificationController>();
          notiC.sendNotification(NotificationModel(body: "Your join request has been declined!", title: "Request Declined", receiverToken:deviceToken ));
          customSnackBar(title: "Done", message: r, successful: true);
          getCommunityJoinRequest(authC.currentUser!.community!.id);
        });
    gettingJoinRequests = false;
    update();
  }

  bool gettingJoinRequests = false;

  getCommunityJoinRequest(int id) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      customSnackBar(
        title: "error",
        message: "No internet connection",
        successful: false,
      );
      return;
    }
    gettingJoinRequests = true;
    update();

    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);

    final result =
        await GetCommunityJoinRequestsUseCase(communityRepository).execute(id);
    result.fold((l) {
      customSnackBar(
        title: "error",
        message: l.message.toString(),
        successful: false,
      );
    }, (r) {
      communityJoinRequests.assignAll(r);
      communityJoinRequests.refresh();
    });
    gettingJoinRequests = false;
    update();
  }

  getCommunities() async {
    loadingHomeCommunities.value = true;
    loadingHomeCommunities.refresh();
    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);

    BaseAppInitRemoteDataSource appInitRemoteDataSource =
        AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
        AppInitLocalDataSource();
    BaseAppInitRepository appInitRepository =
        AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    final selectedRegionResult =
        await GetSelectedRegionUseCase(appInitRepository).execute();
    late Region region;
    selectedRegionResult.fold((l) => d.log(l.toString()), (r) => region = r);

    LimitParametersModel queryParameters = LimitParametersModel(
        regionId: region.id, limit: 3, offset: communities.length);
    final result = await GetCommunitiesUseCase(communityRepository)
        .execute(queryParameters);
    result.fold((l) {}, (r) => communities.assignAll(r));
    loadingHomeCommunities.value = false;
    loadingHomeCommunities.refresh();
    communities.refresh();
    update();
  }

  bool sendingJoinRequest = false;

  askToJoin() async {
    final authController = Get.find<AuthController>();
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

  @override
  void onInit() {
    communities = <Community>[].obs;
    communityJoinRequests = <CommunityJoinRequest>[].obs;

    getCommunities();
    super.onInit();
  }
}
