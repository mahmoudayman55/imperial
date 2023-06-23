import 'package:dartz/dartz.dart';
import 'package:imperial/app_init_module/domain/entities/app_init_entity.dart';
import 'package:imperial/app_init_module/domain/repository/base_app_init_repository.dart';
import '../../../core/utils/nework_exception.dart';

class GetAppInitialUseCase{
final BaseAppInitRepository baseAppInitRepository;

GetAppInitialUseCase(this.baseAppInitRepository);

Future<Either<ErrorMessageModel, AppInitial>>execute()async{
  return await baseAppInitRepository.getAppInitial();



}
}