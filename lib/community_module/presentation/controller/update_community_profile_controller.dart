import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imperial/auth_module/presentation/controller/current_user_controller.dart';

import '../../../user_module/data/data_source/user_remote_data_source.dart';
import '../../../user_module/data/repository/user_repository.dart';
import '../../../user_module/domain/use_case/update_community_cover_use_case.dart';
import '../../../user_module/domain/use_case/update_community_use_case.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../data/model/community_model.dart';
import '../../data/model/update_community_model.dart';
import '../../data/remote_data_source/community_remote_data_source.dart';
import '../../data/repository/community_repository.dart';
import '../../domain/usecase/get_community_by_id.dart';

class UpdateCommunityProfileController extends GetxController{
@override
  void onInit() {
    currentCommunityId=Get.arguments;
    initCommunityProfile();
    super.onInit();
  }

updateCommunityCover() async {


    updatingCommunity = true;
    update();
    XFile? newPic = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (newPic != null) {
      final result = await UpdateCommunityCoverUseCase(
              UserRepository(UserRemoteDataSource()))
          .execute(currentCommunity.id, newPic);
      result.fold(
          (l) => customSnackBar(
              title: "",
              message: l.message.toString(),
              successful: false), (r) async {
        customSnackBar(title: "", message: r.toString(), successful: true);
        final currentUserController= Get.find<CurrentUserController>();
        await currentUserController.updateUserToken();
        await    currentUserController. getCurrentUser();
      });
    }
    updatingCommunity = false;
    update();
}

  bool updatingCommunity = false;

  updateCommunity() async {



       if (updateCommunityFormKey.currentState!.validate()) {
      updatingCommunity = true;
      update();
      final result =
          await UpdateCommunityUseCase(UserRepository(UserRemoteDataSource()))
              .execute(UpdateCommunityModel(
        id: currentCommunityId,
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
        final currentUserController= Get.find<CurrentUserController>();
        await currentUserController.updateUserToken();
        await    currentUserController. getCurrentUser();
      });
      updatingCommunity = false;
      update();
    }
  }


  final updateCommunityFormKey = GlobalKey<FormState>();
  TextEditingController communityUpdateNameController = TextEditingController();
  TextEditingController communityUpdateAddressController =
  TextEditingController();
  TextEditingController communityUpdateAboutController =
  TextEditingController();
  TextEditingController communityUpdateWebUrlController =
  TextEditingController();
  late CommunityModel currentCommunity;
late int currentCommunityId;
  initCommunityProfile() async {

    updatingCommunity = true;
    update();

    final result = await GetCommunityByIdUseCase(
            CommunityRepository(CommunityRemoteDataSource()))
        .execute(currentCommunityId);
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
}