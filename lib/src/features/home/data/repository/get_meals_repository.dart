import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model_converter.dart';
import 'package:ios_macros/src/features/home/domain/repository/home_repository_interface.dart';
import 'package:ios_macros/src/utils/dio_client.dart';

class GetMealsRepository implements HomeRepositoryI<List<MealModel>> {
  @override
  String get url => '${DioClient.baseUrl}/meal';

  MealModelConverter converter = MealModelConverter();

  @override
  Future<List<MealModel>> execute({
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    required String token,
  }) async {
    final dio = DioClient.getDioWithToken(token);

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;

      List<MealModel> list = converter.getList(data);

      return list;
    } else {
      throw Exception('Erro desconhecido getMeals');
    }
  }
}
