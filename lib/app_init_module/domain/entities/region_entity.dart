import 'package:hive/hive.dart';

import '../../../core/utils/app_constants.dart';
part '../../data/local_data_source/hive/adapters/region_entity.g.dart';

@HiveType(typeId: 0)
class Region  extends HiveObject{
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int id;

  Region( {required this.id,required this.name,});

  @override
  toString() {
    return name;
  }
}