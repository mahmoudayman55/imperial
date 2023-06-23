import 'package:dartz/dartz.dart';
import 'package:imperial/auth_module/data/models/user_ticket_request_model.dart';
import 'package:imperial/community_module/data/model/event_ticket_request.dart';
import 'package:imperial/community_module/data/model/user_member_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/community_module/domain/entity/role.dart';

import '../../../app_init_module/data/models/request_communities_model.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../../../auth_module/domain/entities/user_entity.dart';
import '../../data/model/community_ticket_request_model.dart';
import '../../data/model/new_event_model.dart';
import '../../data/model/send_request_model.dart';
import '../entity/community_join_request.dart';

abstract class BaseCommunityRepository {
  /*
  {"regionId":1,"limit"=0,"offset":0}
  max limit= 5,
  offset=length of returned data
  */
  Future<Either<ErrorMessageModel, List<Community>>> getCommunities(
      LimitParametersModel queryParameters);
    Future<Either<ErrorMessageModel, List<Event>>> getEvents(
      LimitParametersModel queryParameters);
    Future<Either<ErrorMessageModel, Event>> getEventById(
      int id);
    Future<Either<ErrorMessageModel, Community>> getCommunityById(
      int id);
    Future<Either<ErrorMessageModel, List<Event>>> getEventsOfCommunity(
      int id);
    Future<Either<ErrorMessageModel, List<CommunityJoinRequest>>> getCommunityJoinRequests(
      int id);

      Future<Either<ErrorMessageModel, String>> sendJoinRequest(RequestModel joinRequest);
      Future<Either<ErrorMessageModel, String>> addMember(Role role);
      Future<Either<ErrorMessageModel, String>> updateRequestStatus(CommunityJoinRequest joinRequest);
  Future<Either<ErrorMessageModel, String>> addNewEvent(NewEventModel newEvent);
  Future<Either<ErrorMessageModel, String>> removeEvent(int  id);
  Future<Either<ErrorMessageModel, String>> addEventAttendee(
      {required int eventId, required int userId,required int ticketId});
  Future<Either<ErrorMessageModel, String>> sendTicketRequest(EventTicketRequest ticketRequest);
  Future<Either<ErrorMessageModel, List<CommunityTicketRequest>>> getEventTickets( int eventId);
  Future<Either<ErrorMessageModel, List<UserMember>>> getEventAdmins( int communityId);






}
