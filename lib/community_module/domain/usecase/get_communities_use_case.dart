import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/data/models/request_communities_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/community_module/domain/repository/base_community_repository.dart';
import 'package:imperial/core/utils/nework_exception.dart';

class GetCommunitiesUseCase{
  BaseCommunityRepository communityRepository;

  GetCommunitiesUseCase(this.communityRepository);
  Future<Either<ErrorMessageModel, List<Community>>>execute(LimitParametersModel queryParameters)async{
    return await communityRepository.getCommunities(queryParameters);



  }
}