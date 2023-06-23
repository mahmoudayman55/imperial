import 'dart:developer';

import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/community_module/data/model/community_event_model.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import '../../../app_init_module/data/models/language_model.dart';
import '../../../auth_module/domain/entities/user_entity.dart';
import '../../domain/entity/community.dart';
import 'event_cover_model.dart';
import 'user_member_model.dart';

class EventModel extends Event {
final int attendees;
  final List<String> instructions;
  final List<SpeakingLanguage> speakingLanguages;
  final Community community;
  final String referenceNumber;

  EventModel(
      {required this.instructions,
      required this.speakingLanguages,
      required this.referenceNumber,
      required super.id,
       required this.attendees,
      required this.community,
      required super.name,
      required super.appointment,
      required super.phone,
      required super.address,
      required super.details,
      required super.long,
      required super.lat,
      required super.adultTicketPrice,
      required super.membersOnly,
      required super.underFiveFree,
      required super.maxAttendees,
      required super.eventCovers,
      required super.kidTicketPrice});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    log( "asdasdas"+json["numberOfAttendees"].toString());
    return EventModel(
      id: json['id'] as int,
      name: json['name'] as String,
      appointment: DateTime.parse(json['appointment'] as String),
      phone: json['phone'] as String,
      address: json['address'] as String,
      details: json['details'] as String,
      long: (json['long'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      adultTicketPrice: (json['adult_ticket_price'] as num).toDouble(),
      membersOnly: json['members_only'] as bool,
      maxAttendees: json['max_attendees'] as int,
      eventCovers: List.from(json['event_covers'])
          .map((coverJson) => EventCoverModel.fromJson(coverJson))
          .toList(),
      // attendees: List.from(json['attendees'])
      //     .map((attendees) => UserMember.fromJson(attendees))
      //     .toList(),
      community: CommunityEventModel.fromJson(json['Community']),
      instructions: List.from(json['instructions'])
          .map((instruction) => instruction.toString())
          .toList(),
      speakingLanguages: List.from(json['languages'])
          .map((lang) => SpeakingLanguageModel.fromJson(lang))
          .toList(),
      kidTicketPrice: (json['kid_ticket_price'] as num).toDouble(),
      underFiveFree: json["under_five_free"], referenceNumber: json["refrence_number"], attendees: json["numberOfAttendees"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'appointment': appointment.toIso8601String(),
      'phone': phone,
      'address': address,
      'details': details,
      'long': long,
      'lat': lat,
      'refrence_number': referenceNumber,
      'kid_ticket_price': kidTicketPrice,
      'adult_ticket_price': adultTicketPrice,
      // 'attendees': attendees,
      'Community': community,
      'members_only': membersOnly,
      'under_five_free': underFiveFree,
      'max_attendees': maxAttendees,
      'event_covers': super
          .eventCovers
          .map((cover) => (cover as EventCoverModel).toJson())
          .toList(),
    };
  }
}
