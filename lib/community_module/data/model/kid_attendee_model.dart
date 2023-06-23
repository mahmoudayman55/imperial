import 'package:imperial/community_module/domain/entity/attendee.dart';

class KidAttendeeModel extends Attendee{
  int age;
  double? cost;
  KidAttendeeModel(super.name, {required this.age, this.cost,});
  factory KidAttendeeModel.fromJson(Map<String, dynamic> json) {
    return KidAttendeeModel(
      json['name'],
      age: json['age'],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['age'] = age;

    return data;
  }
}