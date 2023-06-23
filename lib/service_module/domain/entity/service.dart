import 'package:imperial/service_module/data/model/service_rate_model.dart';
import 'package:imperial/service_module/domain/entity/service_item.dart';

class CService {
  int id;
  String name;
  String itemTitle;
  String about;
  String picUrl;
  String coverUrl;
  String email;
  String logoUrl;
  String websiteUrl;
  String address;
  int categoryId;
  double totalRate;
  int regionId;
  List<String> serviceContacts;
  List<String> gallery;
  List<ServiceItem> serviceItems;
  List<ServiceRateModel> rates;

  CService({
    required this.id,
    required this.rates,
    required this.itemTitle,
    required this.about,
    required this.totalRate,
    required this.name,
    required this.picUrl,
    required this.coverUrl,
    required this.email,
    required this.logoUrl,
    required this.websiteUrl,
    required this.address,
    required this.categoryId,
    required this.regionId,
    required this.serviceContacts,
    required this.serviceItems,
    required this.gallery,
  });

}