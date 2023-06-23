import '../../domain/entity/service_item.dart';

class ServiceItemModel extends ServiceItem {
  ServiceItemModel(
      {required super.id,
      required super.name,
      required super.imageUrl,
      required super.description});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'description': description,
    };
  }

  factory ServiceItemModel.fromJson(Map<String, dynamic> json) {
    return ServiceItemModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      description: json['description'],
    );
  }
}
