import 'package:imperial/community_module/data/model/bank_account_model.dart';
import 'package:imperial/community_module/data/model/user_member_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';

import 'event_card_model.dart';

class CommunityModel extends Community {
  CommunityModel(
      {required super.id,
      required super.name,
      required super.websiteUrl,
      required super.about,
      required super.regionId,
      required super.membersNumber,
      required super.eventsNumber,
      required super.address,
      required super.coverUrl,
      required super.events,
      required super.members, required super.admins, required super.bankAccount});

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'about': super.about,
      'members_number': super.membersNumber,
      'events_number': super.eventsNumber,
      'address': super.address,
      'cover_url': super.coverUrl,
      'events': super
          .events
          .map((event) => (event as EventCardModel).toJson())
          .toList(),
      "bank_details":bankAccount!.toJson()
    };
  }

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
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
