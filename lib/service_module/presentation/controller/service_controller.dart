import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:imperial/app_init_module/presentation/controller/region_controller.dart';
import 'package:imperial/auth_module/presentation/controller/auth_controller.dart';
import 'package:imperial/service_module/data/model/service_rate_model.dart';
import 'package:imperial/service_module/domain/usecase/rate_service_use_case.dart';
import 'package:imperial/widgets/custom_button.dart';
import 'package:imperial/widgets/custom_snack_bar.dart';
import 'package:imperial/widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperial/service_module/data/data_source/remote_data_source/service_remote_data_source.dart';
import 'package:imperial/service_module/domain/entity/service.dart';
import 'package:imperial/service_module/domain/entity/service_category.dart';
import 'package:imperial/service_module/domain/repository/base_service_repository.dart';
import 'package:imperial/service_module/domain/usecase/get_service_by_id.dart';
import 'package:imperial/service_module/domain/usecase/get_services_categories_use_case.dart';
import 'package:imperial/view/service_profile_view.dart';
import 'package:imperial/widgets/custom_cached_network_image.dart';
import '../../../app_init_module/data/local_data_source/hive/base_app_iti_local_data_source.dart';
import '../../../app_init_module/data/models/request_communities_model.dart';
import '../../../app_init_module/data/remote_data_source/app_init_remote_data_source.dart';
import '../../../app_init_module/data/repository/app_init_repository.dart';
import '../../../app_init_module/domain/entities/region_entity.dart';
import '../../../app_init_module/domain/repository/base_app_init_repository.dart';
import '../../../app_init_module/domain/usecases/get_selected_region_usecase.dart';
import '../../data/repository/service_repository.dart';
import '../../domain/usecase/get_services_use_case.dart';

class ServiceController extends GetxController {
  bool isExpandedEmail = false;
  bool isExpandedPhone = false;

  onExpand(int panelIndex, bool isExpanded) {
    isExpandedPhone = !isExpanded;
    update();
  }

  double _rate = 1;
  TextEditingController commentTextController = TextEditingController();
  bool ratingService = false;

  _rateService() async {
    ratingService = true;
    update();
    final authController = Get.find<AuthController>();
    authController.getCurrentUser();
    if(authController.currentUser==null){
      customSnackBar(
        title: "",
        message: "You have to login to rate this service",
        successful: false,
      );
      ratingService=false;
      update();
      return;
    }
    int id = authController.currentUser!.id;
    BaseServiceRemoteDataSource serviceRemoteDataSource =
        ServiceRemoteDataSource();
    BaseServiceRepository baseServiceRepository =
        ServiceRepository(serviceRemoteDataSource);
    ServiceRateModel serviceRateModel = ServiceRateModel(
        serviceId: selectedService.id,
        comment: commentTextController.text,
        userId: id,
        rate: _rate,
        userPic: authController.currentUser!.picUrl,
        userName: authController.currentUser!.name);
    await RateServiceUseCase(baseServiceRepository).execute(serviceRateModel);
    selectedService.rates.add(serviceRateModel);
    ratingService = false;

    update();
    Get.back();
  }

  showReviewDialog(BuildContext context, double width, double height) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(0.03 * width),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                width: width,
                height: height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Rate us",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextFormField(
                            controller: commentTextController,
                            maxLines: 8,
                            context: context,
                            label: "comment",
                            color: Colors.grey.shade400,
                          ),
                          RatingBar.builder(
                            initialRating: _rate,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            glow: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              _rate = rating;
                              update();
                            },
                          )
                        ],
                      ),
                    ),
                    GetBuilder<ServiceController>(builder: (controller) {
                      return Expanded(
                        flex: 1,
                        child: CustomButton(
                          height: 05000,
                          enabled: !ratingService,
                          width: 5000,
                          onPressed: () => _rateService(),
                          label: ratingService ? "Loading..." : "submit",
                          useGradient: false,
                        ),
                      );
                    })
                  ],
                ),
              ),
            ));
  }

  late RxList<ServiceCategory> serviceCategories;
  late RxList<CService> services;
  late CService selectedService ;
  RxBool loadingHomeServices = false.obs;

  onTapImage(String url, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog.fullscreen(
            backgroundColor: Colors.transparent,
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCachedNetworkImage(
                    imageUrl: url,
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.contain),
              ),
            ),
          );
        });
  }
onChangeServiceCategory(int id )async{
selectedCategoryId=id;
await getServices();
update();

}
  bool gettingService = false;

  onSelectService(int id) async {

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        customSnackBar(
          title: "error", message: "No internet connection", successful: false, );
        return;
      }



    log("selected service");
    Get.to(ServiceProfileView());

    gettingService = true;
    update();
    log("getting" + gettingService.toString());

    BaseServiceRemoteDataSource serviceRemoteDataSource =
        ServiceRemoteDataSource();
    BaseServiceRepository baseServiceRepository =
        ServiceRepository(serviceRemoteDataSource);
    final result =
        await GetServiceByIdUseCase(baseServiceRepository).execute(id);
    result.fold(
        (l) => null,
        (r) {

          selectedService = r;
          update();
        });
    gettingService = false;
    log("getting" + gettingService.toString());
    update();
  }
late int selectedCategoryId;
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

  @override
  Future<void> onInit() async {
    serviceCategories = <ServiceCategory>[].obs;
    services = <CService>[].obs;

    await getServiceCategory();
    await getServices();
    super.onInit();
  }
}
