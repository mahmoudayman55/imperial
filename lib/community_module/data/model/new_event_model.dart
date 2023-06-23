
import 'dart:convert';
import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart'as dio;
import '../../domain/entity/event_cover.dart';

class NewEventModel extends Event {
  List<String> instructions;
  List<XFile> images;
  List<int> languages;
   int communityId;
String referenceNumber;
  NewEventModel(
  {required this.instructions,
  required this.languages,
  required this.images,
  required this.referenceNumber,
   super.id=-1,
  required this.communityId,
  required super.name,
  required super.appointment,
  required super.phone,
  required super.address,
  required super.details,
   super.long=0,
   super.lat=0,
  required super.adultTicketPrice,
  required super.membersOnly,
  required super.maxAttendees,
   super.eventCovers=const[], required super.kidTicketPrice, required super.underFiveFree});

Future<Map<String, dynamic>> toJson() async {
  final fileList = await Future.wait(images.map((e) async {
    final file = dio.MultipartFile.fromFile(
        e.path, filename: e.name, contentType: MediaType('image', 'jpeg'));
    return file;
  }));
  final Map<String, dynamic> data = {
    'name': name,
    'appointment': appointment.toIso8601String(),
    'phone': phone,
    'address': address,
    'details': details,
    'long': 0,
    'lat': 0,
    'adult_ticket_price': adultTicketPrice,
    'kid_ticket_price': kidTicketPrice,
    'members_only': membersOnly,
    'refrence_number': referenceNumber,
    'under_five_free': underFiveFree,
    'max_attendees': maxAttendees,
    'community_id': communityId,
    'instructions': jsonEncode(instructions),
    'languages': jsonEncode(languages),
    "covers":fileList

  };
log(data.toString());
  return data;
}
}