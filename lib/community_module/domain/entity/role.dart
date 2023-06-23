class Role {
  int userId;
  int communityId;
  String status;

  Role({
    required this.userId,
    required this.communityId,
    required this.status,
  });
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      userId: json['user_id'],
      communityId: json['entity_id'],
      status: json['role_title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = userId;
    data['entity_id'] = communityId;
    data['role_title'] = status;
    return data;
  }


}