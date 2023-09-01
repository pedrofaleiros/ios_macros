// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FoodViewmodel on _FoodViewmodelBase, Store {
  late final _$foodsAtom =
      Atom(name: '_FoodViewmodelBase.foods', context: context);

  @override
  ObservableList<FoodModel> get foods {
    _$foodsAtom.reportRead();
    return super.foods;
  }

  @override
  set foods(ObservableList<FoodModel> value) {
    _$foodsAtom.reportWrite(value, super.foods, () {
      super.foods = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_FoodViewmodelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$getFoodsAsyncAction =
      AsyncAction('_FoodViewmodelBase.getFoods', context: context);

  @override
  Future<void> getFoods(String? token) {
    return _$getFoodsAsyncAction.run(() => super.getFoods(token));
  }

  late final _$getFoodsWithNameAsyncAction =
      AsyncAction('_FoodViewmodelBase.getFoodsWithName', context: context);

  @override
  Future<void> getFoodsWithName(String? token, String? name) {
    return _$getFoodsWithNameAsyncAction
        .run(() => super.getFoodsWithName(token, name));
  }

  late final _$createFoodAsyncAction =
      AsyncAction('_FoodViewmodelBase.createFood', context: context);

  @override
  Future<bool> createFood(String? token, FoodDTO food) {
    return _$createFoodAsyncAction.run(() => super.createFood(token, food));
  }

  late final _$deleteFoodAsyncAction =
      AsyncAction('_FoodViewmodelBase.deleteFood', context: context);

  @override
  Future<void> deleteFood(String? token, String foodId) {
    return _$deleteFoodAsyncAction.run(() => super.deleteFood(token, foodId));
  }

  @override
  String toString() {
    return '''
foods: ${foods},
isLoading: ${isLoading}
    ''';
  }
}
