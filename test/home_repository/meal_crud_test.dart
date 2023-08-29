import 'package:ios_macros/src/features/home/data/dto/meal_dto.dart';
import 'package:ios_macros/src/features/home/data/repository/create_item_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/create_meal_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/delete_item_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/delete_meal_repository.dart';
import 'package:ios_macros/src/features/home/data/repository/get_meals_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Meal Repository', () {
    test('testando crud mealRepository', () async {
      final createMeal = CreateMealRepository();
      final getMeals = GetMealsRepository();
      final deleteMeal = DeleteMealRepository();

      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoicGVkcm9mYWxlaXJvcyIsImVtYWlsIjoicGVkcm9mYWxlaXJvc0BlbWFpbC5jb20uYnIiLCJpYXQiOjE2OTMxNTg1MDgsImV4cCI6MTY5NTc1MDUwOCwic3ViIjoiZjdjMGFjNjQtNTZmZi00MTk0LWI0ODItNGYzNmZhODRhNWFmIn0.pC_6QMCAyAGUuuqPWrYufwRI84DUViMRlJYxXdQm0jg';

      MealDTO meal = MealDTO(
        name: 'teste',
        hour: 3,
        minutes: 59,
      );

      final response = await createMeal.execute(
        body: meal.toMap(),
        queryParams: null,
        token: token,
      );
      expect(response.name, meal.name);
      expect(response.hour, meal.hour);
      expect(response.minutes, meal.minutes);

      await deleteMeal.execute(
        body: null,
        queryParams: {"meal_id": response.id},
        token: token,
      );

      final list = await getMeals.execute(
        body: null,
        queryParams: null,
        token: token,
      );

      final createItem = CreateItemRepository();
      final deleteItem = DeleteItemRepository();

      final item = await createItem.execute(
        body: {
          "food_id": 'fe9a90af-4e74-4eb4-8c54-084c8cbe9a97',
          "meal_id": list[0].id,
          'amount': 42,
        },
        queryParams: null,
        token: token,
      );

      expect(item.amount, 42);

      await deleteItem.execute(
        body: null,
        queryParams: {"item_id": item.id},
        token: token,
      );

      list.forEach((element) {
        print(element.name);
      });
    });
  });
}
