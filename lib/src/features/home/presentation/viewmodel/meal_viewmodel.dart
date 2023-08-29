import 'package:dio/dio.dart';
import 'package:ios_macros/src/features/home/data/dto/item_dto.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/domain/usecase/meal_usecase.dart';
import 'package:mobx/mobx.dart';
part 'meal_viewmodel.g.dart';

class MealViewmodel = _MealViewmodelBase with _$MealViewmodel;

abstract class _MealViewmodelBase with Store {
  final MealUsecase _usecase = MealUsecase();

  @observable
  bool isLoading = false;

  @observable
  ObservableList<MealModel> meals = <MealModel>[].asObservable();

  @action
  Future<void> getMeals(String? token) async {
    isLoading = true;

    // await Future.delayed(const Duration(milliseconds: 300));

    try {
      final response = await _usecase.get(token);

      meals.clear();

      for (var element in response) {
        meals.add(element);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createMeal(String? token) async {}

  @action
  Future<void> deleteMeal(String? token) async {}

  @action
  Future<void> deleteItem(String? token, String itemId) async {
    isLoading = true;

    try {
      await _usecase.deleteItem(token, itemId);

      for (var i = 0; i < meals.length; i++) {
        for (var j = 0; j < meals[i].items.length; j++) {
          if (meals[i].items[j].id == itemId) {
            meals[i].deleteItem(itemId);
          }
        }
      }
    } on DioException catch (e) {
      print(e.response!.data);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createItem(String? token, ItemDTO item) async {
    isLoading = true;

    // await Future.delayed(const Duration(milliseconds: 300));

    try {
      final response = await _usecase.createItem(token, item);

      int index = meals.indexWhere((element) => element.id == item.mealId);

      meals[index].addItem(response);
    } on DioException catch (e) {
      print(e.response!.data);
    } finally {
      isLoading = false;
    }
  }
}
