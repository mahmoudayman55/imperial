import 'package:dartz/dartz.dart';
import 'package:imperial/core/utils/nework_exception.dart';
import 'package:imperial/search_module/data/data_source/search_remote_data_source.dart';
import 'package:imperial/search_module/domain/entity/search_result_entity.dart';
import 'package:imperial/search_module/domain/repo/base_search_repo.dart';

import '../../../core/utils/ServerException.dart';

class SearchRepo implements BaseSearchRepo{
  final BaseSearchRemoteDataSource remoteDataSource;

  SearchRepo(this.remoteDataSource);

  @override
  Future<Either<ErrorMessageModel, List<SearchResult>>> search(String query)async {
    try {    final result = await remoteDataSource.search(query);

    return Right(result);
    }   on ServerException catch (e) {
      return Left(e.errorMessageModel);
    }
  }

}