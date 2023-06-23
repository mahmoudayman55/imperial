import 'package:dartz/dartz.dart';
import 'package:imperial/auth_module/data/models/user_ticket_request_model.dart';
import 'package:imperial/community_module/data/model/event_ticket_request.dart';
import 'package:imperial/community_module/data/model/new_event_model.dart';
import 'package:imperial/community_module/data/model/send_request_model.dart';
import 'package:imperial/community_module/data/model/user_member_model.dart';
import 'package:imperial/community_module/data/remote_data_source/community_remote_data_source.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/community_module/domain/entity/community_join_request.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:imperial/community_module/domain/entity/role.dart';
import 'package:imperial/community_module/domain/repository/base_community_repository.dart';
import 'package:imperial/core/utils/ServerException.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../../../app_init_module/data/models/request_communities_model.dart';
import '../model/community_ticket_request_model.dart';

class CommunityRepository extends BaseCommunityRepository{
  BaseCommunityRemoteDataSource communityRemoteDataSource;

  CommunityRepository(this.communityRemoteDataSource);

  @override
  Future<Either<ErrorMessageModel, List<Community>>> getCommunities(LimitParametersModel queryParameters) async {
   try {
     final response = await communityRemoteDataSource.getCommunities(queryParameters);
     return Right(response);
   }
   on ServerException catch (e){
     return Left(e.errorMessageModel);
   }
  }

  @override
  Future<Either<ErrorMessageModel, List<Event>>> getEvents(LimitParametersModel queryParameters) async {
    try {
      final response = await communityRemoteDataSource.getEvents(queryParameters);

      return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, Event>> getEventById(int id) async {
    try {    final response = await communityRemoteDataSource.getEventById(id);

    return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, Community>> getCommunityById(int id) async {
    try {    final response = await communityRemoteDataSource.getCommunityById(id);

    return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<Event>>> getEventsOfCommunity(int id) async {
    try {    final response = await communityRemoteDataSource.getEventsOfCommunity(id);

    return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<CommunityJoinRequest>>> getCommunityJoinRequests(int id) async {
    try {    final response = await communityRemoteDataSource.getCommunityJoinRequests(id);

    return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }

}

  @override
  Future<Either<ErrorMessageModel, String>> sendJoinRequest(RequestModel joinRequest) async {
    try {    final response = await communityRemoteDataSource.askToJoin(joinRequest);

    return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> addMember(Role role) async {
    try {    final response = await communityRemoteDataSource.addMember(role);

    return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> updateRequestStatus(CommunityJoinRequest joinRequest) async {
    try {    final response = await communityRemoteDataSource.updateRequestStatus(joinRequest);

    return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> addNewEvent(NewEventModel newEvent) async {
    try {
      final response = await communityRemoteDataSource.addNewEvent(newEvent);

    return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> removeEvent(int id) async {
    try {
      final response = await communityRemoteDataSource.removeEvent(id);

      return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, String>> sendTicketRequest(EventTicketRequest ticketRequest) async {
    try {
      final response = await communityRemoteDataSource.sendTicketRequest(ticketRequest);

      return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<CommunityTicketRequest>>> getEventTickets(int eventId) async {
    try {
      final response = await communityRemoteDataSource.getEventTickets(eventId);

      return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }

  }

  @override
  Future<Either<ErrorMessageModel, String>> addEventAttendee(
      {required int eventId, required int userId,required int ticketId}) async {
    try {
      final response = await communityRemoteDataSource.addEventAttendee(eventId: eventId, userId: userId, ticketId: ticketId);

      return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }

  @override
  Future<Either<ErrorMessageModel, List<UserMember>>> getEventAdmins(int communityId) async{
    try {
      final response = await communityRemoteDataSource.getEventAdmins(communityId);

      return Right(response);
    }
    on ServerException catch (e){
      return Left(e.errorMessageModel);
    }
  }}