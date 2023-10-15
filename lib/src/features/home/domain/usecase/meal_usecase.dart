import 'package:ios_macros/src/features/home/data/dto/item_dto.dart';
import 'package:ios_macros/src/features/home/data/dto/meal_dto.dart';
import 'package:ios_macros/src/features/home/data/repository/create_item_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/create_meal_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/delete_item_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/delete_meal_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/get_meals_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/update_item_repository.dart';
import 'package:ios_macros/src/features/home/domain/model/exceptions/invalid_token_exception.dart';
import 'package:ios_macros/src/features/home/domain/model/item_model.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';

class MealUsecase {
  Future<List<MealModel>> getMeals(String? token) async {
    if (token == null) {
      throw InvalidTokenException();
    }

    final repo = GetMealsRepository();

    final response = await repo.execute(token: token);

    return response;
  }

  Future<MealModel> createMeal(
    String? token,
    MealDTO meal,
  ) async {
    if (token == null) {
      throw InvalidTokenException();
    }

    final repo = CreateMealRepository();

    final response = await repo.execute(
      token: token,
      body: meal.toMap(),
    );

    return response;
  }

  Future<void> deleteMeal(
    String? token,
    String mealId,
  ) async {
    if (token == null) {
      throw InvalidTokenException();
    }

    final repo = DeleteMealRepository();

    await repo.execute(
      token: token,
      queryParams: {'meal_id': mealId},
    );
  }

  Future<ItemModel> createItem(
    String? token,
    ItemDTO item,
  ) async {
    if (token == null) {
      throw InvalidTokenException();
    }

    final repo = CreateItemRepository();

    final response = await repo.execute(
      token: token,
      body: item.toMap(),
    );

    return response;
  }

  Future<ItemModel> updateItem(
      String? token, String itemId, double amount) async {
    if (token == null) {
      throw InvalidTokenException();
    }

    final repo = UpdateItemRepository();

    final response = await repo.execute(token: token, body: {
      'item_id': itemId,
      'amount': amount,
    });

    return response;
  }

  Future<void> deleteItem(String? token, String itemId) async {
    if (token == null) {
      throw InvalidTokenException();
    }

    final repo = DeleteItemRepository();

    await repo.execute(
      token: token,
      queryParams: {
        "item_id": itemId,
      },
    );
  }
}
