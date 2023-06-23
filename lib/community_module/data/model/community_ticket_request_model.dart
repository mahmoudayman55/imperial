import 'package:imperial/auth_module/data/models/user_request_model.dart';
import 'package:imperial/auth_module/data/models/user_ticket_request_model.dart';
import 'package:imperial/community_module/data/model/adult_attendee_model.dart';

import 'kid_attendee_model.dart';

class CommunityTicketRequest {
  int id;
  int status;
  String? bankHolder;
  DateTime sendingTime;
  bool underFiveFree;
  UserTicketRequestModel user;
  List<AdultAttendeeModel> adultAttendees;
  List<KidAttendeeModel> kidAttendees;
  double kidTicketPrice;
  double adultTicketPrice;

  CommunityTicketRequest(
      {required this.id,
      required this.status,
      required this.bankHolder,
      required this.adultAttendees,
      required this.kidAttendees,
      required this.kidTicketPrice,
        required this.underFiveFree,
      required this.adultTicketPrice,
      required this.user,
      required this.sendingTime});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'user': user.toJson(),
      'createdAt': sendingTime.toIso8601String(),
      'adult_attendees':
      adultAttendees.map((attendee) => attendee.toJson()).toList(),
      'kid_attendees': kidAttendees.map((attendee) => attendee.toJson()).toList(),
      'event': {
        'kid_ticket_price': kidTicketPrice.toString(),
        'adult_ticket_price': adultTicketPrice.toString(),
        'under_five_free': underFiveFree,
      },
      'bank_holder_name': bankHolder,

    };
  }
  factory CommunityTicketRequest.fromJson(Map<String, dynamic> json) {
    return CommunityTicketRequest(
      id: json['id'],
      status: json['status'],
      user: UserTicketRequestModel.fromJson(json['user']),
      sendingTime: DateTime.parse(json['createdAt']),
      adultAttendees: (json['adult_attendees']as List).map((e) => AdultAttendeeModel.fromJson(e)).toList(),
      kidAttendees: (json['kid_attendees']as List).map((e) => KidAttendeeModel.fromJson(e)).toList(),
      kidTicketPrice: double.parse((json['event']["kid_ticket_price"]).toString()),
      adultTicketPrice: double.parse(json['event'][ "adult_ticket_price"].toString()),
      bankHolder: json["bank_holder_name"], underFiveFree: json['event'][ "under_five_free"],

    );
  }

double getTotalAdultPrice(){
    return adultAttendees.length*adultTicketPrice;
}
double getKidsTicketPrice(){
    if(!underFiveFree){
      return kidTicketPrice*kidAttendees.length;
    }
    else
    return kidAttendees.where((element) => element.age>=5).length*kidTicketPrice;
}
double getTotalTicketPrice(){
return getTotalAdultPrice()+getKidsTicketPrice();
}
}
