// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MealViewmodel on _MealViewmodelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_MealViewmodelBase.isLoading', context: context);

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

  late final _$mealsAtom =
      Atom(name: '_MealViewmodelBase.meals', context: context);

  @override
  ObservableList<MealModel> get meals {
    _$mealsAtom.reportRead();
    return super.meals;
  }

  @override
  set meals(ObservableList<MealModel> value) {
    _$mealsAtom.reportWrite(value, super.meals, () {
      super.meals = value;
    });
  }

  late final _$getMealsAsyncAction =
      AsyncAction('_MealViewmodelBase.getMeals', context: context);

  @override
  Future<void> getMeals(String? token) {
    return _$getMealsAsyncAction.run(() => super.getMeals(token));
  }

  late final _$createMealAsyncAction =
      AsyncAction('_MealViewmodelBase.createMeal', context: context);

  @override
  Future<void> createMeal(String? token) {
    return _$createMealAsyncAction.run(() => super.createMeal(token));
  }

  late final _$deleteMealAsyncAction =
      AsyncAction('_MealViewmodelBase.deleteMeal', context: context);

  @override
  Future<void> deleteMeal(String? token) {
    return _$deleteMealAsyncAction.run(() => super.deleteMeal(token));
  }

  late final _$deleteItemAsyncAction =
      AsyncAction('_MealViewmodelBase.deleteItem', context: context);

  @override
  Future<void> deleteItem(String? token, String itemId) {
    return _$deleteItemAsyncAction.run(() => super.deleteItem(token, itemId));
  }

  late final _$createItemAsyncAction =
      AsyncAction('_MealViewmodelBase.createItem', context: context);

  @override
  Future<void> createItem(String? token, ItemDTO item) {
    return _$createItemAsyncAction.run(() => super.createItem(token, item));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
meals: ${meals}
    ''';
  }
}
