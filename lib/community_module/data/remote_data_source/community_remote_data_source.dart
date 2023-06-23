import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:imperial/app_init_module/data/models/request_communities_model.dart';
import 'package:imperial/community_module/data/model/community_ticket_request_model.dart';
import 'package:imperial/community_module/data/model/user_member_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/community_module/domain/entity/event.dart';
import 'package:imperial/core/utils/ServerException.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../../../auth_module/data/models/user_ticket_request_model.dart';
import '../../../core/utils/app_constants.dart';
import '../../domain/entity/community_join_request.dart';
import '../../domain/entity/role.dart';
import '../model/community_card_model.dart';
import '../model/community_model.dart';
import '../model/event_card_model.dart';
import '../model/event_model.dart';
import '../model/event_table_model.dart';
import '../model/event_ticket_request.dart';
import '../model/new_event_model.dart';
import '../model/send_request_model.dart';
import 'package:http_parser/http_parser.dart';

abstract class BaseCommunityRemoteDataSource {
  Future<List<Community>> getCommunities(LimitParametersModel queryParameters);

  Future<List<Event>> getEvents(LimitParametersModel queryParameters);

  Future<Event> getEventById(int id);
  Future<List<UserMember>> getEventAdmins(int communityId);
  Future<Community> getCommunityById(int id);

  Future<List<Event>> getEventsOfCommunity(int id);

  Future<String> askToJoin(RequestModel requestModel);

  Future<List<CommunityJoinRequest>> getCommunityJoinRequests(int id);

  Future<String> addMember(Role role);

  Future<String> updateRequestStatus(CommunityJoinRequest joinRequest);

  Future<String> addNewEvent(NewEventModel newEvent);

  Future<String> removeEvent(int id);

  Future<String> addEventAttendee(
      {required int eventId, required int userId, required int ticketId});

  Future<String> sendTicketRequest(EventTicketRequest ticketRequest);

  Future<List<CommunityTicketRequest>> getEventTickets(int eventId);
}

class CommunityRemoteDataSource extends BaseCommunityRemoteDataSource {
  @override
  Future<List<Community>> getCommunities(
      LimitParametersModel queryParameters) async {
    try {
      final response = await Dio().get(AppConstants.communitiesRoute,
          queryParameters: queryParameters.toJson());
      log('CommunityRemoteDataSource: get communities data request successful');
      return List<Community>.from(
          (response.data[AppConstants.communitiesKey] as List)
              .map((e) => CommunityCardModel.fromJson(e)));
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

  @override
  Future<List<Event>> getEvents(LimitParametersModel queryParameters) async {
    try {
      final response = await Dio().get(AppConstants.eventsRoute,
          queryParameters: queryParameters.toJson(),
          options: CacheOptions(
                  store:
                      MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576),
                  maxStale: const Duration(hours: 10))
              .toOptions());
      log('CommunityRemoteDataSource: getEvents data request successful');
      return List<Event>.from((response.data[AppConstants.eventsKey] as List)
          .map((e) => EventCardModel.fromJson(e)));
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

  @override
  Future<Event> getEventById(int id) async {
    try {
      final response = await Dio().get("${AppConstants.eventsRoute}/$id",   options: CacheOptions(
          store:
          MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576),
          maxStale: const Duration(hours: 10))
          .toOptions());
      log('CommunityRemoteDataSource: getEvents data request successful');
      log(response.data.toString());
      return EventModel.fromJson(response.data);
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

  @override
  Future<Community> getCommunityById(int id) async {
    try {
      final response = await Dio().get("${AppConstants.communitiesRoute}/$id");
      log('CommunityRemoteDataSource: get community by id data request successful');
      log("CommunityRemoteDataSource: get community by id data request successful" +
          response.data.toString());
      return CommunityModel.fromJson(response.data);
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

  @override
  Future<List<Event>> getEventsOfCommunity(int id) async {
    try {
      final response =
          await Dio().get("${AppConstants.communityEventsRoute}/$id");

      log('CommunityRemoteDataSource: getEvents data request successful');
      log(response.data.toString());
      return List.from(response.data['events'] as List)
          .map((e) => EventTableModel.fromJson(e))
          .toList();
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

  @override
  Future<List<CommunityJoinRequest>> getCommunityJoinRequests(int id) async {
    try {
      final response =
          await Dio().get("${AppConstants.communityJoinRequestsRoute}/$id");

      log('CommunityRemoteDataSource: getEvents data request successful');
      log(response.data.toString());
      return List.from(response.data['joinRequests'] as List)
          .map((e) => CommunityJoinRequest.fromJson(e))
          .toList();
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

  @override
  Future<String> askToJoin(RequestModel requestModel) async {
    try {
      log(requestModel.toJson().toString());

      final response = await Dio()
          .post(AppConstants.askToJoinRoute, data: requestModel.toJson());
      log(requestModel.toJson().toString());

      log(response.data.toString());
      return response.data['msg'].toString();
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

  @override
  Future<String> addMember(Role role) async {
    try {
      final response =
          await Dio().post(AppConstants.addRoleRoute, data: role.toJson());

      //   log(response.data.toString());
      return response.data['msg'].toString();
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

  @override
  Future<String> updateRequestStatus(CommunityJoinRequest joinRequest) async {
    try {
      final response = await Dio().put(
          "${AppConstants.joinRequestStatusRoute}/${joinRequest.id}",
          data: joinRequest.toJson());

      log(response.statusCode.toString());
      return response.data['msg'].toString();
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

  @override
  Future<String> addNewEvent(NewEventModel newEvent) async {
    try {
      final formData = FormData.fromMap((await newEvent.toJson()));

      Response response = (await Dio().post(
        AppConstants.eventsRoute,
        data: formData,
      ));
      return response.data["msg"].toString();
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

  @override
  Future<String> removeEvent(int id) async {
    try {
      final response = await Dio().delete("${AppConstants.eventsRoute}/$id");

      log(response.statusCode.toString());
      return response.data['msg'].toString();
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

  @override
  Future<String> sendTicketRequest(EventTicketRequest ticketRequest) async {
    try {
      final response = await Dio().post(AppConstants.eventsTicketRequestRoute,
          data: ticketRequest.toJson());

      log(response.statusCode.toString());
      return response.data['msg'].toString();
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

  @override
  Future<List<CommunityTicketRequest>> getEventTickets(int eventId) async {
    try {
      final response =
          await Dio().get("${AppConstants.eventsTicketRequestRoute}/$eventId");
      log(response.statusCode.toString());
      return List.from(response.data["event_tickets"])
          .map((e) => CommunityTicketRequest.fromJson(e))
          .toList();
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

  @override
  Future<String> addEventAttendee(
      {required int eventId,
      required int userId,
      required int ticketId}) async {
    try {
      final response = await Dio()
          .put("${AppConstants.eventsTicketRequestRoute}/$ticketId", data: {
        "status": 1,
      });

      log(response.statusCode.toString());
      return response.data['msg'].toString();
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

  @override
  Future<List<UserMember>> getEventAdmins(int communityId) async {
    try {
      final response = await Dio()
          .get("${AppConstants.eventsCommunityAdmins}/$communityId");

      log(response.statusCode.toString());
      return (response.data["admins"] as List).map((e) => UserMember.fromJson(e)).toList();
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.unknown) {
        throw ServerException(
            ErrorMessageModel(message: "No internet connection"));
      }
      log(e.response!.data.toString());
      throw ServerException(ErrorMessageModel.fromJson(e.response!.data));
    }
  }
}
