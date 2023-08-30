import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model_converter.dart';
import 'package:ios_macros/src/features/home/domain/repository/home_repository_interface.dart';
import 'package:ios_macros/src/utils/dio_client.dart';

class CreateMealRepository implements HomeRepositoryI<MealModel> {
  @override
  String get url => '${DioClient.baseUrl}/meal';

  MealModelConverter converter = MealModelConverter();

  @override
  Future<MealModel> execute({
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    required String token,
  }) async {
    final dio = DioClient.getDioWithToken(token);
    final response = await dio.post(
      '${DioClient.baseUrl}/meal',
      data: body,
    );

    if (response.statusCode == 200) {
      MealModel newMeal = converter.fromMap(response.data);
      return newMeal;
    }

    throw Exception('Erro desconhecido createMeal');
  }
}
