import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/data/models/request_communities_model.dart';
import 'package:imperial/community_module/data/model/send_request_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/community_module/domain/repository/base_community_repository.dart';
import 'package:imperial/core/utils/nework_exception.dart';

class AskToJoinUseCase{
  BaseCommunityRepository communityRepository;

  AskToJoinUseCase(this.communityRepository);
  Future<Either<ErrorMessageModel, String>>execute(RequestModel requestModel)async{
    return await communityRepository.sendJoinRequest(requestModel);



  }
}