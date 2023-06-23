import 'package:imperial/app_init_module/domain/entities/city.dart';

class CityModel extends City {
  CityModel({required super.id, required super.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
