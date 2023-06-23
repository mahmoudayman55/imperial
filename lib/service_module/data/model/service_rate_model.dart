class ServiceRateModel {
  final int serviceId;
  final int userId;

  final String userPic;
  final String userName;
  final String comment;
  final double rate;

  ServiceRateModel(
      {required this.userPic,
      required this.userName,
      required this.serviceId,
      required this.userId,
      required this.comment,
      required this.rate});

  factory ServiceRateModel.fromJson(Map<String, dynamic> json) {
    return ServiceRateModel(
      serviceId: json['service_id']??-1,
      comment: json['comment'],
      rate: double.parse(json['rate'].toString()),
      userId: json['user_id']??-1, userPic: json['user']['pic_url'], userName: json['user']['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "service_id": serviceId,
      'user_id': userId,
      'comment': comment,
      'rate': rate,
    };
  }
}
