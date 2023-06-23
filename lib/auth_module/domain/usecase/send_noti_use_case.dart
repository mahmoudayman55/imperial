import 'package:dartz/dartz.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../entities/notification.dart';
import '../entities/user_entity.dart';
import '../repository/base_auth_repository.dart';

class SendNotificationUseCase{
  BaseAuthRepository authRepository;

  SendNotificationUseCase(this.authRepository);
  Future<Either<ErrorMessageModel, String>> execute(AppNotification notification) async {
    return await authRepository.sendNotification(notification);



  }
}