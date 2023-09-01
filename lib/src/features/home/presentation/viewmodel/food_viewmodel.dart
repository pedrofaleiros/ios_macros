import 'package:ios_macros/src/features/home/data/dto/food_dto.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/domain/usecase/food_usecase.dart';
import 'package:mobx/mobx.dart';
part 'food_viewmodel.g.dart';

class FoodViewmodel = _FoodViewmodelBase with _$FoodViewmodel;

abstract class _FoodViewmodelBase with Store {
  final FoodUsecase _usecase = FoodUsecase();

  @observable
  ObservableList<FoodModel> foods = <FoodModel>[].asObservable();

  @observable
  bool isLoading = false;

  @action
  Future<void> getFoods(String? token) async {
    isLoading = true;

    try {
      final response = await _usecase.get(token);

      foods.clear();

      for (var element in response) {
        foods.add(element);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> getFoodsWithName(String? token, String? name) async {
    isLoading = true;

    try {
      final response = await _usecase.getWithName(token, name);

      foods.clear();

      for (var element in response) {
        foods.add(element);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> createFood(String? token, FoodDTO food) async {
    isLoading = true;

    try {
      final response = await _usecase.create(token, food);

      await getFoods(token);
      // foods.add(response);

      isLoading = false;
      return true;
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
    return false;
  }

  @action
  Future<void> deleteFood(String? token, String foodId) async {
    isLoading = true;

    try {
      await _usecase.delete(token, foodId);

      foods.removeWhere((element) => element.id == foodId);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }
}
