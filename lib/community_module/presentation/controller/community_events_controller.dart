import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:imperial/core/utils/app_constants.dart';

import '../../../auth_module/presentation/controller/home_controller.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../data/remote_data_source/community_remote_data_source.dart';
import '../../data/repository/community_repository.dart';
import '../../domain/repository/base_community_repository.dart';
import '../../domain/usecase/get_event_of_community_use_case.dart';
import '../../domain/usecase/remove_event_use_case.dart';
import 'package:get/get.dart';
class CommunityEventsController extends GetxController{
  late RxList<Event> _communityEvents;
  bool removingEvent = false;

  RxList<Event> get communityEvents => _communityEvents;

  set communityEvents(RxList<Event> value) {
    _communityEvents = value;
  }
  removeEvent(int id) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      customSnackBar(
        title: "error",
        message: "No internet connection",
        successful: false,
      );
      return;
    }
    removingEvent = true;
    update();
    BaseCommunityRemoteDataSource communityRemoteDataSource =
    CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
    CommunityRepository(communityRemoteDataSource);
    final result = await RemoveEventUseCase(communityRepository).execute(id);
    result.fold(
            (l) => customSnackBar(
            title: "", message: l.message.toString(), successful: false),
            (r) {
              communityEvents.removeWhere((element) => element.id == id);
              customSnackBar(title: "", message: r, successful: true);
              final homeC=Get.find<HomeController>();
              homeC.getEvents();
              homeC.getCommunities();

            });
    removingEvent = false;
    update();
  }
  bool gettingCommunityEvents = false;
late int communityId;
  getCommunityEvents() async {
    gettingCommunityEvents = true;
    update();

    BaseCommunityRemoteDataSource communityRemoteDataSource =
    CommunityRemoteDataSource();
    BaseCommunityRepository communityRepository =
    CommunityRepository(communityRemoteDataSource);

    final result =
    await GetCommunityEventUseCase(communityRepository).execute(communityId);
    result.fold((l) => null, (r) => _communityEvents.assignAll(r));
    _communityEvents.refresh();
    gettingCommunityEvents = false;
    update();
  }

@override
  void onInit() {
  _communityEvents = <Event>[].obs;
communityId=Get.arguments;
getCommunityEvents();
  super.onInit();
  }
}