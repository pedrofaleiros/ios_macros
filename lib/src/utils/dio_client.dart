import 'package:dio/dio.dart';

class DioClient {
  static const baseUrl = 'http://172.30.129.176:3335';

  static Dio getDio() {
    final dio = Dio();

    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 5);

    return dio;
  }

  static Dio getDioWithToken(String token) {
    final dio = getDio();

    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    return dio;
  }

  static Exception handleDioException(DioException e) {
    if (e.response != null) {
      if (e.response!.statusCode == 401) {
        return NotAuthorizedException('Não autorizado');
      } else if (e.response!.statusCode == 400) {
        return Exception('Erro 400');
      }
    }
    return Exception(e.toString());
  }
}

class NotAuthorizedException implements Exception {
  final String message;

  NotAuthorizedException(this.message);

  @override
  String toString() => message;
}
