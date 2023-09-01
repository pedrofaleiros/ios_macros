import 'package:ios_macros/src/features/home/data/dto/food_dto.dart';
import 'package:ios_macros/src/features/home/data/repository/create_food_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/delete_food_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/get_foods_repository.dart';
import 'package:ios_macros/src/features/home/domain/model/exceptions/invalid_token_exception.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';

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

  Future<FoodModel> create(String? token, FoodDTO food) async {
    if (token == null) {
      throw InvalidTokenException();
    }

    validateFood(food);

    final repo = CreateFoodRepository();

    final response = await repo.execute(
      token: token,
      body: food.toMap(),
    );

    return response;
  }

  Future<void> delete(String? token, String foodId) async {
    if (token == null) {
      throw InvalidTokenException();
    }

    final repo = DeleteFoodRepository();

    await repo.execute(token: token, queryParams: {"food_id": foodId});
  }
}

void validateFood(FoodDTO food) {
  if (food.name.length > 30 || food.name.length < 2) {
    throw InvalidFoodException(message: 'Nome invalido');
  }

  if (food.carb < 0 || food.prot < 0 || food.fat < 0 || food.fat < 0) {
    throw InvalidFoodException(message: 'Quantidades invalidas');
  }
}

class InvalidFoodException implements Exception {
  final String? message;

  InvalidFoodException({this.message});

  @override
  String toString() => message ?? 'token null';
}
