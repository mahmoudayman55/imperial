import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/domain/entities/language_entity.dart';
import 'package:imperial/core/utils/nework_exception.dart';

import '../repository/base_app_init_repository.dart';

class GetSpeakingLanguagesUseCase{

  BaseAppInitRepository baseAppInitRepository;

  GetSpeakingLanguagesUseCase(this.baseAppInitRepository);

  Future<Either<ErrorMessageModel, List<SpeakingLanguage>>> execute()async{
    return await baseAppInitRepository.getSpeakingLanguages();
  }
}