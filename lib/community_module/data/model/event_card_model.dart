import 'package:intl/intl.dart';
import 'package:imperial/community_module/domain/entity/event.dart';

import 'event_cover_model.dart';

class EventCardModel extends Event {
  EventCardModel(
      {required super.id,
      required super.name,
      required super.appointment,
       super.phone='',
      required super.address,
       super.details='',
       super.long=-1,
       super.lat=-1,
       super.adultTicketPrice=-1,
       super.kidTicketPrice=-1,
       super.membersOnly=false,
       super.underFiveFree=false,
       super.maxAttendees=-1,
      required super.eventCovers});

factory EventCardModel.fromJson(Map<String, dynamic> json) {
return EventCardModel(
id: json['id'],
name: json['name'],
appointment: DateTime.parse(json['appointment']),
address: json['address'],
eventCovers: List.from(json['event_covers']).map((coverJson) => EventCoverModel.fromJson(coverJson)).toList(),
);
}


Map<String, dynamic> toJson() {

  return {
    'id': super.id,
    'name': super.name,
    'appointment':   DateFormat('d/M/y').format(super.appointment),
    'address': super.address,
    'event_covers': super.eventCovers.map((cover) => (cover as EventCoverModel).toJson()).toList(),
  };
}


}
