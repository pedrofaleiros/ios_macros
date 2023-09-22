import 'package:ios_macros/src/features/auth/data/dto/user_dto.dart';
import 'package:ios_macros/src/features/auth/domain/model/user_model.dart';
import 'package:ios_macros/src/features/auth/domain/repository/auth_repository.dart';
import 'package:ios_macros/src/utils/dio_client.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel> autoLogin(String token) async {
    final dio = DioClient.getDioWithToken(token);
    final response = await dio.get('${DioClient.baseUrl}/me');
    return UserModel.fromMapWithoutToken(response.data, token);
  }

  @override
  Future<UserModel> login(UserDTO user) async {
    final dio = DioClient.getDio();
    const url = "${DioClient.baseUrl}/session-name";
    final data = user.toMap();
    final response = await dio.post(
      url,
      data: data,
    );
    return UserModel.fromMap(response.data);
  }

  @override
  Future<void> signup(UserDTO user) async {
    final dio = DioClient.getDio();
    const url = "${DioClient.baseUrl}/user";
    final data = user.toMap();
    await dio.post(url, data: data);
  }
}
