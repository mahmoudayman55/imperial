import 'package:imperial/community_module/domain/entity/event.dart';

class EventNameModel extends Event {
  EventNameModel(
      {required super.id,
      required super.name,
       required super.appointment,
       super.phone="",
       super.address="",
       super.details="",
       super.long=0,
       super.lat=0,
       super.adultTicketPrice=-1,
       super.kidTicketPrice=-1,
       super.membersOnly=false,
       required super.underFiveFree,
       super.maxAttendees=-1,
       super.eventCovers=const[]});
Map<String, dynamic> toJson() {
    return {
        'id': id,
        'name': name,
        'under_five_free': underFiveFree,
        'appointment': appointment.toIso8601String(),
    };
}
///Todo: replace static date with real date from json

factory EventNameModel.fromJson(Map<String, dynamic> json) {
return EventNameModel(
id: json['id'],
name: json['name'],
appointment: DateTime.now(), underFiveFree: json["under_five_free"],
);
}
}
