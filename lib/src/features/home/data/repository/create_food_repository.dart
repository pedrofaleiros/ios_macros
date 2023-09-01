import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/domain/repository/home_repository_interface.dart';
import 'package:ios_macros/src/utils/dio_client.dart';

class CreateFoodRepository implements HomeRepositoryI<FoodModel> {
  @override
  Future<FoodModel> execute(
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParams,
      required String token}) async {
    final dio = DioClient.getDioWithToken(token);
    final response = await dio.post(
      url,
      data: body,
    );

    if (response.statusCode == 200) {
      FoodModel food = FoodModel.fromMap(response.data);
      return food;
    }

    throw Exception('Erro desconhecido createMeal');
  }

  @override
  String get url => '${DioClient.baseUrl}/food';
}
