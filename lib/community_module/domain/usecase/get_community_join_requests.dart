import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/data/models/request_communities_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/community_module/domain/entity/community_join_request.dart';
import 'package:imperial/community_module/domain/repository/base_community_repository.dart';
import 'package:imperial/core/utils/nework_exception.dart';

class GetCommunityJoinRequestsUseCase{
  BaseCommunityRepository communityRepository;

  GetCommunityJoinRequestsUseCase(this.communityRepository);
  Future<Either<ErrorMessageModel, List<CommunityJoinRequest>>>execute(int id)async{
    return await communityRepository.getCommunityJoinRequests(id);



  }
}