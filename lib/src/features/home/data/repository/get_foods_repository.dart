import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/domain/repository/home_repository_interface.dart';
import 'package:ios_macros/src/utils/dio_client.dart';

class GetFoodsRepository implements HomeRepositoryI<List<FoodModel>> {
  @override
  String get url => '${DioClient.baseUrl}/food';

  @override
  Future<List<FoodModel>> execute({
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    required String token,
  }) async {
    final dio = DioClient.getDioWithToken(token);
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      final list = <FoodModel>[];
      for (var i = 0; i < data.length; i++) {
        FoodModel food = FoodModel.fromMap(data[i]);
        list.add(food);
      }
      return list;
    }

    throw Exception('Erro desconhecido getFoods');
  }

  Future<List<FoodModel>> executeWithName({
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    required String token,
  }) async {
    final dio = DioClient.getDioWithToken(token);
    final response = await dio.get(
      '$url/search',
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      final list = <FoodModel>[];
      for (var i = 0; i < data.length; i++) {
        FoodModel food = FoodModel.fromMap(data[i]);
        list.add(food);
      }
      return list;
    }

    throw Exception('Erro desconhecido getFoodsWithName');
  }
}
