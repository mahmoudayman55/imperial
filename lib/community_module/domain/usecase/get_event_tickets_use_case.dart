import 'package:dartz/dartz.dart';

import '../../data/model/community_ticket_request_model.dart';
import '../repository/base_community_repository.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import '../../../core/utils/nework_exception.dart';

class GetEventTicketsUseCase{
  BaseCommunityRepository communityRepository;

  GetEventTicketsUseCase(this.communityRepository);
  Future<Either<ErrorMessageModel, List<CommunityTicketRequest>>>execute(int id)async{
    return await communityRepository.getEventTickets(id);
  }
}