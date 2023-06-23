import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/data/models/request_communities_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:imperial/community_module/domain/repository/base_community_repository.dart';

import '../../../core/utils/nework_exception.dart';

class GetCommunityByIdUseCase{
  BaseCommunityRepository communityRepository;

  GetCommunityByIdUseCase(this.communityRepository);
  Future<Either<ErrorMessageModel, Community>>execute(int id)async{
    return await communityRepository.getCommunityById(id);



  }
}