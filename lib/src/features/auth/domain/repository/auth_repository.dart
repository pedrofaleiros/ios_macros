import 'package:ios_macros/src/features/auth/data/dto/user_dto.dart';
import 'package:ios_macros/src/features/auth/domain/model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(UserDTO user);
  Future<UserModel> signup(UserDTO user);
  Future<UserModel> autoLogin(String token);
}
