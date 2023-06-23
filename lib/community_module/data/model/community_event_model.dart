import 'dart:developer';

import 'package:imperial/community_module/data/model/bank_account_model.dart';
import 'package:imperial/community_module/data/model/user_member_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';

class CommunityEventModel extends Community {
  CommunityEventModel(
      {required super.id,
      required super.name,
      super.websiteUrl = "",
      super.about = "",
      super.regionId = -1,
      super.membersNumber = -1,
      super.eventsNumber = -1,
      super.address = "",
      super.coverUrl = "",
      super.events = const [],
      super.members = const [],
      required super.admins ,
      super.bankAccount});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bank_details': bankAccount!.toJson(),
    };
  }

  static CommunityEventModel fromJson(Map<String, dynamic> json) {
    return CommunityEventModel(
      id: json['id'],
      name: json['name'],
      bankAccount: json['bank_details'] != null
          ? BankAccount.fromJson(json['bank_details'])
          : null, admins: json['admins']==null?[]: List.from(json['admins'])
        .map((member) => UserMember.fromJson(member))
        .toList(),
    );
  }
}
