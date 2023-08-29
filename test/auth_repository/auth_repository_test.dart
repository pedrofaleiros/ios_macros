import 'dart:math';

import 'package:dio/dio.dart';
import 'package:ios_macros/src/features/auth/data/dto/user_dto.dart';
import 'package:ios_macros/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ios_macros/src/features/auth/domain/repository/auth_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Auth Repository', () {
    test('testando login e signup', () async {
      final AuthRepository repo = AuthRepositoryImpl();

      int random = Random.secure().nextInt(10000);
      UserDTO user = UserDTO(
        name: 'user$random',
        password: 'password123',
        email: "email$random@email.com",
      );

      try {
        var resUser = await repo.signup(user);
        expect(resUser.name, user.name);
      } on DioException catch (e) {
        print(e.toString());
        print(e.response!.data);
      }
    });
  });
}
