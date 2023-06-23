import 'package:imperial/service_module/data/model/service_item_model.dart';
import 'package:imperial/service_module/data/model/service_rate_model.dart';

import '../../domain/entity/service.dart';

class ServiceModel extends CService {
  ServiceModel(
      {required super.id,
      required super.about,
      required super.totalRate,
      required super.name,
      required super.picUrl,
      required super.coverUrl,
      required super.email,
      required super.logoUrl,
      required super.websiteUrl,
      required super.address,
      required super.categoryId,
      required super.regionId,
      required super.serviceContacts,
      required super.itemTitle,
      required super.serviceItems,
      required super.gallery,
      required super.rates});

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
      'service_contacts': serviceContacts,
      'item_title': itemTitle
    };
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
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
        serviceContacts: List.from(
            (json['service_contacts'] as List).map((e) => e['phone'])),
        totalRate: double.parse(json['total_rate'].toString()),
        itemTitle: json['item_title'],
        serviceItems: List.from(json['service_items'] as List)
            .map((e) => ServiceItemModel.fromJson(e))
            .toList(),
        gallery: List.from(json['gallery'] as List)
            .map((e) => e.toString())
            .toList(),
        rates: List.from(json['service_rates']).map((e) => ServiceRateModel.fromJson(e)).toList());
  }
}
