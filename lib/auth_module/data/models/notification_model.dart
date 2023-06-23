
import '../../domain/entities/notification.dart';

class NotificationModel extends AppNotification{
  NotificationModel({required super.body, required super.title, required super.receiverToken});

  @override
  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'title': title,
    };
  }

}