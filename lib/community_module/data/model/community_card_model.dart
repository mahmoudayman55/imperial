import 'package:imperial/community_module/data/model/event_card_model.dart';

import '../../domain/entity/community.dart';

class CommunityCardModel extends Community {
  CommunityCardModel(
      {required super.id,
      required super.name,
       super.websiteUrl='',
      required super.about,
       super.regionId=-1,
      required super.membersNumber,
      required super.eventsNumber,
      required super.address,
      required super.coverUrl,
      required super.events,  super.members=const[]  ,super.admins=const[],  super.bankAccount});


Map<String, dynamic> toJson() {
  return {
    'id': super.id,
    'name': super.name,
    'about': super.about,
    'members_number': super.membersNumber,
    'events_number': super.eventsNumber,
    'address': super.address,
    'cover_url': super.coverUrl,
    'events': super.events.map((event) => (event as EventCardModel).toJson()).toList(),
  };
}

factory CommunityCardModel.fromJson(Map<String, dynamic> json) {
return CommunityCardModel(
id: json['id'],
name: json['name'],
about: json['about'],
membersNumber: json['members_number'],
eventsNumber: json['events_number'],
address: json['address'],
coverUrl: json['cover_url'],
events: (json['events'] as List<dynamic>)
    .map((eventJson) => EventCardModel.fromJson(eventJson))
    .toList(),
);
}
}
