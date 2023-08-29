import 'package:ios_macros/src/features/home/domain/repository/home_repository_interface.dart';
import 'package:ios_macros/src/utils/dio_client.dart';

class DeleteMealRepository implements HomeRepositoryI<void> {
  @override
  String get url => '${DioClient.baseUrl}/meal';

  @override
  Future<void> execute({
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    required String token,
  }) async {
    final dio = DioClient.getDioWithToken(token);

    final response = await dio.delete(
      url,
      data: body,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erro desconhecido deleteMeal');
    }
  }
}
