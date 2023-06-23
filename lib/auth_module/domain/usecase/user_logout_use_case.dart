import '../repository/base_auth_repository.dart';

class UserLogoutUseCase{
  BaseAuthRepository authRepository;

  UserLogoutUseCase(this.authRepository);
  execute() async {
    return await authRepository.userLogout();



  }
}