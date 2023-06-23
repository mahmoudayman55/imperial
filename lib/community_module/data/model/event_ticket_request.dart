import 'package:imperial/community_module/data/model/adult_attendee_model.dart';
import 'package:imperial/community_module/data/model/kid_attendee_model.dart';

class EventTicketRequest {
  int userId;
  String? bankHolderName;
  int eventId;
  int status;
  double total;
  List<AdultAttendeeModel> adults;
  List<KidAttendeeModel> kids;

  EventTicketRequest({
    required this.userId,
     this.bankHolderName,
    required this.adults,
    required this.kids,
    required this.total,
    required this.eventId,
    this.status = 2,
  });

  factory EventTicketRequest.fromJson(Map<String, dynamic> json) {
    return EventTicketRequest(
      userId: json['owner_id'],
      adults: (json['adults']as List).map((e) => AdultAttendeeModel.fromJson(e)).toList(),
      kids: (json['kids']as List).map((e) => KidAttendeeModel.fromJson(e)).toList(),
      eventId: json['event_id'],
      total: json['total'],
      status: json['status'] ?? 2, bankHolderName: json['bank_holder_name']??"",
    );
  }

  Map<String, dynamic> toJson() => {
    'owner_id': userId,
    'event_id': eventId,
    'status': status,
    'total': total,
    'adults': adults,
    'kids': kids,
    'bank_holder_name': bankHolderName,
  };
}