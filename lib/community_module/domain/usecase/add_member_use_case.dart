
import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/data/models/request_communities_model.dart';
import 'package:imperial/auth_module/domain/entities/user_entity.dart';
import 'package:imperial/community_module/data/model/send_request_model.dart';
import 'package:imperial/community_module/domain/entity/community.dart';
import 'package:imperial/community_module/domain/entity/role.dart';
import 'package:imperial/community_module/domain/repository/base_community_repository.dart';
import 'package:imperial/core/utils/nework_exception.dart';

class AddMemberUseCase{
  BaseCommunityRepository communityRepository;

  AddMemberUseCase(this.communityRepository);
  Future<Either<ErrorMessageModel, String>>execute(Role role)async{
    return await communityRepository.addMember(role);



  }
}