import 'package:dartz/dartz.dart';
import 'package:imperial/core/utils/nework_exception.dart';
import 'package:imperial/search_module/domain/entity/search_result_entity.dart';

abstract class BaseSearchRepo{
  Future<Either<ErrorMessageModel,List<SearchResult>>>search(String query);
}