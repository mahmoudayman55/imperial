import 'package:imperial/community_module/domain/entity/event.dart';

class EventTableModel extends Event {
  EventTableModel(
  {required super.id,
  required super.name,
  required super.appointment,
  super.phone='',
   super.address='',
  super.details='',
  super.long=-1,
  super.lat=-1,
  super.adultTicketPrice=-1,
  super.kidTicketPrice=-1,
  super.membersOnly=false,
  super.underFiveFree=false,
  super.maxAttendees=-1,
   super.eventCovers=const[]});


factory EventTableModel.fromJson(Map<String, dynamic> json) {
return EventTableModel(
id: json['id'],
name: json['name'],
appointment: DateTime.parse(json['appointment']),

);
}






}
