import 'package:imperial/service_module/domain/entity/service.dart';

class ServiceCardModel extends CService {
  ServiceCardModel({
    required super.id,
    required super.name,
    required super.picUrl,
    required super.coverUrl,
    required super.email,
    required super.logoUrl,
    required super.websiteUrl,
    required super.address,
    required super.categoryId,
    required super.regionId,
    required super.totalRate,
    super.serviceContacts = const [],
    required super.about,  super.itemTitle='',  super.serviceItems=const[],  super.gallery=const[],  super.rates=const[],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pic_url': picUrl,
      'cover_url': coverUrl,
      'email': email,
      'logo_url': logoUrl,
      'website_url': websiteUrl,
      'address': address,
      'category_id': categoryId,
      'region_id': regionId,
      'about': about,
    };
  }

  factory ServiceCardModel.fromJson(Map<String, dynamic> json) {
    return ServiceCardModel(
      id: json['id'],
      name: json['name'],
      picUrl: json['pic_url'],
      coverUrl: json['cover_url'],
      email: json['email'],
      logoUrl: json['logo_url'],
      websiteUrl: json['website_url'],
      address: json['address'],
      categoryId: json['category_id'],
      regionId: json['region_id'],
      about: json['about'],
      totalRate: double.parse(json['total_rate'].toString()) ,
    );
  }
}
