class RequestModel {
  late int userId;
  late int communityId;
  late int status;

  RequestModel({
    required this.userId,
    required this.communityId,
    required this.status,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      userId: json['user_id'],
      communityId: json['community_id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = userId;
    data['community_id'] = communityId;
    data['status'] = status;
    return data;
  }
}