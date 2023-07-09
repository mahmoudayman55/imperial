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
import 'package:imperial/auth_module/presentation/controller/user_join_requests_controller.dart';
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
import '../../../auth_module/presentation/controller/current_user_controller.dart';
import '../../../community_module/data/remote_data_source/community_remote_data_source.dart';
import '../../../community_module/data/repository/community_repository.dart';
import '../../../community_module/domain/repository/base_community_repository.dart';
import '../../../community_module/domain/usecase/get_communities_use_case.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../domain/usecase/get_community_join_requests.dart';

class CommunityJoinRequestsController extends GetxController {
  late RxList<CommunityJoinRequest> communityJoinRequests;
  late int communityId;

  bool gettingJoinRequests = false;
  acceptJoinRequest(int userId, int requestId,String deviceToken) async {
    final authC = Get.find<CurrentUserController>();
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
        getCommunityJoinRequest();
      });
    });

  }

  declineJoinRequest(int userId, int requestId,String deviceToken) async {
    gettingJoinRequests = true;
    update();
    final authC = Get.find<CurrentUserController>();
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
          getCommunityJoinRequest();
        });
    gettingJoinRequests = false;
    update();
  }
  getCommunityJoinRequest() async {

    gettingJoinRequests = true;
    update();

    BaseCommunityRemoteDataSource communityRemoteDataSource =
        CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
        CommunityRepository(communityRemoteDataSource);

    final result =
        await GetCommunityJoinRequestsUseCase(communityRepository).execute(communityId);
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

  @override
  void onInit() {
    communityJoinRequests = <CommunityJoinRequest>[].obs;
    communityId=Get.arguments;
getCommunityJoinRequest();
    super.onInit();
  }
}
