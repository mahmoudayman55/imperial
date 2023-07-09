import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../auth_module/data/local_data_source/hive/adapters/base_auth_local_data_source/auth_local_data_source.dart';
import '../../../auth_module/data/models/user_ticket_model.dart';
import '../../../auth_module/data/remote_data_source/auth_remote_data_source.dart';
import '../../../auth_module/data/repository/auth_repository.dart';
import '../../../auth_module/domain/usecase/get_user_ticket_requests_use_case.dart';
import '../../../auth_module/presentation/controller/user_join_requests_controller.dart';

class UserTicketRequestsController extends GetxController{
  Future<void> generateQRCodeFromObject(
      BuildContext context,
      UserTicketModel ticket,
      ) async {
    final jwt = JWT(
      // Payload
      ticket.toJson(),
    );
    String token =
    jwt.sign(SecretKey('9-_U7JlTqZD7dRgJxRzawv7c3z8QOZLWq5pF2G7nLdI'));

    // Generate a QR code image from the JWT token
    final qrCode = QrImageView(
      data: token,
      version: QrVersions.auto,
      embeddedImage: AssetImage("assets/images/logoqr.jpg.png"),
      embeddedImageStyle: const QrEmbeddedImageStyle(
        size: Size(75, 25),
      ),
      size: 300,
    );
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: qrCode,
          );
        });
  }



  @override
  void onInit() {
    _userTicketRequests = <UserTicketModel>[].obs;

    userId= Get.arguments;
    getUserTicketRequests();
    super.onInit();
  }
  late int userId;
  getUserTicketRequests() async {

    gettingUserTicketRequests.value = true;
    gettingUserTicketRequests.refresh();
    final result = await GetUserTicketRequestsUseCase(
            AuthRepository(AuthRemoteDataSource(), AuthLocalDataSource()))
        .execute(userId);
    result.fold((l) => null, (r) => _userTicketRequests.assignAll(r));
    _userTicketRequests.refresh();
    gettingUserTicketRequests.value = false;
    gettingUserTicketRequests.refresh();
  }
  RxBool gettingUserTicketRequests = false.obs;

  late RxList<UserTicketModel> _userTicketRequests;

  RxList<UserTicketModel> get userTicketRequests => _userTicketRequests; //
}