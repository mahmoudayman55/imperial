import 'package:dartz/dartz.dart';

import '../repository/base_community_repository.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import '../../../core/utils/nework_exception.dart';

class GetCommunityEventUseCase{
  BaseCommunityRepository communityRepository;

  GetCommunityEventUseCase(this.communityRepository);
  Future<Either<ErrorMessageModel, List<Event>>>execute(int id)async{
    return await communityRepository.getEventsOfCommunity(id);



  }
}