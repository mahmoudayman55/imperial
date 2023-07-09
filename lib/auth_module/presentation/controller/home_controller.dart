import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:imperial/core/utils/app_constants.dart';

import '../../../app_init_module/data/local_data_source/hive/base_app_iti_local_data_source.dart';
import '../../../app_init_module/data/models/request_communities_model.dart';
import '../../../app_init_module/data/remote_data_source/app_init_remote_data_source.dart';
import '../../../app_init_module/data/repository/app_init_repository.dart';
import '../../../app_init_module/domain/entities/region_entity.dart';
import '../../../app_init_module/domain/repository/base_app_init_repository.dart';
import '../../../app_init_module/domain/usecases/get_selected_region_usecase.dart';
import '../../../community_module/data/remote_data_source/community_remote_data_source.dart';
import '../../../community_module/data/repository/community_repository.dart';
import '../../../community_module/domain/entity/community.dart';
import '../../../community_module/domain/repository/base_community_repository.dart';
import '../../../community_module/domain/usecase/get_communities_use_case.dart';
import '../../../community_module/domain/usecase/get_community_by_id.dart';
import '../../../community_module/domain/usecase/get_event_by_id.dart';
import '../../../community_module/domain/usecase/get_events_use_case.dart';
import '../../../service_module/data/data_source/remote_data_source/service_remote_data_source.dart';
import '../../../service_module/data/repository/service_repository.dart';
import '../../../service_module/domain/entity/service.dart';
import '../../../service_module/domain/entity/service_category.dart';
import '../../../service_module/domain/repository/base_service_repository.dart';
import '../../../service_module/domain/usecase/get_service_by_id.dart';
import '../../../service_module/domain/usecase/get_services_categories_use_case.dart';
import '../../../service_module/domain/usecase/get_services_use_case.dart';
import '../../../widgets/custom_snack_bar.dart';
import 'package:imperial/community_module/domain/entity/event.dart';

class HomeController extends GetxController{
  @override
  Future<void> onInit() async {
    communities = <Community>[].obs;
    _events = <Event>[].obs;
    services = <CService>[].obs;
    serviceCategories = <ServiceCategory>[].obs;
   await getServiceCategory();
    await  getServices();
    await getEvents();
    await  getCommunities();
    super.onInit();
  }
  late int selectedCategoryId;
  onChangeServiceCategory(int id )async{
    selectedCategoryId=id;
    await getServices();
    update();

  }


  late RxList<ServiceCategory> serviceCategories;
  getServiceCategory() async {

    loadingHomeServices.value = true;
    loadingHomeServices.refresh();
    BaseServiceRemoteDataSource serviceRemoteDataSource =
    ServiceRemoteDataSource();
    BaseServiceRepository baseServiceRepository =
    ServiceRepository(serviceRemoteDataSource);
    final result =
    await GetServicesCategoriesUseCase(baseServiceRepository).execute();
    result.fold((l) => null, (r) {
      serviceCategories.addAll(r);
      selectedCategoryId=0;
    });
    loadingHomeServices.value = false;
    loadingHomeServices.refresh();
    serviceCategories.refresh();
  }
  //community section
  RxBool loadingHomeCommunities = false.obs;
  late RxList<Community> communities;

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
    selectedRegionResult.fold((l) =>log(l.toString()), (r) => region = r);

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


  set setEvents(RxList<Event> value) {
    _events = value;
  }

  RxBool loadingHomeServices = false.obs;

  getServices() async {
    loadingHomeServices.value = true;
    loadingHomeServices.refresh();
    BaseServiceRemoteDataSource serviceRemoteDataSource =
    ServiceRemoteDataSource();
    BaseServiceRepository baseServiceRepository =
    ServiceRepository(serviceRemoteDataSource);

    BaseAppInitRemoteDataSource appInitRemoteDataSource =
    AppInitRemoteDataSource();
    BaseAppInitLocalDataSource appInitLocalDataSource =
    AppInitLocalDataSource();
    BaseAppInitRepository appInitRepository =
    AppInitRepository(appInitRemoteDataSource, appInitLocalDataSource);
    final selectedRegionResult =
    await GetSelectedRegionUseCase(appInitRepository).execute();
    late Region region;
    selectedRegionResult.fold((l) => log(l.toString()), (r) => region = r);
    final result = await GetServicesUseCase(baseServiceRepository).execute(
        LimitParametersModel(regionId: region.id, limit: 5, offset: 0,categoryId: selectedCategoryId));
    result.fold((l) => null, (r) => services.assignAll(r));
    log(services.toList().toString());
    loadingHomeServices.value = false;
    loadingHomeServices.refresh();
    services.refresh();
  }

  late RxList<CService> services;

  late RxList<Event> _events;

  RxBool loadingHomeEvents = false.obs;

  getEvents() async {
    loadingHomeEvents.value = true;
    loadingHomeEvents.refresh();
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
    selectedRegionResult.fold((l) => log(l.toString()), (r) => region = r);

    LimitParametersModel queryParameters = LimitParametersModel(
        regionId: region.id, limit: 3, offset: _events.length);
    final result =
    await GetEventsUseCase(communityRepository).execute(queryParameters);
    result.fold((l) => null, (r) => _events.assignAll(r));
    loadingHomeEvents.value = false;
    loadingHomeEvents.refresh();
    // This line will update any UI that is observing the communities field.
    _events.refresh();
  }
  List<Event> get events => _events.toList();




}