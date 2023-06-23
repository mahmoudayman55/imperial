import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/data/models/request_communities_model.dart';
import 'package:imperial/community_module/data/model/user_member_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/community_module/domain/entity/community_join_request.dart';
import 'package:imperial/community_module/domain/repository/base_community_repository.dart';
import 'package:imperial/core/utils/nework_exception.dart';

class GetEventAdminsUseCase{
  BaseCommunityRepository communityRepository;

  GetEventAdminsUseCase(this.communityRepository);
  Future<Either<ErrorMessageModel, List<UserMember>>>execute(int communityId)async{
    return await communityRepository.getEventAdmins(communityId);



  }
}