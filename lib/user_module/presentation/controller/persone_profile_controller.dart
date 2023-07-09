import 'package:get/get.dart';

import '../../../auth_module/data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import '../../../auth_module/data/remote_data_source/auth_remote_data_source.dart';
import '../../../auth_module/data/repository/auth_repository.dart';
import '../../../auth_module/domain/entities/user_entity.dart';
import '../../../auth_module/domain/usecase/get_user_by_id_use_case.dart';
import '../../../widgets/custom_snack_bar.dart';

class PersonProfileController extends GetxController{
@override
  void onInit() {
userId =Get.arguments;
getUser();
super.onInit();
  }
late int userId;
  late User selectedUser;
  bool gettingPerson = false;

  getUser() async {
    gettingPerson = true;
    update();
    final result = await GetUserByIdUseCase(
        AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource()))
        .execute(userId);
    result.fold(
            (l) => customSnackBar(
            title: "", message: l.message.toString(), successful: false),
            (r) => selectedUser = r);
    gettingPerson = false;
    update();
    update();
  }
}