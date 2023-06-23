import 'package:imperial/service_module/domain/entity/service_category.dart';

class ServiceCategoryModel extends ServiceCategory {
  ServiceCategoryModel(
      {required super.id, required super.name, required super.icon});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,

    };
  }

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],

    );
  }
}
