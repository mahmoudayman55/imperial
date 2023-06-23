abstract class AppNotification{
  String body;
  String title;
  String receiverToken;

  AppNotification({required this.body, required this.title, required this.receiverToken});

  toJson();
}