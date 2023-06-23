import 'package:imperial/auth_module/data/models/user_model.dart';

import '../../../auth_module/data/models/user_request_model.dart';
import '../../../auth_module/domain/entities/user_entity.dart';

class CommunityJoinRequest {
  final int id;
 final int status;
 final User user;

  CommunityJoinRequest( {
    required this.status,required this.id,
    required this.user,
  });

  factory CommunityJoinRequest.fromJson(Map<String, dynamic> json) {
    return CommunityJoinRequest(
      status: json['status'],
      user: UserRequestModel.fromJson(json['user']), id:  json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['id'] = id;
    return data;
  }

}