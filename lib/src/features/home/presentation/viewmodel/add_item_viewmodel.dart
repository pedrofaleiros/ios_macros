// ignore_for_file: library_private_types_in_public_api

import 'package:ios_macros/src/features/home/domain/model/food_model.dart';

import 'package:mobx/mobx.dart';
part 'add_item_viewmodel.g.dart';

class AddItemViewmodel = _AddItemViewmodelBase with _$AddItemViewmodel;

abstract class _AddItemViewmodelBase with Store {
  @observable
  FoodModel? food;

  @action
  void copy(FoodModel newFood) {
    if (food == null) {
      food = newFood;
    } else {
      if (newFood.id == food!.id) {
        clear();
      } else {
        food = newFood;
      }
    }
  }

  @action
  void clear() {
    food = null;
  }
}
