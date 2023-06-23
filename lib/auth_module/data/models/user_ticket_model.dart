import 'package:imperial/auth_module/data/models/EventNameModel.dart';
import 'package:imperial/community_module/data/model/community_event_model.dart';

import '../../../community_module/data/model/adult_attendee_model.dart';
import '../../../community_module/data/model/kid_attendee_model.dart';

class UserTicketModel {
  int id;
  String? bankHolder;
  List<AdultAttendeeModel> adultAttendees;
  List<KidAttendeeModel> kidAttendees;
  double kidTicketPrice;
  double adultTicketPrice;
  int status;
  DateTime send;
  EventNameModel event;

  UserTicketModel({
    required this.id,
    required this.bankHolder,
    required this.adultAttendees,
    required this.kidAttendees,
    required this.kidTicketPrice,
    required this.adultTicketPrice,
    required this.status,
    required this.send,
    required this.event,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'createdAt': send.toIso8601String(),
      'adult_attendees': adultAttendees.map((e) => e.toJson()).toList(),
      'kid_attendees': kidAttendees.map((e) => e.toJson()).toList(),
      'event': event.toJson(),
      'totalAdultsPrice': adultTicketPrice,
      'totalKidsPrice': kidTicketPrice,
      'bank_holder_name': bankHolder,
    };
  }
  factory UserTicketModel.fromJson(Map<String, dynamic> json) {
    return UserTicketModel(
      id: json['id'],
      status: json['status'],
   // send: DateTime.now(),
     send: DateTime.parse(json['createdAt']),
      adultAttendees: (json['adult_attendees']??[])
          .map<AdultAttendeeModel>((e) => AdultAttendeeModel.fromJson(e))
          .toList(),
      kidAttendees: (json['kid_attendees']??[])
          .map<KidAttendeeModel>((e) => KidAttendeeModel.fromJson(e))
          .toList(),
      kidTicketPrice: double.parse((json['event']["kid_ticket_price"]).toString()),
      adultTicketPrice: double.parse(json['event'][ "adult_ticket_price"].toString()),
      bankHolder: json["bank_holder_name"],

      event: EventNameModel.fromJson(json['event']),
    );
  }
  factory UserTicketModel.fromQrJson(Map<String, dynamic> json) {
    return UserTicketModel(
      id: json['id'],
      status: json['status'],
      send: DateTime.parse(json['createdAt']),
      adultAttendees: (json['adult_attendees']??[] )
          .map<AdultAttendeeModel>((e) => AdultAttendeeModel.fromJson(e))
          .toList(),
      kidAttendees: (json['kid_attendees']??[])
          .map<KidAttendeeModel>((e) => KidAttendeeModel.fromJson(e))
          .toList(),  event: EventNameModel.fromJson(json['event']),
      adultTicketPrice: double.parse(json['totalAdultsPrice'].toString()),
      kidTicketPrice: double.parse(json['totalKidsPrice'].toString()),
      bankHolder: json['bank_holder_name'],
    );
  }
  double getTotalAdultPrice(){
    return adultAttendees.length*adultTicketPrice;
  }
  double getKidsTicketPrice(){
    if(!event.underFiveFree){
      return kidTicketPrice*kidAttendees.length;
    }
    else
      return kidAttendees.where((element) => element.age>=5).length*kidTicketPrice;
  }
  double getTotalTicketPrice(){
    return getTotalAdultPrice()+getKidsTicketPrice();
  }
}
