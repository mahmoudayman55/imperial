import 'package:imperial/community_module/domain/entity/attendee.dart';

class AdultAttendeeModel extends Attendee{
  AdultAttendeeModel(super.name);
  factory AdultAttendeeModel.fromJson(Map<String, dynamic> json) {
    return AdultAttendeeModel(
      json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}