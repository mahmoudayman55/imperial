import 'package:imperial/community_module/data/model/bank_account_model.dart';
import 'package:imperial/community_module/data/model/user_member_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';

import 'event_card_model.dart';

class UpdateCommunityModel extends Community {
  UpdateCommunityModel(
      {required super.id,
        required super.name,
        required super.websiteUrl,
        required super.about,
         super.regionId=-1,
         super.membersNumber=-1  ,
         super.eventsNumber =-1  ,
        required super.address,
         super.coverUrl= "" ,
         super.events  =  const[] ,
         super.members = const[] ,  super.admins=const[],
        super.bankAccount});

  Map<String, dynamic> toJson() {
    return {
      'name': super.name,
      'about': super.about,
      'address': super.address,
      'website_url': super.websiteUrl,

    };
  }

  factory UpdateCommunityModel.fromJson(Map<String, dynamic> json) {
    return UpdateCommunityModel(
        id: json['id'],
        name: json['name'],
        about: json['about'],
        membersNumber: json['members_number'],
        eventsNumber: json['events_number'],
        address: json['address'],
        coverUrl: json['cover_url'],
        events: List.from(json['events'])
            .map((eventJson) => EventCardModel.fromJson(eventJson))
            .toList(),
        websiteUrl: json['website_url'],
        regionId: json['region_id'],
        members: List.from(json['members'])
            .map((member) => UserMember.fromJson(member))
            .toList(), admins:     List.from(json['admins'])
        .map((member) => UserMember.fromJson(member))
        .toList(),
        bankAccount:json["bank_details"]==null?null: BankAccount.fromJson(json["bank_details"])
    );
  }
}
