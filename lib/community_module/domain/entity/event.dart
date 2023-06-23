import 'package:imperial/app_init_module/domain/entities/language_entity.dart';

import 'event_cover.dart';

class Event {
  int id;
  String name;
  DateTime appointment;
  String phone;
  String address;
  String details;
  double long;
  double lat;
  double adultTicketPrice;
  double kidTicketPrice;
  bool membersOnly;
  bool underFiveFree;
  int maxAttendees;
  List<EventCover> eventCovers;

  Event({
    required this.id,
    required this.name,
    required this.appointment,
    required this.phone,
    required this.address,
    required this.details,
    required this.long,
    required this.lat,
    required this.adultTicketPrice,
    required this.kidTicketPrice,
    required this.membersOnly,
    required this.underFiveFree,
    required this.maxAttendees,
    required this.eventCovers,
  });}
