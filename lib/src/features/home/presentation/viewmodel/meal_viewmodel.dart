import 'package:dio/dio.dart';
import 'package:ios_macros/src/features/home/data/dto/item_dto.dart';
import 'package:ios_macros/src/features/home/data/dto/meal_dto.dart';
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
      final response = await _usecase.getMeals(token);

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
  Future<bool> createMeal(String? token, MealDTO meal) async {
    try {
      final newMeal = await _usecase.createMeal(token, meal);

      includeMealSorted(newMeal);
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  @action
  Future<void> deleteMeal(String? token, String mealId) async {
    isLoading = true;

    try {
      await _usecase.deleteMeal(token, mealId);

      meals.removeWhere((element) => element.id == mealId);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteItem(String? token, String itemId) async {
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
    }
  }

  @action
  Future<void> createItem(String? token, ItemDTO item) async {
    isLoading = true;

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

  @action
  void includeMealSorted(MealModel newMeal) {
    Duration timeNew = Duration(hours: newMeal.hour, minutes: newMeal.minutes);

    var i = 0;
    bool insert = false;
    while (i < meals.length) {
      Duration thisTime =
          Duration(hours: meals[i].hour, minutes: meals[i].minutes);

      if (isBefore(timeNew, thisTime)) {
        meals.insert(i, newMeal);
        insert = true;
        break;
      } else {
        i++;
      }
    }
    if (!insert) {
      meals.add(newMeal);
    }
  }

  bool isBefore(Duration time1, Duration time2) {
    int h1 = time1.inHours;
    int h2 = time2.inHours;

    int m1 = time1.inMinutes - (60 * h1);
    int m2 = time2.inMinutes - (60 * h2);

    if (h1 == h2) {
      if (m1 < m2) {
        return true;
      } else {
        return false;
      }
    }

    if (h1 < h2) {
      return true;
    }

    return false;
  }
}
