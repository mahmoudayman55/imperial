import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:imperial/auth_module/presentation/controller/user_join_requests_controller.dart';
import 'package:imperial/auth_module/presentation/controller/current_user_controller.dart';

import '../../../widgets/custom_snack_bar.dart';
import '../../../widgets/notification_snack_bar.dart';
import '../../data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import '../../data/models/notification_model.dart';
import '../../data/remote_data_source/auth_remote_data_source.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/entities/notification.dart';
import '../../domain/usecase/send_noti_use_case.dart';
import 'dart:developer';

class NotificationController extends GetxController {
  sendNotification(AppNotification notification) async {
    final result = await SendNotificationUseCase(
            AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource()))
        .execute(notification);
    result.fold((l) {

    }, (r) {});
  }

  @override
  void onInit() {
    startListener();
  }

  startListener() {
    FirebaseMessaging.onMessage.listen((message) {





      final currentUserController= Get.find<CurrentUserController>();
      if(currentUserController.currentUser==null){
        return;
      }
      currentUserController.updateUserToken();

      notificationSnackBar(
        title: message.notification!.title.toString(),
        message: message.notification!.body.toString(),

      );
    });
  }
}
