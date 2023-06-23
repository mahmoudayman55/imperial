import 'package:imperial/app_init_module/domain/entities/region_entity.dart';
import 'package:imperial/core/utils/app_constants.dart';

class RegionModel extends Region {
  RegionModel({required super.name, required super.id});

  factory RegionModel.fromJson(Map<String, dynamic> map) {
    return RegionModel(
        name: map[AppConstants.regionNameKey], id: map[AppConstants.idKey]);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[AppConstants.regionNameKey] = name;
    return data;
  }
}
