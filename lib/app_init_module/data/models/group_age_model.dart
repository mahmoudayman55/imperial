import 'package:imperial/app_init_module/domain/entities/group_age_entity.dart';
import 'package:imperial/core/utils/app_constants.dart';

class GroupAgeModel extends GroupAge {
  GroupAgeModel({required super.id, required super.groupAge});

  factory GroupAgeModel.fromJson(Map<String, dynamic> json) {
    return GroupAgeModel(
      id: json[AppConstants.idKey] ,
      groupAge: json[AppConstants.groupAgesKey] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.idKey: id,
      AppConstants.groupAgesKey: groupAge,
    };
  }
}
