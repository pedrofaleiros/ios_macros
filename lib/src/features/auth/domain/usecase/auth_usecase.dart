import 'package:ios_macros/src/features/auth/data/dto/user_dto.dart';
import 'package:ios_macros/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ios_macros/src/features/auth/data/repository/shared_preferences_repository.dart';
import 'package:ios_macros/src/features/auth/domain/model/user_model.dart';
import 'package:ios_macros/src/features/auth/domain/repository/auth_repository.dart';

class AuthUsecase {
  final AuthRepository repo = AuthRepositoryImpl();
  final SharedPreferencesRepository sharedPreferencesRepo =
      SharedPreferencesRepository();

  Future<UserModel> autoLogin() async {
    final token = await sharedPreferencesRepo.getToken();

    final responseUser = await repo.autoLogin(token);

    return responseUser;
  }

  Future<UserModel> login(UserDTO user) async {
    // TODO: validate user

    final responseUser = await repo.login(user);

    await sharedPreferencesRepo.setToken(responseUser.token);

    return responseUser;
  }

  Future<UserModel> signup(UserDTO user) async {
    // TODO: validate user

    final responseUser = await repo.signup(user);

    await sharedPreferencesRepo.setToken(responseUser.token);

    return responseUser;
  }

  Future<void> logout() async {
    await sharedPreferencesRepo.logout();
  }
}
