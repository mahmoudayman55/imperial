import 'package:dartz/dartz.dart';
import 'package:imperial/auth_module/domain/repository/base_auth_repository.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../../data/models/user_join_request_model.dart';

class GetUserJoinRequestsUseCase{
  BaseAuthRepository authRepository;
  GetUserJoinRequestsUseCase(this.authRepository);
  Future<Either<ErrorMessageModel, List<UserJoinRequest>>>execute(int id)async{
    return await authRepository.getUserJoinRequests(id);
  }
}