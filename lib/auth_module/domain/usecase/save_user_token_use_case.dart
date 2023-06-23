import '../repository/base_auth_repository.dart';

class SaveUserTokenUseCase{
  BaseAuthRepository authRepository;

  SaveUserTokenUseCase(this.authRepository);
 execute(String userToken) async {
    return await authRepository.saveUserToken(userToken);



  }
}