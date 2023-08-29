import 'package:ios_macros/src/features/home/data/repository/get_foods_repository.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/domain/usecase/meal_usecase.dart';

class FoodUsecase {
  Future<List<FoodModel>> get(String? token) async {
    if (token == null) {
      throw InvalidTokenException();
    }

    final repo = GetFoodsRepository();

    final response = await repo.execute(token: token);

    return response;
  }

  Future<List<FoodModel>> getWithName(String? token, String? name) async {
    if (token == null) {
      throw InvalidTokenException();
    }

    final repo = GetFoodsRepository();

    final response = await repo.executeWithName(
      token: token,
      queryParams: {
        "name": name ?? '',
      },
    );

    return response;
  }

  @override
  Future<FoodModel> create(String? token) {
    throw UnimplementedError();
  }
}
