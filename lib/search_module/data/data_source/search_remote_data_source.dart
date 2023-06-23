import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:imperial/search_module/data/model/search_result_model.dart';

import '../../../core/utils/ServerException.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/nework_exception.dart';
import '../../domain/entity/search_result_entity.dart';

abstract class BaseSearchRemoteDataSource {
  Future<List<SearchResult>> search(String query);
}

class SearchRemoteDataSource implements BaseSearchRemoteDataSource {
  @override
  Future<List<SearchResult>> search(String query) async {
    try {
      final response = await Dio()
          .get(AppConstants.searchRoute, queryParameters: {"q": query});
      return List<SearchResult>.from(
          (response.data["results"] as List)
              .map((e) => SearchResultModel.fromJson(e)));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }
}
