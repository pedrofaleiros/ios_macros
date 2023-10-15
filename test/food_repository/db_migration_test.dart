// ignore_for_file: unused_local_variable

import 'package:ios_macros/src/features/home/data/repository/get_foods_repository.dart';
import 'package:test/test.dart';
import 'package:dio/dio.dart';

void main() {
  group('Foods Repository', () {
    test('testando get foods Repository', () async {
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoicGVkcm9mYWxlaXJvcyIsImVtYWlsIjoicGVkcm9mYWxlaXJvc0BlbWFpbC5jb20uYnIiLCJpYXQiOjE2OTMxNTg1MDgsImV4cCI6MTY5NTc1MDUwOCwic3ViIjoiZjdjMGFjNjQtNTZmZi00MTk0LWI0ODItNGYzNmZhODRhNWFmIn0.pC_6QMCAyAGUuuqPWrYufwRI84DUViMRlJYxXdQm0jg';

      final repo = GetFoodsRepository();

      final response = await repo.execute(token: token);

      const baseUrl = 'http://192.168.0.154:3333';

      final dio = Dio();
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
      dio.options.connectTimeout = const Duration(seconds: 5);
      dio.options.receiveTimeout = const Duration(seconds: 5);

      // for (var element in response) {
      //   final response = await dio.post('$baseUrl/food', data: element.toMap());
      //   if (response.statusCode == 200) {
      //     print('OK: ${element.name}');
      //   }
      // }
    });
  });
}
