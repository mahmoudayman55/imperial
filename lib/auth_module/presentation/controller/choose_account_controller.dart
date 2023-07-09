import 'package:get/get.dart';

import '../../../core/utils/app_constants.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../view/registration/Individual/Individual_register_1.dart';
import '../view/registration/business _registration_view.dart';
import '../view/registration/community_registration.dart';

class ChooseAccountTypeController extends GetxController{
  final List<String> types = [
    'Individual',
    'Community',
    'Business',
  ];
  int selectedType = -1;
  onAccountTypeChange(int index) {
    selectedType = index;
    update();
  }

  submitAccountType() async {
    if (selectedType == 0) {
      Get.toNamed( AppConstants.userRegister1Page);
    } else if (selectedType == 1) {
      Get.toNamed( AppConstants.communityRegisterPage);
    } else if (selectedType == 2) {

      Get.toNamed( AppConstants.serviceRegisterPage);

    } else if (selectedType == -1) {
      customSnackBar(
        title: "",
        message: "You did not select any type",
        successful: false,
      );
    }
  }
}