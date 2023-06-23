import 'package:dartz/dartz.dart';
import 'package:imperial/search_module/domain/repo/base_search_repo.dart';

import '../../../core/utils/nework_exception.dart';
import '../entity/search_result_entity.dart';

class SearchUseCase{
  BaseSearchRepo searchRepo;

  SearchUseCase(this.searchRepo);
  Future<Either<ErrorMessageModel,List<SearchResult>>>execute(String query)async{
    return await searchRepo.search(query);
  }

}
