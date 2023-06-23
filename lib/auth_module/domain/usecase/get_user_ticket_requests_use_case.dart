import 'package:dartz/dartz.dart';
import 'package:imperial/auth_module/data/models/user_ticket_model.dart';
import 'package:imperial/auth_module/domain/repository/base_auth_repository.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../../data/models/user_join_request_model.dart';

class GetUserTicketRequestsUseCase{
  BaseAuthRepository authRepository;
  GetUserTicketRequestsUseCase(this.authRepository);
  Future<Either<ErrorMessageModel, List<UserTicketModel>>>execute(int id)async{
    return await authRepository.getUserTicketRequests(id);
  }
}